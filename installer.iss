#define MyAppName "Restaurant POS"
#define MyAppVersion "2.0.0"
#define MyAppExeName "restaurant_pos.exe"

[Setup]
AppId={{8F2A9C1E-5B47-4D1A-9E3C-1A0B4C2D3E4F}
AppName={#MyAppName}
AppVersion={#MyAppVersion}
AppPublisher="Restaurant POS"
DefaultDirName={autopf}\Restaurant POS
DefaultGroupName=Restaurant POS
UninstallDisplayIcon={app}\{#MyAppExeName}
OutputDir=installer
OutputBaseFilename=RestaurantPOS_Setup
Compression=lzma2
SolidCompression=yes
WizardStyle=modern
ArchitecturesInstallIn64BitMode=x64compatible
PrivilegesRequiredOverridesAllowed=dialog

[Files]
Source: "build\windows\x64\runner\Release\*"; DestDir: "{app}"; Flags: ignoreversion recursesubdirs createallsubdirs

[Icons]
Name: "{group}\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"
Name: "{autodesktop}\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"; Tasks: desktopicon

[Tasks]
Name: "desktopicon"; Description: "Create a desktop shortcut"; GroupDescription: "Additional shortcuts:"

[Run]
Filename: "{app}\{#MyAppExeName}"; Description: "Launch {#MyAppName}"; Flags: nowait postinstall skipifsilent
