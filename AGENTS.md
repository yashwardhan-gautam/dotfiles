# AGENT GUIDE (read before editing)
1. Prefer `nixos-rebuild switch --flake .#T16-hyprland` for full system builds; use `-L` to see logs.
2. Run `home-manager switch --flake .#unalome` for user-level iterations.
3. Fast rebuild via `nix build .#nixosConfigurations.T16-hyprland.config.system.build.toplevel`.
4. Validate flakes and dependencies with `nix flake check` before landing changes.
5. Targeted test: `nixos-rebuild test --flake .#T16-hyprland` exercises the host without switching.
6. Use `nix fmt`/`alejandra` for every `.nix` file you touch.
7. Lua files respect `stylua.toml` (2 spaces, max 100 cols); run `stylua home/programs/neovim/lazyvim`.
8. Python code: `ruff check . && ruff format` (compatible with black + isort).
9. Shell snippets: `shfmt -w` plus `shellcheck` for linting.
10. Prettier formats JSON/YAML/Markdown; stay near 100-column soft limit.
11. Order imports as local (`./`), repo modules, then external inputs; keep related items grouped.
12. Use `lib.mkIf`, `lib.optionals`, and attrset merges instead of inline imperative logic.
13. Prefer kebab/snake-case attribute names; avoid camelCase except in upstream APIs.
14. Keep modules declarative: no side-effecting `builtins.*` except guarded debug output.
15. Expose toggles via `config` options; avoid hardcoding host/home specifics in shared modules.
16. Guard risky settings with `assertions` or defaults (`lib.mkDefault`); fail fast on invalid combos.
17. Never commit secrets; keep machine-local overrides in ignored files like `user-config.nix`.
18. Document non-obvious values inline so future edits understand why.
19. Align lists/attrsets alphabetically where sane, keep inline comments after values, and note no Cursor/Copilot rules exist—follow this file.
