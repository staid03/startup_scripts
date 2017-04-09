;Best viewed in Notepad++ with the AHK syntax file installed.
;This file runs through AutoHotkey a highly versatile freeware scripting program.
;
; AutoHotkey Version: 104805
; Language:       English
; Platform:       Windows 7
; Author:         staid03
; Version   Date        Author       Comments
;     0.1   09-APR-17   staid03      Updated for uploading to GITHub and little cleanup.
;
; Script Function:
; To go into the startup folder for all users on my computers and run a set of scripts
;

#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#singleinstance , force

scriptfolder = c:\scripts\startup

run , %scriptfolder%\multipurpose-home.ahk
run , %scriptfolder%\MinimizeToTrayMenu_minimise.ahk
run , %scriptfolder%\WorkLogger.ahk
exit
