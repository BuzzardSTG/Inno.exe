# Check if Docker Desktop is installed
$dockerInstalled = Get-Command -Name docker -ErrorAction SilentlyContinue

if ($dockerInstalled) {
    Write-Host "Docker Desktop is installed on the system."
} else {
    Write-Host "Docker Desktop is not installed on the system. Downloading and installing..."

    # Define the URL for the Docker Desktop installer -windows
    $dockerInstallerUrl = "https://desktop.docker.com/win/stable/Docker%20Desktop%20Installer.exe"

    # Define the path to save the installer
    $installerPath = Join-Path $env:TEMP "DockerDesktopInstaller.exe"

    # Download the Docker Desktop installer
    Invoke-WebRequest -Uri $dockerInstallerUrl -OutFile $installerPath

    # Start the installation
    Start-Process -FilePath $installerPath -Wait

    Write-Host "Docker Desktop has been installed on the system."

    Write-Host "Starting installer removal."
    Remove-Item -Path $installerPath -Force
}

