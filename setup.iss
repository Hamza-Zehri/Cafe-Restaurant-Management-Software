#define MyAppName "Cafe & Restaurant Management System"
#define MyAppVersion "1.0.0"
#define MyAppPublisher "Hamza Asad"
#define MyAppExeName "restaurant_pos.exe"

[Setup]
AppId={{C7B53A91-89D8-42D1-BF3A-7D4D8F8F6A11}
AppName={#MyAppName}
AppVersion={#MyAppVersion}
AppPublisher={#MyAppPublisher}

DefaultDirName={autopf}\{#MyAppName}
DefaultGroupName={#MyAppName}

OutputDir=Installer
OutputBaseFilename=Cafe_Restaurant_Management_System_Setup

Compression=lzma2
SolidCompression=yes

ArchitecturesAllowed=x64
ArchitecturesInstallIn64BitMode=x64

WizardStyle=modern
PrivilegesRequired=admin

SetupIconFile=assets\images\icon.ico

UninstallDisplayIcon={app}\{#MyAppExeName}

[Languages]
Name: "english"; MessagesFile: "compiler:Default.isl"

[Tasks]
Name: "desktopicon"; Description: "Create Desktop Shortcut"; GroupDescription: "Additional Icons:"; Flags: unchecked

[Files]
Source: "build\windows\x64\runner\Release\*"; DestDir: "{app}"; Flags: ignoreversion recursesubdirs createallsubdirs

[Icons]
Name: "{group}\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"
Name: "{autodesktop}\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"; Tasks: desktopicon

[Run]
Filename: "{app}\{#MyAppExeName}"; Description: "Launch {#MyAppName}"; Flags: nowait postinstall skipifsilent
