#!/usr/bin/env bash
# ~/.vim/config/install.sh
# Minimal setup script to ensure required tools for Vim plugins (like coc.nvim, vim-dadbod, etc.)

set -e

echo "🚀 Vim environment setup starting..."

# -----------------------------------------------------------------------------
# Basic environment info
# -----------------------------------------------------------------------------
echo "🖥️  Running on native Linux environment (Ubuntu detected)."

# -----------------------------------------------------------------------------
# Full-featured Vim installation (vim-gtk3)
# -----------------------------------------------------------------------------
echo ""
echo "🔍 Checking for full Vim installation (vim-gtk3)..."

has_clipboard_support() {
  vim --version 2>/dev/null | grep -q "+clipboard"
}

if has_clipboard_support; then
  echo "✅ Full Vim with clipboard support already installed."
else
  echo "⚙️  Installing full-featured Vim (vim-gtk3)..."

  echo "🧹 Removing minimal Vim packages (vim-tiny, vim-nox)..."
  sudo apt-get remove -y vim-tiny vim-nox >/dev/null 2>&1 || true

  echo "📦 Installing vim-gtk3..."
  sudo apt-get update -qq
  sudo apt-get install -y vim-gtk3 >/dev/null

  echo "🔄 Setting vim-gtk3 as default system vim..."
  if update-alternatives --list vim >/dev/null 2>&1; then
    sudo update-alternatives --set vim /usr/bin/vim.gtk3 2>/dev/null || true
  fi

  echo "✅ Vim upgraded successfully!"
  vim --version | head -n 1
  vim --version | grep clipboard
fi

# -----------------------------------------------------------------------------
# vim-plug setup (plugin manager)
# -----------------------------------------------------------------------------
echo ""
echo "🔍 Checking for vim-plug (Vim plugin manager)..."

if [ ! -f ~/.vim/autoload/plug.vim ]; then
  echo "📦 Installing vim-plug..."
  curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim >/dev/null 2>&1

  if [ -f ~/.vim/autoload/plug.vim ]; then
    echo "✅ vim-plug installed successfully!"
  else
    echo "❌ Failed to install vim-plug. Please check your internet connection."
  fi
else
  echo "✅ vim-plug already installed at ~/.vim/autoload/plug.vim"
fi

# -----------------------------------------------------------------------------
# fzf setup (for fuzzy file finding)
# -----------------------------------------------------------------------------
echo ""
echo "🔍 Checking for fzf..."

if command -v fzf >/dev/null 2>&1; then
  echo "✅ fzf already installed: $(fzf --version)"
else
  echo "📦 Installing fzf (fuzzy finder)..."
  sudo apt-get update -qq
  sudo apt-get install -y fzf >/dev/null
  echo "🎉 fzf installed successfully: $(fzf --version)"
fi

# -----------------------------------------------------------------------------
# ripgrep setup (for fast file content searching)
# -----------------------------------------------------------------------------
echo ""
echo "🔍 Checking for ripgrep..."

if command -v rg >/dev/null 2>&1; then
  echo "✅ ripgrep already installed: $(rg --version | head -n 1)"
else
  echo "📦 Installing ripgrep (fast search tool)..."
  sudo apt-get update -qq
  sudo apt-get install -y ripgrep >/dev/null
  echo "🎉 ripgrep installed successfully: $(rg --version | head -n 1)"
fi

# -----------------------------------------------------------------------------
# Node.js setup (for coc.nvim and other dev tools)
# -----------------------------------------------------------------------------
echo ""
echo "🔍 Checking for Node.js..."

if command -v node >/dev/null 2>&1; then
  echo "✅ Node.js detected: $(node -v)"
else
  echo "📦 Installing Node.js LTS..."
  curl -fsSL https://deb.nodesource.com/setup_lts.x | sudo -E bash - >/dev/null
  sudo apt-get install -y nodejs >/dev/null
  echo "✅ Node.js installed: $(node -v)"
fi

# -----------------------------------------------------------------------------
# sqlcmd setup (for vim-dadbod and SQL work)
# -----------------------------------------------------------------------------
echo ""
echo "🔍 Checking for sqlcmd..."

add_sqlcmd_path() {
  if ! echo "$PATH" | grep -q "/opt/mssql-tools18/bin"; then
    export PATH="$PATH:/opt/mssql-tools18/bin"
    echo "   ✅ Added /opt/mssql-tools18/bin to PATH (temporary)."
  fi

  if ! grep -q "/opt/mssql-tools18/bin" ~/.bashrc 2>/dev/null; then
    echo 'export PATH="$PATH:/opt/mssql-tools18/bin"' >> ~/.bashrc
    echo "   📁 Persisted PATH update to ~/.bashrc"
  fi
}

if command -v sqlcmd >/dev/null 2>&1 || [ -x /opt/mssql-tools18/bin/sqlcmd ]; then
  echo "✅ sqlcmd already installed."
  add_sqlcmd_path
else
  echo "📦 Installing mssql-tools18..."

  sudo rm -f /etc/apt/sources.list.d/microsoft-prod.list || true

  if [ ! -f /etc/apt/sources.list.d/mssql-release.list ]; then
    echo "➕ Adding Microsoft SQL Server repository..."

    # Create Microsoft GPG keyring (modern, apt-key deprecated)
    curl -sSL https://packages.microsoft.com/keys/microsoft.asc | \
      gpg --dearmor | sudo tee /usr/share/keyrings/microsoft.gpg > /dev/null

    # Add Microsoft repository with signed-by option for Ubuntu version
    UBUNTU_VERSION=$(lsb_release -rs)
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/microsoft.gpg] https://packages.microsoft.com/ubuntu/${UBUNTU_VERSION}/prod noble main" | \
      sudo tee /etc/apt/sources.list.d/mssql-release.list > /dev/null
  fi

  sudo apt-get update -qq
  sudo ACCEPT_EULA=Y apt-get install -y mssql-tools18 unixodbc-dev >/dev/null
  add_sqlcmd_path
  echo "✅ sqlcmd installed successfully."
fi

# -----------------------------------------------------------------------------
# Done
# -----------------------------------------------------------------------------
echo ""
echo "🎯 Vim environment setup complete!"
echo "   - fzf: $(fzf --version 2>/dev/null || echo 'not found')"
echo "   - rg: $(rg --version | head -n 1 2>/dev/null || echo 'not found')"
echo "   - node: $(node -v 2>/dev/null || echo 'not found')"
echo "   - sqlcmd: $(sqlcmd -? 2>/dev/null | head -n 1 || echo 'not found')"

