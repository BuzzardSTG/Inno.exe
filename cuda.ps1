#https://developer.nvidia.com/cuda-downloads.json
#https://developer.nvidia.com/cuda-downloads?target_os=Windows&target_arch=x86_64&target_version=11&target_type=exe_network

# Checking if CUDA is installed
$nvccPath = Get-Command -Name nvcc -ErrorAction SilentlyContinue

if ($nvccPath) {
    $cudaVersion = & $nvccPath --version | Select-String -Pattern "release" | ForEach-Object { $_.ToString().Split(' ')[4] -replace ',' }
    Write-Host "NVIDIA CUDA is installed on the system. Installed Version: $cudaVersion"

    # Online JSON link
    $jsonLink = "https://developer.nvidia.com/cuda-downloads.json"

    # Make an HTTP request and retrieve data as a hashtable
    $data = Invoke-RestMethod -Uri $jsonLink -Method Get -UseBasicParsing

    # Accessing the desired information from releases
    $windowsRelease = $data.data.releases."Windows/x86_64/11/exe_network"
    
    # Extracting version from the filename using regular expressions
    $newestVersion = $windowsRelease.filename -match 'cuda_([\d.]+)' | Out-Null; $matches[1]
    Write-Host "Newest Available Version: $newestVersion"

    # Compare versions
    $installedVersionArray = $cudaVersion -split '\.'
    $newestVersionArray = $newestVersion -split '\.'

    # Ensure arrays are of the same length
    $maxIndex = [Math]::Max($installedVersionArray.Length, $newestVersionArray.Length)
    $installedVersionArray += '0' * ($maxIndex - $installedVersionArray.Length)
    $newestVersionArray += '0' * ($maxIndex - $newestVersionArray.Length)

    # Compare versions
    $compareResult = $null
    for ($i = 0; $i -lt $maxIndex; $i++) {
        $compareResult = $installedVersionArray[$i] - $newestVersionArray[$i]
        if ($compareResult -ne 0) {
            break
        }
    }

    if ($compareResult -gt 0) {
        Write-Host "A newer version of CUDA is available or Cuda is not installed on the system. Downloading and upgrading...."

        # Extracting the link from the details property using HTML parsing
        $html = $windowsRelease.details
        $linkRegex = 'href=["''](https://[^\s"'']+)["'']'
        $details = [regex]::Matches($html, $linkRegex) | ForEach-Object { $_.Groups[1].Value }

        if ($details) {
            $downloadLink = $details[0]
            Write-Host $downloadLink

            # Define the path to save the installer
            $installerPath = Join-Path $env:TEMP "CudaInstaller.exe"
            
            # Download the CUDA installer
            Invoke-WebRequest -Uri $downloadLink -OutFile $installerPath


# Installing drivers
Write-Host "Installing Nvidia Cuda now..."
$install_args = "-noreboot"
Start-Process -FilePath $installerPath -ArgumentList $install_args -wait

# Cleaning up downloaded files
Write-Host "Deleting downloaded files"
Remove-Item $installerPath -Recurse -Force


        } else {
            Write-Host "Failed to extract the download link from the JSON response."
        }
    } else {
        Write-Host "You have the latest or a newer version of CUDA installed."
    }
}
