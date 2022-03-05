;
; AutoHotkey Version: 1.x
; Language:       English
; Platform:       WinNT
; Author:         David Earls
;
; Script Function:
;   Ghost inactive Windows like XFCE
;
; Attribution: The code to loop through windows was paraphrased from the AHK forums.
; script of Unambiguous adjusted for use with PSPad
;
; Modified by Jesse Elliott
;
; - Added configurable Fade Step for fade in and fade out
; - No longer replace the standard menu, rather 'Configure' is simply added to it
; - Added a check to make sure the system tray icon exits
; - Loop through windows much more often (every 200 ms) for better responsiveness
; - Moved processname code further down to improve performance (6% to 1% CPU)
; - Make the active window non-transparent first, before making other windows transparent
; - Make all windows in the active process (based on PID) non-transparent (i.e. Find Dialogs, menus, etc.)
; - Fixed Drag artifacts (transparent box when dragging Desktop icons)
; - Keep track of currently active process (brings CPU to 0%)
; - Fixed regression in Inactive Delay
; - Added excludes for sidebar.exe and windows with title starting with 'layer-'


#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
;SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

IfNotExist %A_AppData%\FadeToBlack
 FileCreateDir  %A_AppData%\FadeToBlack
If not errorlevel
    SetWorkingDir %A_AppData%\FadeToBlack

;SetTitleMatchMode, 2
#SingleInstance, force
DetectHiddenWindows, Off 
#ErrorStdOut

; Configurable Values
iniread, TransLvl, fadetoblack.ini, Preferences, Transparent, 200
iniread, fadeStep, fadetoblack.ini, Preferences, FadeStep, 10
iniread, DisableFade, fadetoblack.ini, Preferences, DisableFade, 0
iniread, delay, fadetoblack.ini, Preferences, Delay, 0
iniread, Utilization, fadetoblack.ini, Preferences, Utilization, 1000

IfExist, f2bexclusions.txt
   FileRead, ExclusionsFile, f2bexclusions.txt



;Account for people jacking with advanced settings.
if Utilization > 1000
    AdjDelay:=Delay/(Utilization/1000)
else if Utilization < 1000
    AdjDelay:=Delay*(1000/Utilization)
else
    AdjDelay:=Delay
AdjDelay:=Round(AdjDelay)


if not A_IsCompiled
{
ifexist %A_Windir%\System32\accessibilitycpl.dll
  menu, tray, icon, %A_Windir%\System32\accessibilitycpl.dll, 15
else ifexist %A_Windir%\System32\moricons.dll
  menu, tray, icon, %A_Windir%\System32\moricons.dll, 50
}
else
    menu, tray, nostandard
menu, tray, add, &Configure, Configure
menu, tray, default, &Configure
menu, tray, add
menu, tray, add, &About, MenuAbout
menu, tray, tip, Fades Inactive Windows - Please exit through Config.


; keep track of the current active PID for performance reasons
curActivePID = -1


OnExit, ExitRoutine
SetTimer, CheckIfActive,  %Utilization%

#a::
ActiveHwnd := WinExist("A")
WinGetTitle, WindowTitle, ahk_id %ActiveHwnd%
WinGet, ExStyle, ExStyle, ahk_id %ActiveHwnd%
if (ExStyle & 0x8)
    OnTop=1
else
    OnTop=0
Winset, AlwaysOnTop, Toggle, ahk_id %ActiveHwnd%

StringReplace, WindowTitle, WindowTitle, %A_Space%- (Pinned)
if not OnTop
  WindowTitle:=WindowTitle . " - (Pinned)"
  
WinSetTitle, ahk_id %ActiveHwnd%,,%WindowTitle%
return

;Fix windows that don't go back or set active.
#v::
winset, Trans, 255, A
winset, Trans, off, A
return

+#v::
TransLvlM:=Translvl+1
winset, trans, %TransLvlM%, A
return



return ;Just in case

CheckIfActive:

WinGet, active_pid, PID, A

; if the active process hasn't changed, don't do anything
if (active_pid = curActivePID)
{
    canReturn = 1

    if (delay)
    {
        WinGet, id, list, , , Program Manager
        Loop, %id%
        {
            StringTrimRight, this_id, id%a_index%, 0

            if wininactive%this_id% > 0
            {
                canReturn = 0
                break
            }
        }
    }

    if (canReturn)
        return
}

curActivePID := active_pid


; Set the active window non-transparent first
WinGet, activeTrans, Transparent, A

if activeTrans = %TransLvl%
{
    fadeTrans := TransLvl
    if not DisableFade
    While, fadeTrans < 255
    {
        fadeTrans += fadeStep

        if (fadeTrans < 255)
        {
          Winset, Transparent, %fadeTrans%, A
          Sleep, 5
        }
    }

    ; set to 255 first as suggested in Help to avoid black background issues
    winset, Transparent, 255, A
    winset, Transparent, Off, A
}


