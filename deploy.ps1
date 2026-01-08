# Deployment script for Filco Diamond Tools
# Run this script in PowerShell: .\deploy.ps1

Write-Host "Starting deployment to GitHub..." -ForegroundColor Green

# Find Git executable
$gitPath = $null
$commonGitPaths = @(
    "C:\Program Files\Git\bin\git.exe",
    "C:\Program Files (x86)\Git\bin\git.exe",
    "git"  # Try PATH as fallback
)

foreach ($path in $commonGitPaths) {
    if ($path -eq "git") {
        try {
            $null = Get-Command git -ErrorAction Stop
            $gitPath = "git"
            break
        } catch {
            continue
        }
    } else {
        if (Test-Path $path) {
            $gitPath = $path
            break
        }
    }
}

if (-not $gitPath) {
    Write-Host "ERROR: Git is not installed or not found." -ForegroundColor Red
    Write-Host "Please install Git from: https://git-scm.com/download/win" -ForegroundColor Yellow
    exit 1
}

# Create a function to run git commands
function Invoke-Git {
    param([string[]]$Arguments)
    if ($gitPath -eq "git") {
        & git $Arguments
    } else {
        & $gitPath $Arguments
    }
}

# Verify Git works
try {
    $gitVersion = Invoke-Git --version
    Write-Host "Git found: $gitVersion" -ForegroundColor Green
} catch {
    Write-Host "ERROR: Could not execute Git." -ForegroundColor Red
    exit 1
}

# Check if already a git repository
if (Test-Path .git) {
    Write-Host "Git repository already initialized." -ForegroundColor Yellow
} else {
    Write-Host "Initializing Git repository..." -ForegroundColor Cyan
    Invoke-Git init
}

# Add all files
Write-Host "Adding files to Git..." -ForegroundColor Cyan
if ($gitPath -eq "git") {
    & git add .
} else {
    & $gitPath add .
}

# Check if there are changes to commit
$status = if ($gitPath -eq "git") { & git status --porcelain } else { & $gitPath status --porcelain }
if ($status) {
    Write-Host "Creating initial commit..." -ForegroundColor Cyan
    if ($gitPath -eq "git") {
        & git commit -m "Initial commit: Filco Diamond Tools project"
    } else {
        & $gitPath commit -m "Initial commit: Filco Diamond Tools project"
    }
} else {
    Write-Host "No changes to commit." -ForegroundColor Yellow
}

# Check if remote already exists and set it up
$remoteUrl = "https://github.com/vishwajeetNarake/Filco-Diamond-Tools.git"
$remoteExists = $false
$remoteCurrentUrl = ""

try {
    if ($gitPath -eq "git") {
        $remoteCurrentUrl = & git remote get-url origin 2>&1
    } else {
        $remoteCurrentUrl = & $gitPath remote get-url origin 2>&1
    }
    if ($LASTEXITCODE -eq 0 -and $remoteCurrentUrl -and $remoteCurrentUrl -notmatch "error") {
        $remoteExists = $true
        if ($remoteCurrentUrl.Trim() -ne $remoteUrl) {
            Write-Host "Remote 'origin' exists with different URL: $remoteCurrentUrl" -ForegroundColor Yellow
            Write-Host "Updating remote URL..." -ForegroundColor Cyan
            if ($gitPath -eq "git") {
                & git remote set-url origin $remoteUrl
            } else {
                & $gitPath remote set-url origin $remoteUrl
            }
        } else {
            Write-Host "Remote 'origin' already configured correctly." -ForegroundColor Green
        }
    }
} catch {
    # Remote doesn't exist or error occurred
}

if (-not $remoteExists) {
    Write-Host "Adding remote repository..." -ForegroundColor Cyan
    if ($gitPath -eq "git") {
        & git remote add origin $remoteUrl
    } else {
        & $gitPath remote add origin $remoteUrl
    }
}

# Set branch to main
Write-Host "Setting branch to main..." -ForegroundColor Cyan
if ($gitPath -eq "git") {
    & git branch -M main
} else {
    & $gitPath branch -M main
}

# Push to GitHub
Write-Host "Pushing to GitHub..." -ForegroundColor Cyan
Write-Host "You may be prompted for your GitHub credentials." -ForegroundColor Yellow
Write-Host "If prompted for password, use a Personal Access Token instead." -ForegroundColor Yellow
if ($gitPath -eq "git") {
    & git push -u origin main
} else {
    & $gitPath push -u origin main
}

if ($LASTEXITCODE -eq 0) {
    Write-Host "`nDeployment successful! Your project is now on GitHub." -ForegroundColor Green
    Write-Host "Repository URL: https://github.com/vishwajeetNarake/Filco-Diamond-Tools" -ForegroundColor Cyan
} else {
    Write-Host "`nDeployment failed. Please check the error messages above." -ForegroundColor Red
    Write-Host "You may need to authenticate with GitHub using a Personal Access Token." -ForegroundColor Yellow
}
