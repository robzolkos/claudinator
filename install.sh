#!/usr/bin/env bash

# install.sh - Claude MCP (Model Context Protocol) servers installation script
# This script installs essential MCP servers for Claude development environment

set -uo pipefail  # Exit on undefined variables and pipe failures (removed -e)

# ANSI color codes for output formatting
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function to print colored output
print_info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

# Function to check if a command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Main installation function
main() {
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo "          Claude MCP Servers Installation Script"
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo

    # Check prerequisites
    print_info "Checking prerequisites..."
    
    if ! command_exists claude; then
        print_error "Claude CLI is not installed or not in PATH"
        print_info "Please install Claude CLI first: https://docs.anthropic.com/en/docs/claude-code"
        exit 1
    fi
    print_success "Claude CLI found"
    
    if ! command_exists npx; then
        print_error "npx is not installed (requires Node.js)"
        print_info "Please install Node.js: https://nodejs.org/"
        exit 1
    fi
    print_success "npx found"
    
    echo
    print_info "This script will install the following MCP servers:"
    echo "  • Playwright - Web automation and browser testing"
    echo "  • Context7 - Documentation retrieval for libraries"
    echo "  • Whois - Domain and IP information lookup"
    echo
    
    print_info "Starting installation..."
    echo

    # Function to install or verify MCP server
    install_mcp_server() {
        local name="$1"
        local cmd="$2"
        
        print_info "Installing $name MCP server..."
        
        # Check if already exists
        if claude mcp list | grep -q "^$name\s"; then
            print_success "$name MCP server is already installed!"
            return 0
        fi
        
        # Try to install, capture output
        local output
        output=$(eval "claude mcp add $name -s user $cmd" 2>&1)
        local exit_code=$?
        
        if [[ $exit_code -eq 0 ]]; then
            print_success "$name MCP server installed successfully"
        elif [[ $output == *"already exists"* ]]; then
            print_success "$name MCP server is already installed!"
        else
            print_error "Failed to install $name MCP server: $output"
            return 1
        fi
    }
    
    # Track installation results
    local failed_count=0
    
    # Install Playwright MCP server
    if ! install_mcp_server "playwright" "npx @playwright/mcp@latest"; then
        ((failed_count++))
    fi
    echo

    # Install Context7 MCP server
    if ! install_mcp_server "context7" "-- npx -y @upstash/context7-mcp"; then
        ((failed_count++))
    fi
    echo

    # Install Whois MCP server
    if ! install_mcp_server "whois" "npx @bharathvaj/whois-mcp@latest"; then
        ((failed_count++))
    fi
    echo

    echo
    print_info "Installed MCP servers:"
    claude mcp list
    echo
    
    if [[ $failed_count -eq 0 ]]; then
        print_success "All MCP servers installed successfully!"
    else
        print_warning "$failed_count MCP server(s) failed to install. Check the errors above."
    fi
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
}

# Trap errors and display helpful message
trap 'print_error "Installation failed. Please check the error messages above."' ERR

# Run the main function
main