; loop through all windows
WinGet, id, list, , , Program Manager
Loop, %id%
{
    StringTrimRight, this_id, id%a_index%, 0
    WinGetTitle, title, ahk_id %this_id%
    WinGetClass class , ahk_id %this_id%
    WinGet, pid, PID, ahk_id %this_id%
    WinGet, id_trans, ID, ahk_id %this_id%
    WinGet, Trans, Transparent, ahk_id %this_id%
    WinGet, ISMinimized, MinMax, ahk_id %this_id%
    
    if ISMinimized <> -1 ;Makes variable easier to understand.
        IsMinimized=
    else
        IsMinimized=1

    ; if this is a window in the active process, Set non-transparent
    if (pid = active_pid)
    {
        ; if transparent
        if Trans = %TransLvl%
        {
            fadeTrans := TransLvl
            if not DisableFade
            While, fadeTrans < 255
            {
                fadeTrans += fadeStep

                if (fadeTrans < 255)
                {
                  Winset,Transparent, %fadeTrans%, ahk_id %id_trans%
                  Sleep, 5
                }
            }

            ; set to 255 first as suggested in Help to avoid black background issues
            winset, Transparent, 255, ahk_id %id_trans%
            winset, Transparent, Off, ahk_id %id_trans%
        }
        continue
    }
; Exclusions    
    
    If title =
        continue
    if class = Shell_TrayWnd ; taskbar
        continue
    if class = Button ; Start Menu
        continue
    if class = SysDragImage ; Drag Objects
        continue
    if class = WorkerW ; Desktop
        continue
    if IsMinimized
        continue
    
    ; if the title starts with 'layer-', continue
    StringGetPos, strPos, title, layer-
    if (strPos = 0)
        continue
    If Trans = %TransLvl% ; already Transparent
        continue
    if Trans is not space ;Skips windows with own setting
        continue
    
    winget processname, processname, ahk_id %this_id% ;Moved for performance improvement.
    if (processname = "PSPad.exe" and class = "TApplication" )
        continue
    if (processname = "devenv.exe") ; Visual Studio doesn't support transparency (WS_EX_LAYERED is not set)
        continue
    if (processname = "sidebar.exe")
        continue
    
    ExcludedFromFile=0
    loop, parse, ExclusionsFile,`n,`n`r%A_Space%%A_Tab%
    {
        if (processname = A_LoopField)
 {
            ExcludedFromFile=1
 break
 }
    }
    if ExcludedFromFile
        continue

;End Exclusions

    fadeTrans = 255    
    if Delay
    {
        if wininactive%ID_trans% < %AdjDelay%
             wininactive%ID_trans% += 1
        else
        {
        if not DisableFade
        While, fadeTrans > TransLvl
        {
            fadeTrans -= fadeStep

            if (fadeTrans > TransLvl)
            {
            Winset,Transparent, %fadeTrans%, ahk_id %id_trans%
            Sleep, 30
        }
    }
    Winset, Transparent, %TransLvl%, ahk_id %id_trans%
            wininactive%ID_trans% = 0
        }
    }
    else
   { 
    if not DisableFade
    While, fadeTrans > TransLvl
    {
        fadeTrans -= fadeStep

        if (fadeTrans > TransLvl)
        {
          Winset,Transparent, %fadeTrans%, ahk_id %id_trans%
          Sleep, 30
        }
    }

    Winset, Transparent, %TransLvl%, ahk_id %id_trans%
       wininactive%ID_trans% = 0
    }
}
return

; on exit, set windows back to non-transparent
ExitRoutine:
SetTimer, CheckIfActive, off
sleep 500
WinGet, id, list, , , Program Manager
Loop, %id%
{
    StringTrimRight, this_id, id%a_index%, 0
    WinGetTitle, title, ahk_id %this_id%
    WinGetClass class , ahk_id %this_id%
    winget processname,processname, ahk_id %this_id%
    WinGet, id_trans, ID, ahk_id %this_id%
    WinGet, Trans, Transparent, ahk_id %this_id%

    ; Exclusions    
    
    If title =
        continue
    
    if class = Shell_TrayWnd
        continue
    if class = Button ;you get a large square if you remove this.
       continue
    if class = SysDragImage ; Drag Objects
       continue
    if class = WorkerW ; Desktop
        continue
    if Trans <> %TransLvl% ;only if we did it...
       Continue
    if (processname = "PSPad.exe" and class = "TApplication" )
        continue
    if (processname = "devenv.exe") ; Visual Studio doesn't support transparency (WS_EX_LAYERED is not set)
        continue
    if (processname = "sidebar.exe")
        continue
    
    ExcludedFromFile=0
    loop, parse, ExclusionsFile,`n,`n`r%A_Space%%A_Tab%
    {
        if (processname = A_LoopField)
 {
            ExcludedFromFile=1
 break
 }
    }
    if ExcludedFromFile
        continue
    
    ; set to 255 first as suggested in Help to avoid black background issues
    Winset,Transparent,255, ahk_id %id_trans%
    Winset,Transparent,off, ahk_id %id_trans%
}
ExitApp
return


