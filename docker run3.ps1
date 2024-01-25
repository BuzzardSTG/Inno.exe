# Function to search for Docker Desktop
function Find-DockerDesktop {
    Write-Host "Searching for Docker Desktop, this may take a while..."
    
    # Perform a system-wide search for Docker Desktop.exe
    try {
        $dockerDesktopPath = Get-ChildItem -Path "C:\", "D:\", "E:\" -Filter "Docker Desktop.exe" -Recurse -ErrorAction SilentlyContinue -Force | Select-Object -First 1
        return $dockerDesktopPath
    } catch {
        Write-Host "Error occurred during search: $_"
        return $null
    }
}

# Find Docker Desktop
$dockerDesktop = Find-DockerDesktop

# Check if Docker Desktop was found and run it
if ($dockerDesktop) {
    Write-Host "Docker Desktop found at: $($dockerDesktop.FullName)"
    try {
        Start-Process -FilePath $dockerDesktop.FullName
        Write-Host "Docker Desktop is starting..."
    } catch {
        Write-Host "Error starting Docker Desktop: $_"
    }
} else {
    Write-Host "Docker Desktop.exe not found on the system."
}

