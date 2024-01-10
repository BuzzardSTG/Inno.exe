[Setup]
AppName=Kyoei Install
AppVersion=1.0
DefaultDirName={commonpf}\KyoeiInstall
OutputDir=Installer
OutputBaseFilename=KyoeiInstaller
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

japanese.RunDescriptionNvidia=Nvidia �h���C�o�[�C���X�g�[���[�����s
japanese.RunDescriptionDocker=Docker �C���X�g�[���[�����s
japanese.RunDescriptionPython=Python �C���X�g�[���[�����s
japanese.RunDescriptionCuda=Nvidia CUDA �C���X�g�[���[�����s

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