Configure:
ifwinexist, Configure, Transparency:
{
  gui, destroy
  return
}
USliderPos:=Utilization/100

gui, add, button,gSaveSettings,&Save and Reload
gui, add, button,x+10 gExitRoutine,&Quit Program
gui, add, text,xm,Transparency:
gui, add, text,,Ghost
gui, add, slider,x+5 vTransSlider Range20-255 tooltip,%TransLvl%
gui, add, text,x+5,HiDef
gui, add, text,xm,`nInactivity Delay (Seconds):
gui, add, text,,Zero
gui, add, slider,x+5 tooltip vDelaySlider Range0-90, %delay%
gui, add, text,x+5,Ninety
gui, add, text,cblue gshowadvanced xm, Toggle Advanced
if disablefade
{
    chstatus=Checked
    fadehidden=Hidden
}
else
{
    chstatus=
    fadehidden=
}
gui, add, checkbox,xm vDisableFadeC gFadeHide %chstatus%,Disable Fade
gui, add, text,xm vfade1 %fadehidden%,Fade Step:
gui, add, text,vfade2 %fadehidden%,Slow
gui, add, slider,x+5 vFadeSlider Range1-50 tooltip %fadehidden%,%fadeStep%
gui, add, text,x+5 vfade3 %fadehidden%,Fast

gui, add, text,ym vhide3 hidden, Utilization
gui, add, text,vhide1 Hidden,Harsh
gui, add, slider, vUtilizationSlider Range2.5-30 ToolTip Vertical Hidden, %USliderPos%
gui, add, text, vhide2 hidden,Gamer




gui, show,AutoSize,Configure
return ;the gui

FadeHide:
gui, submit
if disablefadeC
{
    guicontrol, hide, fade1
    guicontrol, hide, fade2
    guicontrol, hide, fade3
    guicontrol, hide, FadeSlider
}
else
  {
    guicontrol, show, fade1
    guicontrol, show, fade2
    guicontrol, show, fade3
    guicontrol, show, FadeSlider
}  
gui, show, AutoSize
return

showadvanced:
if advancedshown
{
    gui, hide
    guicontrol, hide, UtilizationSlider
    guicontrol, hide, hide1
    guicontrol, hide, hide2
    guicontrol, hide, hide3
    advancedshown=
    gui, show, autosize
}
else
{
gui, hide
guicontrol, show, UtilizationSlider
guicontrol, show, hide1
guicontrol, show, hide2
guicontrol, show, hide3
advancedshown=1
gui, show, autosize
}
return

SaveSettings:
gui, submit
UtilizationSlider:=UtilizationSlider*100
if TransLvl <> %TransSlider%
  iniwrite, %TransSlider%, fadetoblack.ini, Preferences, Transparent
if DelaySlider <> %Delay%
  iniwrite, %DelaySlider%, fadetoblack.ini, Preferences, Delay
if UtilizationSlider <> %Utilization%
  iniwrite, %UtilizationSlider%, fadetoblack.ini, Preferences, Utilization
if FadeSlider <> %fadeStep%  
  iniwrite, %FadeSlider%,  fadetoblack.ini, Preferences, FadeStep
if DisableFadeC <> %DisableFade%  
  iniwrite, %DisableFadeC%, fadetoblack.ini, Preferences, DisableFade

reload
return

MenuAbout:
IfWinNotExist, About Fade to Black, Fade inactive windows.
 MsgBox, 8256, About Fade to Black,
 (
Fade inactive windows.
Version 0.103 4/18/2011
 
GPL 3 ©2011 By David Earls
 
Fades inactive windows after a specified time. You may also configure the transparency level, delay, fade, and priority. Use the configure menu to save your options or exit.
 
Shortcut Keys:
Win+a`tSet a window Always on Top.
Win+v`tManually unfade a Window.
Win+V`tManually fade a Window.
 
Contributors:
 
Jesse Elliot dramatic performance improvements, including tracking the current process, reorganizing the process queries, actually most of the performance in general, and the implementing the fade effect.

Jon S the idea for making child windows match the parent's transparency.

Bruno lots of testing and comments.
 
Meatloaf for testing, the idea to add a fade effect, and Lifehacker comments.
)
return

GuiEscape:
GuiClose:
gui, destroy
return

return ;configure sub
