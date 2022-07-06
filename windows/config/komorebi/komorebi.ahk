#SingleInstance Force
#Include %A_ScriptDir%\komorebic.lib.ahk

; Default to minimizing windows when switching workspaces
WindowHidingBehaviour("minimize")

; Enable hot reloading of changes to this file
WatchConfiguration("enable")

; Disable mouse follows focus
MouseFollowsFocus(false)

; Disable mouse follows focus
FocusFollowsMouse(false, "windows")

; Ensure there are 9 workspaces created on monitor 0
EnsureWorkspaces(0, 9)

; Configure the invisible border dimensions
InvisibleBorders(7, 0, 14, 7)

; Configure the 1st workspace
WorkspaceName(0, 0, "bsp")

; Configure the 2nd workspace
WorkspaceName(0, 1, "columns") ; Optionally set the name of the workspace
WorkspacePadding(0, 1, 30) ; Set the padding around the edge of the screen
ContainerPadding(0, 1, 30) ; Set the padding between the containers on the screen
WorkspaceRule("exe", "slack.exe", 0, 1) ; Always show chat apps on this workspace

; Configure the 3rd workspace
WorkspaceName(0, 2, "thicc")
WorkspacePadding(0, 2, 200) ; Set some super thicc padding

; Configure the 4th workspace
WorkspaceName(0, 3, "matrix")
WorkspacePadding(0, 3, 0) ; No padding at all
ContainerPadding(0, 3, 0) ; Matrix-y hacker vibes

; Configure the 5th workspace
WorkspaceName(0, 4, "floaty")
WorkspaceTiling(0, 4, "disable") ; Everything floats here

; Configure floating rules
FloatRule("class", "SunAwtDialog") ; All the IntelliJ popups
FloatRule("title", "Control Panel")
FloatRule("class", "TaskManagerWindow")
FloatRule("exe", "Wally.exe")
FloatRule("exe", "wincompose.exe")
FloatRule("exe", "1Password.exe")
FloatRule("exe", "Wox.exe")
FloatRule("exe", "ddm.exe")
FloatRule("class", "Chrome_RenderWidgetHostHWND") ; GOG Electron invisible overlay
FloatRule("class", "CEFCLIENT")

; Identify Minimize-to-Tray Applications
IdentifyTrayApplication("exe", "Discord.exe")
IdentifyTrayApplication("exe", "Spotify.exe")
IdentifyTrayApplication("exe", "GalaxyClient.exe")

; Identify Electron applications with overflowing borders
IdentifyBorderOverflow("exe", "Discord.exe")
IdentifyBorderOverflow("exe", "Spotify.exe")
IdentifyBorderOverflow("exe", "GalaxyClient.exe")
IdentifyBorderOverflow("class", "ZPFTEWndClass")

; Identify applications to be forcibly managed
ManageRule("exe", "GalaxyClient.exe")

; CONTROLS
; ^ = Ctrl
; ! = Alt
; + = Shift
; # = Win

; Change the focused window, Mod + Vim direction keys
!h::
Focus("left")
return

!j::
Focus("down")
return

!k::
Focus("up")
return

!l::
Focus("right")
return

; Move the focused window in a given direction, Mod + Shift + Vim direction keys
!+h::
Move("left")
return

!+j::
Move("down")
return

!+k::
Move("up")
return

!+l::
Move("right")
return

; Stack the focused window in a given direction, Mod + Shift + direction keys
!+Left::
Stack("left")
return

!+Down::
Stack("down")
return

!+Up::
Stack("up")
return

!+Right::
Stack("right")
return

; Cycle through monitors

!^k::
CycleMonitor("next")
return

!^j::
CycleMonitor("previous")
return

; Unstack the focused window, Mod + Shift + D
!+d::
Unstack()
return

; Promote the focused window to the top of the tree, Mod + Shift + Enter
!+Enter::
Promote()
return

; Manage the focused window
!=::
Manage()
return

; Unmanage the focused window
!-::
Unmanage()
return

; Switch to an equal-width, max-height column layout on the main workspace, Mod + Shift + C
!+c::
ChangeLayout("columns")
return

; Switch to the default bsp tiling layout on the main workspace, Mod + Shift + T
!+t::
ChangeLayout("bsp")
return

; Toggle the Monocle layout for the focused window, Mod + Shift + F
!+f::
ToggleMonocle()
return

; Toggle native maximize for the focused window, Mod + F
!f::
ToggleMaximize()
return

; Flip horizontally, Mod + X
!x::
FlipLayout("horizontal")
return

; Flip vertically, Mod + Y
!y::
FlipLayout("vertical")
return

; Force a retile if things get janky, Mod + R
!r::
Retile()
return

; Reload ~/komorebi.ahk, Mod + Shift + R
!+r::
ReloadConfiguration()
return

; Float the focused window, Mod + T
!t::
ToggleFloat()
return

; Pause responding to any window events or komorebic commands, Mod + P
!p::
TogglePause()
return

; Switch to workspace
!1::
Send !
FocusWorkspace(0)
return

!2::
Send !
FocusWorkspace(1)
return

!3::
Send !
FocusWorkspace(2)
return

!4::
Send !
FocusWorkspace(3)
return

!5::
Send !
FocusWorkspace(4)
return

!6::
Send !
FocusWorkspace(5)
return

!7::
Send !
FocusWorkspace(6)
return

!8::
Send !
FocusWorkspace(7)
return

!9::
Send !
FocusWorkspace(8)
return

; Move window to workspace
!+1::
MoveToWorkspace(0)
return

!+2::
MoveToWorkspace(1)
return

!+3::
MoveToWorkspace(2)
return

!+4::
MoveToWorkspace(3)
return

!+5::
MoveToWorkspace(4)
return

!+6::
Send !
MoveToWorkspace(5)
return

!+7::
Send !
MoveToWorkspace(6)
return

!+8::
Send !
MoveToWorkspace(7)
return

!+9::
Send !
MoveToWorkspace(8)
return

; Applications

; Quit currently focused application
!q::
WinClose, A
return

; Open Windows Terminal
!Enter::
Run, %USERPROFILE%\AppData\Local\Microsoft\WindowsApps\wt.exe
return

