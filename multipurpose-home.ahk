;Best viewed in Notepad++ with the AHK syntax file installed.
;This file runs through AutoHotkey a highly versatile freeware scripting program.
;
; AutoHotkey Version: 104805
; Language:       English
; Platform:       Windows 7
; Author:         staid03
; Version   Date        Author       Comments
;     0.1   04-DEC-14   staid03      Initial
;     0.2   13-JAN-15   staid03      Updated for the screenshot path so that I can save the screenshots 
;                                    from alt work location to my laptop c: drive // removed in 0.7
;     0.3   08-JUL-15   staid03      Added #k for keeping records of URLs in browsers (c:\temp\reviewlater.html)
;     0.4   14-SEP-15   staid03      Updated timeouts for taking screenshots (in MSPaint)
;     0.5   30-OCT-16   staid03      Added snipping tool feature // removed in 0.7
;     0.6   09-DEC-16   staid03      Removed a bunch of work stuff to make this for home only
;     0.7   09-APR-17   staid03      Updated for uploading to GITHub and little cleanup.
;                                    This script is purely for my own use.
;
; Script Function:
;    Multipurpose script to run in the background for running hotkeys and having shortcut text
;
 
#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#singleinstance , force
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
 
;variables
{
	mspaintwin = Untitled - Paint                 ;set the name of the MSPaint Window (new)
	screenshot_path = c:\screenshots
	ifnotexist , %screenshot_path%
	{
		filecreatedir , %screenshot_path%
		if errorlevel
		{
			msgbox ,,, %screenshot_path% does not exist - you will not be able`nto save screenshots until it does (or you modify the script)                                           
		}
	}
}
return
 
 
;Printscreens - both alt prtscr and full prtscr
{
	;Alt PrintScreen - for capturing a screenshot of the active window
	#[::
	{
		sleep , 100
		send , !{PrintScreen}
		gosub , createImage
	}
	return
	
	;All PrintScreen - for capturing a screenshot of the whole current screen
	#]::
	{
		sleep , 100
		send , {PrintScreen}
		gosub , createImage
	}
	return
	
	;manage and save the captured screenshot
	createImage:
	{
		run , mspaint
		formattime , ntime , , yyyyMMMdd_HHmmss
		outfile = %screenshot_path%\sshot_%ntime%
		winwaitactive , %mspaintwin%
		sleep , 200
		send , ^v
		sleep , 600
		send , !f
		sleep , 200
		send , a
		winwaitactive , Save As
		sleep , 500
		send , %outfile%{enter}
	}
	return
}
return 					;not necessary but delineating the end of this section
 
#k::
{
	bookmarkFileLocation = c:
	bookmarkFile = %bookmarkFileLocation%\reviewlater.html
	ifnotexist , %bookmarkFileLocation%
	{
		msgbox ,,, File location %bookmarkFileLocation% doesn't exist - this subscript ending here`n`nSee script running %a_scriptname%
		return
	}

	wingetactivetitle , wintitlevar
	send , ^a
	sleep , 100
	send , ^c
	sleep , 100
	fileappend , <a href="%clipboard%">%wintitlevar%</a><br>`n, %bookmarkfile%
}
return
 
;for adding or removing comments - update the commentchars var for comment character(s)
^!q::
{
	commentchars = --
;	commentchars = `;
	stringlen , slen , commentchars
	send , {home}
	sleep , 50
	send , {shift down}{right %slen%}
	send , {shift up}
	prevclipboard = %clipboard%
	sleep , 50
	send , ^c
	sleep , 50
	ifequal , clipboard , %commentchars%
	{
		;if commentchars exists, remove them
		send , {del}
		sleep , 20
		send , {end}
		sleep , 50
	}
	else
	{
		;if commentchars don't exist, add them
		send , {home}%commentchars%{end}
		sleep , 50
	}
	clipboard = %prevclipboard%
}
return 