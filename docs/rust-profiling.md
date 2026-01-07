# Rust Profiling Tools Guide

This guide covers profiling tools installed in this NixOS configuration for Rust development.

## Quick Reference

| Tool | Best For | Command |
|------|----------|---------|
| `perf` | CPU profiling, hotspots | `perf record ./target/release/app` |
| `flamegraph` | Visual call stacks | `cargo flamegraph` |
| `heaptrack` | Memory allocations | `heaptrack ./target/release/app` |
| `valgrind` | Memory leaks, errors | `valgrind ./target/release/app` |
| `cachegrind` | Cache performance | `valgrind --tool=cachegrind ./app` |
| `coz` | Causal profiling | `coz run --- ./target/release/app` |

---

## Prerequisites

Before profiling, build your Rust project in **release mode with debug symbols**:

```toml
# Cargo.toml
[profile.release]
debug = true  # Include debug symbols for meaningful stack traces
```

Then build:
```bash
cargo build --release
```

---

## 1. Perf (Linux Performance Counters)

**What it does**: Low-level CPU profiling using hardware performance counters. Shows where CPU time is spent.

### Basic Usage

```bash
# Record performance data
perf record -g ./target/release/my_app

# View the report
perf report

# Record with call graph (dwarf for better Rust support)
perf record -g --call-graph dwarf ./target/release/my_app
```

### Common Options

```bash
# Profile for specific duration
perf record -g --duration 10 ./target/release/my_app

# Profile with frequency (samples per second)
perf record -F 99 -g ./target/release/my_app

# Stat mode (quick overview)
perf stat ./target/release/my_app
```

### Output

```
+  15.23%  my_app  my_app          [.] my_crate::heavy_function
+  12.45%  my_app  libc.so.6       [.] malloc
+   8.32%  my_app  my_app          [.] core::str::pattern::...
```

---

## 2. Flamegraph (cargo-flamegraph)

**What it does**: Generates interactive SVG visualizations of where CPU time is spent. Built on top of `perf`.

### Basic Usage

```bash
# Generate flamegraph for the default binary
cargo flamegraph

# For a specific binary
cargo flamegraph --bin my_binary

# For benchmarks
cargo flamegraph --bench my_benchmark

# With specific arguments
cargo flamegraph -- arg1 arg2
```

### Options

```bash
# Output to specific file
cargo flamegraph -o profile.svg

# Reverse flamegraph (icicle graph)
cargo flamegraph --reverse

# Include idle time
cargo flamegraph --no-inline
```

### Viewing

Open the generated `flamegraph.svg` in a browser. Click on stacks to zoom in.

**Reading Flamegraphs**:
- Width = time spent in that function (including children)
- Wider = more time spent
- Stack grows upward (callers at bottom, callees at top)
- Click to zoom, hover for details

---

## 3. Heaptrack

**What it does**: Tracks heap memory allocations. Shows where memory is allocated, how much, and identifies leaks.

### Basic Usage

```bash
# Profile the application
heaptrack ./target/release/my_app

# This creates a file like: heaptrack.my_app.12345.zst

# Analyze with GUI
heaptrack_gui heaptrack.my_app.12345.zst

# Or analyze in terminal
heaptrack_print heaptrack.my_app.12345.zst
```

### What to Look For

- **Peak heap usage**: Maximum memory used
- **Total allocations**: Number of malloc calls
- **Leaked memory**: Memory not freed
- **Allocation hotspots**: Functions allocating the most

### Terminal Output Example

```bash
heaptrack_print heaptrack.my_app.12345.zst | head -50
```

---

## 4. Valgrind

**What it does**: Instrumentation framework for memory debugging. Detects memory leaks, invalid reads/writes, use of uninitialized memory.

### Memcheck (Default Tool)

```bash
# Basic memory check
valgrind ./target/release/my_app

# With leak checking
valgrind --leak-check=full ./target/release/my_app

# More verbose output
valgrind --leak-check=full --show-leak-kinds=all ./target/release/my_app

# Track origins of uninitialized values
valgrind --track-origins=yes ./target/release/my_app
```

