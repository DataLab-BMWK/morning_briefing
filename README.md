# Morning Briefing Automation

[![Render Morning Briefing](https://github.com/your-use### Dependencies
- **R**: For data processing and analysis functions
- **Python**: For additional data sources and APIs
- **Quarto**: For PDF generation and document formatting
- **Typst**: For high-quality PDF output
- **BundesSans**: Official fonts for professional presentation

### Data Sources
- Yahoo Finance API (via yahoofinancer R package)
- Economic calendar APIs
- News feeds for industry updates

## 📚 Documentation

Detailed documentation can be found in the `docs/` folder:
- [Workflow Testing Guide](docs/WORKFLOW_TESTING.md)
- [Email Setup Guide](docs/EMAIL_SETUP.md)
- [GitHub Actions Configuration](docs/GITHUB_ACTION_README.md)fing/actions/workflows/render-briefing.yml/badge.svg)](https://github.com/your-username/morning_briefing/actions/workflows/render-briefing.yml)

Automated generation and distribution of daily morning briefings with current financial and economic data.

## 📊 Overview

This project automatically generates daily morning briefings in PDF format with:
- Global financial indicators (DAX, S&P 500, EUR/USD, commodities)
- Economic calendar for Germany
- Top 5 business news
- Industry-specific news (Chemistry, Automotive, Steel)

The system runs daily at 7:30 AM Berlin time via GitHub Actions and automatically sends the briefings by email.

## 🚀 Quick Start

### Local Development

1. **Clone repository and initialize environment:**
   ```bash
   git clone <repository-url>
   cd morning_briefing
   ./init-env.sh -w R
   ```

2. **Test locally:**
   ```bash
   # Complete workflow test
   ./test-workflow-complete.sh
   
   # PDF generation only
   ./test-local-render.sh
   
   # Email simulation only
   ./test-email-local.sh
   ```

### GitHub Actions Setup

1. **Configure repository secrets:**
   - `EMAIL_USERNAME`: Gmail address for sending
   - `EMAIL_PASSWORD`: Gmail app password
   - `EMAIL_RECIPIENTS`: Recipient emails (comma-separated)

2. **Test workflow:**
   - GitHub Repository → Actions → "Render Morning Briefing" → "Run workflow"

## 🏗️ Workflow Architecture

The GitHub Actions workflow consists of three separate jobs:

### Job 1: Render
- **Purpose**: Generate PDF from Quarto document
- **Technology**: R + Quarto + Typst
- **Output**: PDF as artifact

### Job 2: Email
- **Purpose**: Send email with PDF attachment
- **Condition**: Only on successful render
- **Service**: dawidd6/action-send-mail

### Job 3: Commit
- **Purpose**: Save PDF in repository
- **Condition**: Always runs on successful render
- **Function**: Git commit and push

## 📁 Project Structure

```
morning_briefing/
├── morning_briefing.qmd    # Main document (Quarto)
├── functions.R             # R functions for data queries
├── init-env.sh            # Setup script for R and Python
├── test-*.sh              # Test scripts for local development
├── docs/                  # Documentation
│   ├── WORKFLOW_TESTING.md
│   ├── EMAIL_SETUP.md
│   └── ...
├── fonts/                 # BundesSans fonts
└── .github/workflows/     # GitHub Actions workflows
```

## 🛠️ Technical Details

### Dependencies
- **R**: For data processing and analysis functions
- **Python**: For additional data sources and APIs
- **Quarto**: For PDF generation and document formatting
- **Typst**: For high-quality PDF output
- **BundesSans**: Official fonts for professional presentation

### Data Sources
- Yahoo Finance API (via yahoofinancer R package)
- Economic calendar APIs
- News feeds for industry updates

## 📚 Documentation

Detailed documentation can be found in the `docs/` folder:
- [Workflow Testing Guide](docs/WORKFLOW_TESTING.md)
- [Email Setup Guide](docs/EMAIL_SETUP.md)
- [GitHub Actions Configuration](docs/GITHUB_ACTION_README.md)

## 🔧 Development

### Local Development
The project supports development in GitHub Codespaces or local dev container environment.

### Code Structure
- `morning_briefing.qmd`: Main document with Quarto code
- `functions.R`: Reusable R functions
- `test-*.sh`: Local test scripts for workflow simulation

### Extensions
The system is modularly designed and can be easily extended:
- Add new data sources in `functions.R`
- Layout adjustments in `morning_briefing.qmd`
- Additional workflow jobs in `.github/workflows/`

## 📄 License

This project is licensed under the MIT License. See [LICENSE](LICENSE) for details.

## Initialisation Script

The initialisation script [init-env.sh](init-env.sh) is used to set up the R and Python environments.
It supports initialising all environments or specific ones based on the provided options.

### Usage

```sh
./init-env.sh [--what/-w all|r|python] [--force/-f] [--help/-h]
```

### Script Details

- **Options**:
  - `--what/-w`: Specify which environment(s) to initialise (`all`, `r`, `python` (uv)).
  - `--force/-f`: Force reinstallation of the specified environment(s).
  - `--help/-h`: Display help message and exit.
- **Functionality**: The script installs necessary dependencies for R and Python inside environments.
  - For R, it sets up `renv` and installs required packages.
  - For Python, it sets up uv and installs required libraries.

## Contributing

Contributions are welcome!
Please open an issue or submit a pull request for any improvements or bug fixes.

## License

This project is licensed under the MIT License.
See the [LICENSE](LICENSE) file for details.
