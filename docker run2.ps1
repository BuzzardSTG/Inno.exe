# Check if Docker Desktop executable is present
$dockerDesktopExecutable = Join-Path $env:ProgramFiles 'Docker\Docker\Docker Desktop.exe'

if (Test-Path $dockerDesktopExecutable) {
    # Docker Desktop executable found
    Write-Host "Docker Desktop executable found: $dockerDesktopExecutable"
    Add-Type -AssemblyName System.Windows.Forms
    [System.Windows.Forms.MessageBox]::Show("Docker Desktop executable found: $dockerDesktopExecutable", "Docker Installed", [System.Windows.Forms.MessageBoxButtons]::OK, [System.Windows.Forms.MessageBoxIcon]::Information)

    # Start Docker Desktop
    Write-Host "Starting Docker Desktop..."
    Start-Process $dockerDesktopExecutable -PassThru
} else {
    # Docker Desktop executable not found
    Write-Host "Docker Desktop executable not found."
    Add-Type -AssemblyName System.Windows.Forms
    [System.Windows.Forms.MessageBox]::Show("Docker Desktop executable not found.", "Docker Not Installed", [System.Windows.Forms.MessageBoxButtons]::OK, [System.Windows.Forms.MessageBoxIcon]::Warning)
}

# Add a 2-second delay
Start-Sleep -Seconds 2