### Output Example

```
==12345== LEAK SUMMARY:
==12345==    definitely lost: 1,024 bytes in 2 blocks
==12345==    indirectly lost: 0 bytes in 0 blocks
==12345==    possibly lost: 0 bytes in 0 blocks
==12345==    still reachable: 8,192 bytes in 4 blocks
```

### Notes for Rust

- Rust's memory safety means fewer issues, but FFI code and unsafe blocks benefit
- Useful for detecting issues in C dependencies
- ~10-50x slower than normal execution

---

## 5. Cachegrind (Part of Valgrind)

**What it does**: Simulates CPU cache behavior. Identifies cache misses that cause performance problems.

### Basic Usage

```bash
# Run cachegrind
valgrind --tool=cachegrind ./target/release/my_app

# This creates: cachegrind.out.12345

# Annotate source code with cache info
cg_annotate cachegrind.out.12345

# Compare two runs
cg_diff cachegrind.out.12345 cachegrind.out.12346
```

### Understanding Output

```
I   refs:      1,234,567,890   # Instruction references
I1  misses:          123,456   # L1 instruction cache misses
LLi misses:           12,345   # Last-level instruction cache misses
I1  miss rate:          0.01%
LLi miss rate:          0.00%

D   refs:        456,789,012   # Data references
D1  misses:        1,234,567   # L1 data cache misses
LLd misses:          123,456   # Last-level data cache misses
D1  miss rate:          0.27%
LLd miss rate:          0.02%
```

**High miss rates indicate**:
- Poor data locality
- Large working sets
- Inefficient memory access patterns

---

## 6. Coz (Causal Profiler)

**What it does**: Unique profiler that tells you what to optimize by virtually speeding up code sections and measuring impact on overall performance.

### Setup (Per-Project)

Add to `Cargo.toml`:

```toml
[dependencies]
coz = "0.1"
```

Add progress points in your code:

```rust
use coz;

fn main() {
    loop {
        do_work();
        coz::progress!();  // Mark progress (throughput measurement)
    }
}

fn critical_section() {
    coz::scope!("critical_section");  // Mark a scope for latency measurement
    // ... expensive code ...
}
```

### Running

```bash
# Run with coz
coz run --- ./target/release/my_app

# Output goes to profile.coz by default
```

### Viewing Results

```bash
# Open the web viewer
coz plot
# Then open http://localhost:8080 and load profile.coz
```

### Interpreting Results

Coz shows:
- **Line speedup %**: If you sped up this line by X%, overall speedup would be Y%
- **Virtual speedup**: What would happen if code ran faster
- Prioritize lines with highest impact-to-effort ratio

---

## Workflow Recommendations

### Quick Performance Check
```bash
cargo flamegraph
# Open flamegraph.svg in browser
```

### Memory Issues
```bash
# First, check for leaks
valgrind --leak-check=full ./target/release/my_app

# Then profile allocations
heaptrack ./target/release/my_app
heaptrack_gui heaptrack.*.zst
```

### CPU Optimization
```bash
# 1. Get overview with flamegraph
cargo flamegraph

# 2. Deep dive with perf
perf record -g ./target/release/my_app
perf report

# 3. Find what to optimize with coz
coz run --- ./target/release/my_app
```

### Cache Performance
```bash
valgrind --tool=cachegrind ./target/release/my_app
cg_annotate cachegrind.out.*
```

---

## Tips

1. **Always profile release builds** - Debug builds have completely different performance characteristics

2. **Use `debug = true` in release profile** - Needed for meaningful stack traces

3. **Run multiple times** - Performance can vary; look for consistent patterns

4. **Profile realistic workloads** - Small test cases may not reveal real bottlenecks

5. **Flamegraph first** - Start with flamegraph for quick visual overview, then dive deeper

6. **Watch for allocations** - In Rust, excessive allocations are often the main bottleneck

---

## Troubleshooting

