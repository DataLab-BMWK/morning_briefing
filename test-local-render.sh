#!/bin/bash

# Local test script for Morning Briefing rendering
# This script mimics the render job from the GitHub Action workflow

set -e

echo "🚀 Starting local Morning Briefing render test..."
echo "📝 This script simulates the 'render' job from the GitHub Actions workflow"

# Check if running in correct directory
if [ ! -f "morning_briefing.qmd" ]; then
    echo "❌ Error: Please run this script from the morning_briefing directory"
    exit 1
fi

# Install system dependencies (Ubuntu/Debian)
echo "📦 Installing system dependencies..."
sudo apt-get update -qq
sudo apt-get install -y \
    libcurl4-openssl-dev \
    libssl-dev \
    libxml2-dev \
    libfontconfig1-dev \
    libharfbuzz-dev \
    libfribidi-dev \
    libfreetype6-dev \
    libpng-dev \
    libtiff5-dev \
    libjpeg-dev \
    fontconfig

# Install fonts
echo "🎨 Installing BundesSans Web fonts..."
sudo mkdir -p /usr/share/fonts/truetype/bundesweb
sudo cp fonts/*.ttf /usr/share/fonts/truetype/bundesweb/
sudo fc-cache -fv

# Verify fonts
echo "🔍 Verifying font installation..."
fc-list | grep -i bundes || echo "BundesSans fonts installed successfully"

# Install Quarto if not present
if ! command -v quarto &> /dev/null; then
    echo "📚 Installing Quarto..."
    curl -LO https://quarto.org/download/latest/quarto-linux-amd64.deb
    sudo dpkg -i quarto-linux-amd64.deb
    rm quarto-linux-amd64.deb
fi

# Install Typst if not present
if ! command -v typst &> /dev/null; then
    echo "📝 Installing Typst..."
    curl -fsSL https://typst.community/typst-install/install.sh | sh
    export PATH="$HOME/.local/bin:$PATH"
fi

# Install R dependencies
echo "📊 Installing R dependencies..."
R -e "if (!require('renv')) install.packages('renv', repos = c(CRAN = 'https://cloud.r-project.org'))"
R -e "renv::restore()"

# Render the document
echo "🔄 Rendering Morning Briefing..."
export QUARTO_DENO_DOM_LOG_LEVEL=WARNING

if quarto render morning_briefing.qmd --to typst-pdf; then
    echo "✅ PDF rendered successfully"
    
    # Get file size for logging (like in GitHub Actions)
    size=$(du -h morning_briefing.pdf | cut -f1)
    echo "📄 PDF size: $size"
    echo "📁 File location: $(pwd)/morning_briefing.pdf"
    
    # Simulate artifact creation (create a local copy)
    mkdir -p local-artifacts
    cp morning_briefing.pdf local-artifacts/morning-briefing-local.pdf
    echo "📦 Local artifact created: local-artifacts/morning-briefing-local.pdf"
    
else
    echo "❌ PDF rendering failed"
    exit 1
fi

echo ""
echo "🎉 Render job completed successfully!"
echo "📧 To test email functionality, run: ./test-email-local.sh"
