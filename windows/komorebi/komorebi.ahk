#SingleInstance Force

; Enable hot reloading of changes to this file
Run, komorebic.exe watch-configuration enable, , Hide

; Configure the invisible border dimensions
Run, komorebic.exe invisible-borders 7 0 14 7, , Hide

; Enable focus follows mouse
Run, komorebic.exe focus-follows-mouse enable, , Hide

; Ensure there are 3 workspaces created on monitor 0
Run, komorebic.exe ensure-workspaces 0 5, , Hide

; Give the workspaces some optional names
Run, komorebic.exe workspace-name 0 0 bsp, , Hide
Run, komorebic.exe workspace-name 0 1 columns, , Hide
Run, komorebic.exe workspace-name 0 2 thicc, , Hide
Run, komorebic.exe workspace-name 0 3 matrix, , Hide
Run, komorebic.exe workspace-name 0 4 floaty, , Hide

; Set the padding of the different workspaces
Run, komorebic.exe workspace-padding 0 1 30, , Hide
Run, komorebic.exe container-padding 0 1 30, , Hide
Run, komorebic.exe workspace-padding 0 2 200, , Hide
Run, komorebic.exe workspace-padding 0 3 0, , Hide
Run, komorebic.exe container-padding 0 3 0, , Hide

; Set the layouts of different workspaces
Run, komorebic.exe workspace-layout 0 1 columns, , Hide

; Set the floaty layout to not tile any windows
Run, komorebic.exe workspace-tiling 0 4 disable, , Hide

; Always show chat apps on the second workspace
Run, komorebic.exe workspace-rule exe slack.exe 0 1, , Hide
Run, komorebic.exe workspace-rule exe Discord.exe 0 1, , Hide

; Always float IntelliJ popups, matching on class
Run, komorebic.exe float-rule class SunAwtDialog, , Hide
; Always float Control Panel, matching on title
Run, komorebic.exe float-rule title "Control Panel", , Hide
; Always float Task Manager, matching on class
Run, komorebic.exe float-rule class TaskManagerWindow, , Hide
; Always float Wally, matching on executable name
Run, komorebic.exe float-rule exe Wally.exe, , Hide
Run, komorebic.exe float-rule exe wincompose.exe, , Hide
; Always float Calculator app, matching on window title
Run, komorebic.exe float-rule title Calculator, , Hide
Run, komorebic.exe float-rule exe 1Password.exe, , Hide

; Always manage forcibly these applications that don't automatically get picked up by komorebi
Run, komorebic.exe manage-rule exe TIM.exe, , Hide

; Identify applications that close to the tray
Run, komorebic.exe identify-tray-application exe Discord.exe, , Hide

; Identify applications that have overflowing borders
Run, komorebic.exe identify-border-overflow exe Discord.exe, , Hide

; CONTROLS
; ^ = Ctrl
; ! = Alt
; + = Shift
; # = Win

; Change the focused window, Mod + Vim direction keys
!h::
Run, komorebic.exe focus left, , Hide
return

!j::
Run, komorebic.exe focus down, , Hide
return

!k::
Run, komorebic.exe focus up, , Hide
return

!l::
Run, komorebic.exe focus right, , Hide
return

; Move the focused window in a given direction, Mod + Shift + Vim direction keys
!+h::
Run, komorebic.exe move left, , Hide
return

!+j::
Run, komorebic.exe move down, , Hide
return

!+k::
Run, komorebic.exe move up, , Hide
return

!+l::
Run, komorebic.exe move right, , Hide
return

; Stack the focused window in a given direction, Mod + Shift + direction keys
!+Left::
Run, komorebic.exe stack left, , Hide
return

!+Down::
Run, komorebic.exe stack down, , Hide
return

!+Up::
Run, komorebic.exe stack up, , Hide
return

!+Right::
Run, komorebic.exe stack right, , Hide
return

!]::
Run, komorebic.exe cycle-stack next, , Hide
return

![::
Run, komorebic.exe cycle-stack previous, , Hide
return

; Unstack the focused window, Mod + Shift + D
!+d::
Run, komorebic.exe unstack, , Hide
return

; Promote the focused window to the top of the tree, Mod + Shift + Enter
!+Enter::
Run, komorebic.exe promote, , Hide
return

; Switch to an equal-width, max-height column layout on the main workspace, Mod + Shift + C
!+c::
Run, komorebic.exe workspace-layout 0 0 columns, , Hide
return

; Switch to the default bsp tiling layout on the main workspace, Mod + Shift + T
!+t::
Run, komorebic.exe workspace-layout 0 0 bsp, , Hide
return

; Toggle the Monocle layout for the focused window, Mod + Shift + F
!+f::
Run, komorebic.exe toggle-monocle, , Hide
return

; Toggle native maximize for the focused window, Mod + Shift + =
!+=::
Run, komorebic.exe toggle-maximize, , Hide
return

; Flip horizontally, Mod + X
!x::
Run, komorebic.exe flip-layout horizontal, , Hide
return

; Flip vertically, Mod + Y
!y::
Run, komorebic.exe flip-layout vertical, , Hide
return

; Force a retile if things get janky, Mod + R
!r::
Run, komorebic.exe retile, , Hide
return

; Float the focused window, Mod + T
!t::
Run, komorebic.exe toggle-float, , Hide
return

; Reload ~/komorebi.ahk, Mod + Shift + R
!+r::
Run, komorebic.exe reload-configuration, , Hide
return

; Pause responding to any window events or komorebic commands, Mod + P
!p::
Run, komorebic.exe toggle-pause, , Hide
return

; Switch to workspace
!1::
Send !
Run, komorebic.exe focus-workspace 0, , Hide
return

!2::
Send !
Run, komorebic.exe focus-workspace 1, , Hide
return

!3::
Send !
Run, komorebic.exe focus-workspace 2, , Hide
return

!4::
Send !
Run, komorebic.exe focus-workspace 3, , Hide
return

!5::
Send !
Run, komorebic.exe focus-workspace 4, , Hide
return

; Move window to workspace
!+1::
Run, komorebic.exe move-to-workspace 0, , Hide
return

!+2::
Run, komorebic.exe move-to-workspace 1, , Hide
return

!+3::
Run, komorebic.exe move-to-workspace 2, , Hide
return

!+4::
Run, komorebic.exe move-to-workspace 3, , Hide
return

!+5::
Run, komorebic.exe move-to-workspace 4, , Hide
return

; Programs

; Quit currently focused program
!q::
WinClose, A
return

; Open Windows Terminal
!Enter::
Run, %USERPROFILE%\AppData\Local\Microsoft\WindowsApps\wt.exe
return