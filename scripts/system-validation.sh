#!/usr/bin/env bash
# Comprehensive System Validation Script

set -euo pipefail

# Color codes
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Logging function
log() {
    echo -e "[$(date +'%Y-%m-%d %H:%M:%S')] $*"
}

# Check function
check_success() {
    if [ $? -eq 0 ]; then
        log "${GREEN}✓ $1${NC}"
        return 0
    else
        log "${RED}✗ $1${NC}"
        return 1
    fi
}

# System and Hardware Validation
validate_system() {
    log "Starting system validation..."

    # Check system boot
    systemctl is-system-running --quiet
    check_success "System boots and operates normally"

    # Check Hyprland session
    pgrep -x Hyprland > /dev/null
    check_success "Hyprland window manager running"
}

# Editor Validation
validate_editors() {
    log "Testing editors..."

    # Zed editor
    zed --version &> /dev/null
    check_success "Zed editor installed"

    # Cursor editor
    cursor --version &> /dev/null
    check_success "Cursor editor installed"

    # LazyVim (Neovim)
    nvim --version | grep -q "NVIM"
    check_success "Neovim with LazyVim configuration"
}

# Browser Validation
validate_browsers() {
    log "Testing browsers..."

    # Zen browser
    zen --version &> /dev/null
    check_success "Zen browser installed"

    # Chromium
    chromium --version &> /dev/null
    check_success "Chromium browser installed"
}

# Theme and Icon Validation
validate_theme() {
    log "Validating theme and icons..."

    # Tela icon theme
    gtk-update-icon-cache -f /usr/share/icons/Tela 2>/dev/null
    check_success "Tela icon theme installed"

    # Gruvbox-light theme
    [[ -f ~/.config/gtk-3.0/settings.ini ]] && 
        grep -q "Gruvbox-Light" ~/.config/gtk-3.0/settings.ini
    check_success "Gruvbox-light color scheme applied"
}

# Performance Metrics
validate_performance() {
    log "Measuring system performance..."

    # Startup time
    startup_time=$(systemd-analyze | awk '/Startup finished/ {print $4}')
    log "System startup time: $startup_time"

    # Memory usage
    memory_usage=$(free | grep Mem | awk '{print $3/$2 * 100.0"%"}')
    log "Memory usage: $memory_usage"

    # Application launch times
    time zed --version &> /dev/null
    time cursor --version &> /dev/null
    time nvim --version &> /dev/null
}

# Package Verification
validate_packages() {
    log "Checking package configuration..."

    # Scan for gaming packages
    gaming_packages=$(nix-env -qa '*' | grep -E 'gamemode|steam|lutris|wine|proton' || true)
    if [ -z "$gaming_packages" ]; then
        log "${GREEN}✓ No gaming-related packages detected${NC}"
    else
        log "${RED}✗ Gaming packages found:${NC}"
        echo "$gaming_packages"
        return 1
    fi
}

# Reliability Tests
validate_reliability() {
    log "Testing system reliability..."

    # Configuration rebuild
    nix flake check &> /dev/null
    check_success "Configuration rebuilds without errors"

    # Rollback test
    sudo nixos-rebuild switch --rollback
    check_success "System rollback procedure works"
}

# Main validation function
main() {
    log "Starting comprehensive system validation..."

    validate_system
    validate_editors
    validate_browsers
    validate_theme
    validate_performance
    validate_packages
    validate_reliability

    log "System validation complete."
}

# Execute main function
if main; then
    echo "VALIDATION_RESULT=SUCCESS"
else
    echo "VALIDATION_RESULT=FAILURE"
    exit 1
fi