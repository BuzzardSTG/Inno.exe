# Define the required Python version
$requiredMajor = 3
$requiredMinor = 10
$requiredPatch = 10

# Determine the system architecture
$architecture = (Get-CimInstance Win32_Processor).AddressWidth
if ($architecture -eq 32) {
    $architectureString = "win32"
} elseif ($architecture -eq 64) {
    $architectureString = "amd64"
} else {
    Write-Host "Unsupported system architecture."
    exit
}

# Check if Python is installed
$installedPythonVersion = python --version 2>&1 | ForEach-Object { $_.Split(' ')[1] }

function Parse-Version {
    param (
        [string]$versionString
    )

    $versionComponents = $versionString -split '\.'
    $major = [int]$versionComponents[0]
    $minor = [int]$versionComponents[1]
    $patch = [int]$versionComponents[2]

    return $major, $minor, $patch
}

function Compare-Versions {
    param (
        [string]$version1,
        [string]$version2
    )

    $installedVersionComponents = Parse-Version -versionString $version1
    $requiredVersionComponents = Parse-Version -versionString $version2

    for ($i = 0; $i -lt 3; $i++) {
        if ($installedVersionComponents[$i] -ne $requiredVersionComponents[$i]) {
            return $installedVersionComponents[$i] -gt $requiredVersionComponents[$i]
        }
    }

    # All components are equal
    return $true
}


if (Compare-Versions -version1 $installedPythonVersion -version2 "$requiredMajor.$requiredMinor.$requiredPatch") {
    Write-Host "Installed Python version ($installedPythonVersion) is higher than $requiredMajor.$requiredMinor.$requiredPatch. No action required."
} else {
    Write-Host "Python is not installed or the installed version is lower than or equal to $requiredMajor.$requiredMinor.$requiredPatch. Downloading and installing..."

    # Define the URL for the required Python installer
    $pythonInstallerUrl = "https://www.python.org/ftp/python/$requiredMajor.$requiredMinor.$requiredPatch/python-$requiredMajor.$requiredMinor.$requiredPatch-$architectureString.exe"

    # Define the path to save the installer
    $installerPath = Join-Path $env:TEMP "PythonInstaller.exe"

    # Download the Python installer
    Invoke-WebRequest -Uri $pythonInstallerUrl -OutFile $installerPath

    # Start the installation
    Start-Process -FilePath $installerPath -Wait

    Write-Host "Python version $requiredMajor.$requiredMinor.$requiredPatch has been installed on the system."

    # Remove the downloaded installer
    Remove-Item -Path $installerPath -Force
    Write-Host "Downloaded installer removed."
}


