[Setup]
AppName=Kyoei Install
AppVersion=1.0
DefaultDirName={commonpf}\KyoeiInstall
OutputDir=Installer
OutputBaseFilename=KyoeiInstaller
Compression=lzma
SolidCompression=yes
PrivilegesRequired=admin


[Languages]
Name: "english"; MessagesFile: "compiler:Default.isl"
Name: "japanese"; MessagesFile: "compiler:Languages\Japanese.isl"

[CustomMessages]
english.RunDescriptionNvidia=Run Nvidia Driver Installer
english.RunDescriptionDocker=Run Docker Installer
english.RunDescriptionPython=Run Python Installer
english.RunDescriptionCuda=Run Nvidia Cuda Installer
english.RunDescriptionShortcut=OCR Automatic System Startup Shortcut
english.RunDescriptionSettingsIni=Open settings.ini after installation
english.RunDockerDesktop=Launch Docker Desktop

japanese.RunDescriptionNvidia=Nvidia ドライバーインストーラーを実行
japanese.RunDescriptionDocker=Docker インストーラーを実行
japanese.RunDescriptionPython=Python インストーラーを実行
japanese.RunDescriptionCuda=Nvidia CUDA インストーラーを実行
japanese.RunDescriptionShortcut=OCR 自動 読み取り システム 起動 ショートカット
japanese.RunDescriptionSettingsIni=インストール後に settings.ini を開く
japanese.RunDockerDesktop=Docker Desktop を起動

[Types]
Name: "full"; Description: "Full installation";
Name: "custom"; Description: "Custom installation"; Flags: iscustom


[Components]
Name: "runNvidia"; Description: "{cm:RunDescriptionNvidia}"; Types: full
Name: "runDocker"; Description: "{cm:RunDescriptionDocker}"; Types: full
Name: "runPython"; Description: "{cm:RunDescriptionPython}"; Types: full
Name: "runCuda"; Description: "{cm:RunDescriptionCuda}"; Types: full

[Tasks]
Name: "desktopicon"; Description: "{cm:RunDescriptionShortcut}"; GroupDescription: "Additional tasks";


[Files]
Source: "cuda_11.8.0_windows_network.exe"; DestDir: "{app}"; Flags: ignoreversion
Source: "nvidia-driver.ps1"; DestDir: "{app}"; Flags: ignoreversion
Source: "docker.ps1"; DestDir: "{app}"; Flags: ignoreversion
Source: "python.ps1"; DestDir: "{app}"; Flags: ignoreversion
Source: "docker run.ps1"; DestDir: "{app}"; Flags: ignoreversion
Source: "launch.bat"; DestDir: "{app}"; Flags: ignoreversion
Source: "settings.ini"; DestDir: "{app}"; Flags: ignoreversion

[Icons]
Name: "{commondesktop}\{cm:RunDescriptionShortcut}"; Filename: "{app}\launch.bat"; WorkingDir: "{app}"; Tasks: desktopicon; Flags: uninsneveruninstall 

[Run]
Filename: "powershell.exe"; Parameters: "-ExecutionPolicy Bypass -File ""{app}\nvidia-driver.ps1"""; Description: "{cm:RunDescriptionNvidia}"; Flags: waituntilterminated shellexec runasoriginaluser; Components: runNvidia
Filename: "powershell.exe"; Parameters: "-ExecutionPolicy Bypass -File ""{app}\docker.ps1"""; Description: "{cm:RunDescriptionDocker}"; Flags: waituntilterminated shellexec runasoriginaluser; Components: runDocker
Filename: "powershell.exe"; Parameters: "-ExecutionPolicy Bypass -File ""{app}\python.ps1"""; Description: "{cm:RunDescriptionPython}"; Flags: waituntilterminated shellexec runasoriginaluser; Components: runPython
Filename: "{app}\cuda_11.8.0_windows_network.exe"; Description: "{cm:RunDescriptionCuda}"; Flags: waituntilterminated; Components: runCuda
Filename: "powershell.exe"; Parameters: "-ExecutionPolicy Bypass -File ""{app}\docker run.ps1"""; Description: "{cm:RunDockerDesktop}"; Flags: postinstall runasoriginaluser
Filename: "{app}\settings.ini"; Description: "{cm:RunDescriptionSettingsIni}"; Flags: shellexec postinstall;




