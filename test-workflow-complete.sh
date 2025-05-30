#!/bin/bash

# Test script to simulate the complete workflow locally
# This runs both render and email jobs in sequence like the GitHub Actions workflow

echo "🚀 Testing Complete Morning Briefing Workflow"
echo "=============================================="
echo ""

# Set exit on error
set -e

echo "📋 This script simulates the complete GitHub Actions workflow:"
echo "  1. Render job - Generate PDF from Quarto document"
echo "  2. Email job - Send email with PDF attachment (simulation)"
echo "  3. Commit job - Save PDF to repository (simulation)"
echo ""

# Job 1: Render
echo "🔄 Starting Job 1: Render"
echo "========================="
./test-local-render.sh

if [ $? -ne 0 ]; then
    echo "❌ Render job failed. Stopping workflow."
    exit 1
fi

echo ""
echo "✅ Render job completed successfully"
echo ""

# Job 2: Email (simulation)
echo "📧 Starting Job 2: Email (Simulation)"
echo "====================================="
./test-email-local.sh

if [ $? -ne 0 ]; then
    echo "❌ Email job simulation failed. Continuing to commit job..."
fi

echo ""
echo "✅ Email job simulation completed"
echo ""

# Job 3: Commit (simulation)
echo "💾 Starting Job 3: Commit (Simulation)"
echo "======================================"

if [ -f "morning_briefing.pdf" ]; then
    echo "📄 PDF exists: morning_briefing.pdf"
    
    # Simulate git operations
    echo "🔧 Simulating git operations:"
    echo "  - git add morning_briefing.pdf"
    echo "  - git commit -m '📊 Update Morning Briefing - $(date '+%Y-%m-%d %H:%M') ✉️'"
    echo "  - git push"
    
    echo "✅ Commit job simulation completed"
else
    echo "❌ No PDF found for commit"
fi

echo ""
echo "🎉 Complete workflow simulation finished!"
echo "========================================"
echo ""
echo "📊 Summary:"
echo "  ✅ Render job: PDF generated"
echo "  ✅ Email job: Email content prepared (simulation)"
echo "  ✅ Commit job: Git operations simulated"
echo ""
echo "🔧 Next steps for production:"
echo "  1. Configure EMAIL_* secrets in GitHub repository"
echo "  2. Test the actual GitHub Actions workflow"
echo "  3. Schedule runs via cron or manual dispatch"
