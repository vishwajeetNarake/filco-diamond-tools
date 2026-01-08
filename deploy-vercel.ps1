# Vercel Deployment Script for Filco Diamond Tools
# Run this script in PowerShell: .\deploy-vercel.ps1

Write-Host "Starting Vercel deployment..." -ForegroundColor Green

# Check if Node.js is installed
try {
    $nodeVersion = node --version
    Write-Host "Node.js found: $nodeVersion" -ForegroundColor Green
} catch {
    Write-Host "ERROR: Node.js is not installed or not in PATH." -ForegroundColor Red
    Write-Host "Please install Node.js from: https://nodejs.org/" -ForegroundColor Yellow
    Write-Host "After installing Node.js, run this script again." -ForegroundColor Yellow
    exit 1
}

# Check if Vercel CLI is installed
try {
    $vercelVersion = vercel --version
    Write-Host "Vercel CLI found: $vercelVersion" -ForegroundColor Green
} catch {
    Write-Host "Vercel CLI not found. Installing..." -ForegroundColor Yellow
    Write-Host "This may take a minute..." -ForegroundColor Cyan
    npm install -g vercel
    if ($LASTEXITCODE -ne 0) {
        Write-Host "ERROR: Failed to install Vercel CLI." -ForegroundColor Red
        Write-Host "Try running manually: npm install -g vercel" -ForegroundColor Yellow
        exit 1
    }
    Write-Host "Vercel CLI installed successfully!" -ForegroundColor Green
}

# Check if user is logged in to Vercel
Write-Host "`nChecking Vercel authentication..." -ForegroundColor Cyan
$whoami = vercel whoami 2>&1
if ($LASTEXITCODE -ne 0) {
    Write-Host "Not logged in to Vercel. Please log in..." -ForegroundColor Yellow
    vercel login
    if ($LASTEXITCODE -ne 0) {
        Write-Host "ERROR: Failed to log in to Vercel." -ForegroundColor Red
        exit 1
    }
} else {
    Write-Host "Logged in as: $whoami" -ForegroundColor Green
}

# Deploy to Vercel
Write-Host "`nDeploying to Vercel..." -ForegroundColor Cyan
Write-Host "Follow the prompts below:" -ForegroundColor Yellow
Write-Host "- Set up and deploy? Yes" -ForegroundColor Yellow
Write-Host "- Link to existing project? No (for first time)" -ForegroundColor Yellow
Write-Host "- Project name? filco-diamond-tools (or press Enter)" -ForegroundColor Yellow
Write-Host "- Directory? ./ (press Enter)" -ForegroundColor Yellow
Write-Host "`n" -ForegroundColor Cyan

$deployChoice = Read-Host "Deploy to production? (y/n) - 'n' will create a preview deployment"
if ($deployChoice -eq 'y') {
    vercel --prod
} else {
    vercel
}

if ($LASTEXITCODE -eq 0) {
    Write-Host "`nDeployment successful!" -ForegroundColor Green
    Write-Host "Your site should be live on Vercel now." -ForegroundColor Cyan
    Write-Host "Check your Vercel dashboard: https://vercel.com/dashboard" -ForegroundColor Cyan
} else {
    Write-Host "`nDeployment failed. Please check the error messages above." -ForegroundColor Red
}
