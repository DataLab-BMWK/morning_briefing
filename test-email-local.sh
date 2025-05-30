#!/bin/bash

# Test script to simulate the email job locally
# This mimics what the GitHub Actions email job does

echo "🧪 Testing Email Job (Simulation)"
echo "================================="

# Simulate environment variables that would be available in GitHub Actions
export GITHUB_RUN_DATE=$(date '+%Y-%m-%d')
export GITHUB_REPOSITORY="your-username/morning_briefing"
export GITHUB_RUN_NUMBER="123"

# Check if PDF exists (simulating artifact download)
if [ ! -f "morning_briefing.pdf" ]; then
    echo "❌ morning_briefing.pdf not found. Run test-local-render.sh first."
    exit 1
fi

echo "✅ PDF found: morning_briefing.pdf"

# Display email details that would be sent
echo ""
echo "📧 Email Configuration (Simulation)"
echo "-----------------------------------"
echo "Subject: 📊 Morning Briefing - $GITHUB_RUN_DATE"
echo "From: Morning Briefing Bot <your-email@gmail.com>"
echo "To: recipients@example.com"
echo ""

# Display the HTML email body that would be sent
echo "📝 Email Body Preview:"
echo "----------------------"
cat << EOF
<h2>📊 Daily Morning Briefing</h2>
<p>Good morning!</p>

<p>Here is your current Morning Briefing for <strong>$GITHUB_RUN_DATE</strong>.</p>

<div style="background-color: #f8f9fa; padding: 15px; border-radius: 5px; margin: 15px 0;">
  <h3>📋 Content</h3>
  <ul>
    <li>🌍 Global Financial Indicators (DAX, S&P 500, Oil, etc.)</li>
    <li>📅 German Economic Calendar</li>
    <li>📰 Top 5 Business News</li>
    <li>🏭 Industry News (Chemistry, Automotive, Steel)</li>
  </ul>
</div>

<p>The complete Morning Briefing can be found in the attached PDF.</p>

<hr>
<p><small>
  Automatically generated on $GITHUB_RUN_DATE | 
  <a href="https://github.com/$GITHUB_REPOSITORY">Repository</a>
</small></p>
EOF

echo ""
echo "📎 Attachment: morning_briefing.pdf"
echo ""

# Get PDF info
pdf_size=$(du -h morning_briefing.pdf | cut -f1)
echo "📄 PDF Size: $pdf_size"

echo ""
echo "✅ Email job simulation completed successfully!"
echo "💡 In the real workflow, this would send the email using dawidd6/action-send-mail@v3"
echo ""
echo "🔧 To test actual email sending, configure EMAIL_* secrets and use the GitHub Actions workflow"
