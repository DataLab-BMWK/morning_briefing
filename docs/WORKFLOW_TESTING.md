# Workflow Testing Guide

This project contains several test scripts to test the GitHub Actions workflow jobs locally.

## Test Scripts

### 1. `test-local-render.sh`
Simulates the **Render Job** from the GitHub Actions workflow.
- Renders the Morning Briefing PDF with Quarto
- Creates artifact folder for simulation
- Shows output information

```bash
./test-local-render.sh
```

### 2. `test-email-local.sh`
Simulates the **Email Job** from the GitHub Actions workflow.
- Shows email configuration
- Shows HTML email template
- Simulates attachment processing
- Requires existing PDF (from Render Job)

```bash
./test-email-local.sh
```

### 3. `test-workflow-complete.sh`
Simulates the **complete workflow** with all three jobs:
1. Render Job (actual PDF generation)
2. Email Job (simulation)
3. Commit Job (simulation)

```bash
./test-workflow-complete.sh
```

## Workflow Structure

The GitHub Actions workflow (`render-briefing.yml`) consists of three separate jobs:

### Job 1: Render
- **Purpose**: Generate PDF from Quarto document
- **Output**: `morning_briefing.pdf` as artifact
- **Dependencies**: R, Quarto, Typst, Fonts

### Job 2: Email
- **Purpose**: Send email with PDF attachment
- **Condition**: Only on successful Render Job
- **Dependencies**: Download PDF artifact

### Job 3: Commit
- **Purpose**: Save PDF in repository
- **Condition**: Always runs on successful render
- **Function**: Git commit and push

## Advantages of the new structure

1. **Modular Jobs**: Each job has a clear purpose
2. **Error Handling**: Email errors don't stop the commit
3. **Artifact System**: Clean data transfer between jobs
4. **Flexible Execution**: Manual triggers with parameters
5. **Better Monitoring**: Individual job status available

## Production Usage

1. **Configure secrets**:
   - `EMAIL_USERNAME`
   - `EMAIL_PASSWORD` 
   - `EMAIL_RECIPIENTS`

2. **Test workflow**:
   ```bash
   # Manual trigger in GitHub Repository
   Actions → Render Morning Briefing → Run workflow
   ```

3. **Automatic execution**:
   - Daily at 7:30 AM Berlin time
   - Via cron: `30 5 * * *` (UTC)

## Troubleshooting

- **Render Job failed**: Check R packages and Quarto installation
- **Email Job failed**: Check email credentials and SMTP settings
- **Commit Job failed**: Check repository permissions
