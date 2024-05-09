[Setup]
AppName=Installer
AppVersion=1.0
DefaultDirName={commonpf}\Installer
OutputDir=Installer
OutputBaseFilename=Installer
Compression=lzma
SolidCompression=yes

[Languages]
Name: "english"; MessagesFile: "compiler:Default.isl"
Name: "japanese"; MessagesFile: "compiler:Languages\Japanese.isl"

[CustomMessages]
english.RunDescriptionNvidia=Run Nvidia Driver Installer
english.RunDescriptionDocker=Run Docker Installer
english.RunDescriptionPython=Run Python Installer
english.RunDescriptionCuda=Run Nvidia Cuda Installer

japanese.RunDescriptionNvidia=Nvidia ドライバーインストーラーを実行
japanese.RunDescriptionDocker=Docker インストーラーを実行
japanese.RunDescriptionPython=Python インストーラーを実行
japanese.RunDescriptionCuda=Nvidia CUDA インストーラーを実行

[Files]
Source: "nvidia-driver.ps1"; DestDir: "{app}"; Flags: ignoreversion
Source: "docker.ps1"; DestDir: "{app}"; Flags: ignoreversion
Source: "python.ps1"; DestDir: "{app}"; Flags: ignoreversion
Source: "cuda_11.8.0_windows_network.exe"; DestDir:"{app}"; Flags: ignoreversion


[Run]
Filename: "powershell.exe"; Parameters: "-ExecutionPolicy Bypass -File ""{app}\nvidia-driver.ps1"""; Description: "{cm:RunDescriptionNvidia}"; Flags: postinstall shellexec runasoriginaluser
Filename: "powershell.exe"; Parameters: "-ExecutionPolicy Bypass -File ""{app}\docker.ps1"""; Description: "{cm:RunDescriptionDocker}"; Flags: postinstall shellexec runasoriginaluser
Filename: "powershell.exe"; Parameters: "-ExecutionPolicy Bypass -File ""{app}\python.ps1"""; Description: "{cm:RunDescriptionPython}"; Flags: postinstall shellexec runasoriginaluser
Filename: "{app}\cuda_11.8.0_windows_network.exe"; Description: "{cm:RunDescriptionCuda}"; Flags: postinstall waituntilterminated;

