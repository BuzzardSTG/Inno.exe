
# Check if Docker is installed
$dockerInstalled = Get-Command -Name docker -ErrorAction SilentlyContinue

if ($dockerInstalled) {
    # Docker is installed, get the executable path
    $dockerRegistryPath = 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\*'
    Write-Host "Debug: Checking Docker Registry Path..."
    $dockerUninstallString = (Get-ItemProperty -Path $dockerRegistryPath | Where-Object { $_.DisplayName -eq 'Docker Desktop' }).UninstallString
    Write-Host "Debug: Uninstall String: $dockerUninstallString"


    if ($dockerUninstallString) {
        $dockerExecutablePath = $dockerUninstallString -replace '.*?([C-Z]:\\.*)\\.*', '$1\Docker Desktop.exe'

        # Check if Docker executable path is not empty and exists
        if ($dockerExecutablePath -and (Test-Path $dockerExecutablePath)) {
            # Docker Desktop is installed, and executable path is found
            Write-Host "Docker is installed. Executable path: $dockerExecutablePath"
            Add-Type -AssemblyName System.Windows.Forms
            [System.Windows.Forms.MessageBox]::Show("Docker is installed. Executable path: $dockerExecutablePath", "Docker Installed", [System.Windows.Forms.MessageBoxButtons]::OK, [System.Windows.Forms.MessageBoxIcon]::Information)

            # Start Docker Desktop
            Write-Host "Starting Docker Desktop..."
            Start-Process $dockerExecutablePath -PassThru
        } else {
            # Docker executable path not found
            Write-Host "Docker executable path not found."
            Add-Type -AssemblyName System.Windows.Forms
            [System.Windows.Forms.MessageBox]::Show("Docker executable path not found.", "Docker Not Installed", [System.Windows.Forms.MessageBoxButtons]::OK, [System.Windows.Forms.MessageBoxIcon]::Warning)
        }
    } else {
        # Unable to retrieve uninstall string
        Write-Host "Unable to retrieve uninstall string for Docker."
        Add-Type -AssemblyName System.Windows.Forms
        [System.Windows.Forms.MessageBox]::Show("Unable to retrieve uninstall string for Docker.", "Error", [System.Windows.Forms.MessageBoxButtons]::OK, [System.Windows.Forms.MessageBoxIcon]::Error)
    }
} else {
    # Docker is not installed
    Write-Host "Docker is not installed."
    Add-Type -AssemblyName System.Windows.Forms
    [System.Windows.Forms.MessageBox]::Show("Docker is not installed.", "Docker Not Installed", [System.Windows.Forms.MessageBoxButtons]::OK, [System.Windows.Forms.MessageBoxIcon]::Warning)
}

# Add a 2-second delay
Start-Sleep -Seconds 2