### Perf: "Permission denied" or no kernel symbols
```bash
# Allow perf for all users (run as root)
echo 0 | sudo tee /proc/sys/kernel/perf_event_paranoid
```

### Flamegraph: No output or empty
- Ensure `debug = true` in release profile
- Check that `perf` is working: `perf record ls`

### Valgrind: Too slow
- Valgrind instruments every instruction; 10-50x slowdown is normal
- Use smaller test inputs for profiling

### Heaptrack: GUI won't open
```bash
# Use terminal analysis instead
heaptrack_print heaptrack.*.zst | less
```

---

## Sample bacon.toml

This configuration replaces default bacon jobs with profiling-focused workflows. Copy this to your project root as `bacon.toml`.

```toml
# bacon.toml - Profiling-focused configuration
# Run with: bacon <job_name>

# =============================================================================
# DEFAULT JOB (what runs when you just type `bacon`)
# =============================================================================
default_job = "clippy"

# =============================================================================
# CORE JOBS
# =============================================================================

[jobs.clippy]
command = ["cargo", "clippy", "--all-targets", "--all-features", "--", "-W", "clippy::pedantic"]
need_stdout = false
watch = ["src", "tests", "benches", "examples"]

[jobs.check]
command = ["cargo", "check", "--all-targets", "--all-features"]
need_stdout = false
watch = ["src", "tests", "benches", "examples"]

[jobs.test]
command = ["cargo", "nextest", "run", "--all-features"]
need_stdout = true
watch = ["src", "tests"]

[jobs.doc]
command = ["cargo", "doc", "--no-deps", "--all-features"]
need_stdout = false

[jobs.run]
command = ["cargo", "run", "--release"]
need_stdout = true
background = true
watch = ["src"]

# =============================================================================
# BUILD JOBS
# =============================================================================

[jobs.build-release]
command = ["cargo", "build", "--release"]
need_stdout = false
watch = ["src"]

[jobs.build-debug]
command = ["cargo", "build"]
need_stdout = false
watch = ["src"]

# =============================================================================
# PROFILING JOBS
# =============================================================================

# Flamegraph - Visual CPU profiling (generates flamegraph.svg)
[jobs.flamegraph]
command = ["cargo", "flamegraph", "-o", "flamegraph.svg"]
need_stdout = true
allow_warnings = true
on_success = "job:open-flamegraph"

[jobs.open-flamegraph]
command = ["xdg-open", "flamegraph.svg"]
need_stdout = false
background = true

# Perf - CPU profiling with hardware counters
[jobs.perf]
command = [
    "sh", "-c",
    "cargo build --release && perf record -g --call-graph dwarf ./target/release/$(cargo metadata --format-version 1 | jq -r '.resolve.root | split(\" \")[0]')"
]
need_stdout = true
allow_warnings = true

[jobs.perf-report]
command = ["perf", "report"]
need_stdout = true

[jobs.perf-stat]
command = [
    "sh", "-c",
    "cargo build --release && perf stat ./target/release/$(cargo metadata --format-version 1 | jq -r '.resolve.root | split(\" \")[0]')"
]
need_stdout = true

# Heaptrack - Memory allocation profiling
[jobs.heaptrack]
command = [
    "sh", "-c",
    "cargo build --release && heaptrack ./target/release/$(cargo metadata --format-version 1 | jq -r '.resolve.root | split(\" \")[0]')"
]
need_stdout = true
allow_warnings = true

[jobs.heaptrack-gui]
command = ["sh", "-c", "heaptrack_gui heaptrack.*.zst 2>/dev/null || echo 'No heaptrack files found. Run bacon heaptrack first.'"]
need_stdout = true
background = true

[jobs.heaptrack-print]
command = ["sh", "-c", "heaptrack_print heaptrack.*.zst 2>/dev/null | head -100 || echo 'No heaptrack files found.'"]
need_stdout = true

# Valgrind - Memory leak detection
[jobs.valgrind]
command = [
    "sh", "-c",
    "cargo build --release && valgrind --leak-check=full --show-leak-kinds=all ./target/release/$(cargo metadata --format-version 1 | jq -r '.resolve.root | split(\" \")[0]')"
]
need_stdout = true
allow_warnings = true

[jobs.valgrind-quick]
command = [
    "sh", "-c",
    "cargo build --release && valgrind ./target/release/$(cargo metadata --format-version 1 | jq -r '.resolve.root | split(\" \")[0]')"
]
need_stdout = true

# Cachegrind - CPU cache profiling
[jobs.cachegrind]
command = [
    "sh", "-c",
    "cargo build --release && valgrind --tool=cachegrind ./target/release/$(cargo metadata --format-version 1 | jq -r '.resolve.root | split(\" \")[0]')"
]
need_stdout = true
allow_warnings = true

[jobs.cachegrind-annotate]
command = ["sh", "-c", "cg_annotate cachegrind.out.* 2>/dev/null | head -200 || echo 'No cachegrind files found.'"]
need_stdout = true

# Coz - Causal profiler (requires coz crate in Cargo.toml)
[jobs.coz]
command = [
    "sh", "-c",
    "cargo build --release && coz run --- ./target/release/$(cargo metadata --format-version 1 | jq -r '.resolve.root | split(\" \")[0]')"
]
need_stdout = true
allow_warnings = true

[jobs.coz-plot]
command = ["coz", "plot"]
need_stdout = true
background = true

# =============================================================================
# BENCHMARK JOBS
# =============================================================================

[jobs.bench]
command = ["cargo", "bench"]
need_stdout = true

[jobs.bench-flamegraph]
command = ["cargo", "flamegraph", "--bench", "benchmarks", "-o", "bench-flamegraph.svg"]
need_stdout = true
allow_warnings = true

# =============================================================================
# UTILITY JOBS
# =============================================================================

[jobs.clean]
command = ["cargo", "clean"]
need_stdout = false

[jobs.clean-profiling]
command = [
    "sh", "-c",
    "rm -f flamegraph.svg perf.data perf.data.old cachegrind.out.* heaptrack.*.zst profile.coz && echo 'Cleaned profiling artifacts'"
]
need_stdout = true

[jobs.size]
command = [
    "sh", "-c",
    "cargo build --release && ls -lh ./target/release/$(cargo metadata --format-version 1 | jq -r '.resolve.root | split(\" \")[0]') | awk '{print \"Binary size: \" $5}'"
]
need_stdout = true

[jobs.bloat]
command = ["cargo", "bloat", "--release", "-n", "20"]
need_stdout = true

# =============================================================================
# KEYBINDINGS (available in bacon TUI)
# =============================================================================

[keybindings]
f = "job:flamegraph"
p = "job:perf"
P = "job:perf-report"
h = "job:heaptrack"
H = "job:heaptrack-gui"
v = "job:valgrind"
c = "job:cachegrind"
C = "job:clean-profiling"
```

### Bacon Jobs Quick Reference

| Key | Job | Description |
|-----|-----|-------------|
| `f` | `flamegraph` | Generate CPU flamegraph SVG |
| `p` | `perf` | Record perf data |
| `P` | `perf-report` | View perf report |
| `h` | `heaptrack` | Profile heap allocations |
| `H` | `heaptrack-gui` | Open heaptrack GUI |
| `v` | `valgrind` | Full memory leak check |
| `c` | `cachegrind` | CPU cache profiling |
| `C` | `clean-profiling` | Remove profiling artifacts |

### Usage

```bash
# Start bacon with default job (clippy)
bacon

# Run specific profiling job
bacon flamegraph
bacon heaptrack
bacon valgrind
bacon cachegrind

# Or use keybindings in bacon TUI
# Press 'f' for flamegraph, 'h' for heaptrack, etc.
```

### Notes

1. **Binary detection**: Jobs auto-detect your binary name using `cargo metadata`
2. **Dependencies**: Requires `jq` for binary name extraction
3. **cargo-bloat**: Install with `cargo install cargo-bloat` for the `bloat` job
4. **coz job**: Requires `coz` crate added to your `Cargo.toml`

