; Get the full path of the script
scriptFullPath := A_ScriptFullPath
scriptDirectory := StrReplace(scriptFullPath, A_ScriptName, "")
scriptFileName := SubStr(A_ScriptName, 1, StrLen(A_ScriptName) - 4) ; Remove ".ahk" extension

; Read the config.txt file
configFile := A_ScriptDir . "\" . ".config.ini"

; Read values from the config.txt file
emuPath := IniRead(configFile, "Settings", "EmuPath")
gameDbPath := IniRead(configFile, "Settings", "GameDbPath")
romDir := IniRead(configFile, "RomPath", "RomDir")
startFullScreen := IniRead(configFile, "Settings", "StartFullScreen")
fullScreenWidth := IniRead(configFile, "Settings", "FullScreenWidth")
fullScreenHeight := IniRead(configFile, "Settings", "FullScreenHeight")
debug := IniRead(configFile, "Settings", "Debug")

root := romDir

GAM := ""

; Read each line in the game until a match is found
Contents := FileRead(gameDbPath)  ; Read the entire file into 'Contents' variable

Loop Read gameDbPath `n  ; Loop through each line (assuming newline as delimiter)
{
	Loop parse, A_LoopReadLine, A_Tab
	{
		LineText := A_LoopField
		if LineText = ""
			break

		; Split the line into parts using |
		GameInfo := StrSplit(LineText, "|")

		; Get the number of elements after splitting
		elementCount := GameInfo.Length

		gameTitle := Trim(GameInfo[1])

		; Check if the AHK script's filename matches the GameTitle
		if (gameTitle = scriptFileName)
		{
			gamLayoutArr := Array()

			bootNotes := ""

			Loop(GameInfo.Length) {
				if (A_Index > 1)
				{
					_bootSource := Trim(GameInfo[A_Index])					

					if InStr(_bootSource, ".gam") {
						GAM := Chr(34) . root . "\" . gameTitle . "\" . _bootSource . Chr(34)
						gamLayoutArr.Push GAM
					}  					

					if InStr(_bootSource, "Notes:") {
						bootNotes := _bootSource
					} 					
				}
			}    		
			
			; Run emulator
			Command := Chr(34) emuPath Chr(34) " " gamLayoutArr[1]
			If debug
				MsgBox Format("Command: {1}", Command)
			Run(Command)

			; Start in full screen if config startFullScreen=1
			If (startFullScreen == 1) {
				if WinWaitActive("ahk_exe MFME.exe", , 10) {
					WinActivate("ahk_exe MFME.exe")
					Sleep 3000 ; wait for MFME to load ROM

					Loop {
						WinGetPos &Xpos, &Ypos, &Width, &Height, "ahk_exe MFME.exe" ; Use the window found by WinExist.

						if Width != fullScreenWidth && Height != fullScreenHeight {
							if debug 
								MsgBox "Window size is at " Width "x" Height							
							Send "{F3}" 
						}

						else {
							If debug
								MsgBox "Window size is at " Width "," Height ", Breaking loop..."							
							break
						}

						Sleep 2000 ; wait before next check
					}
				}
			}			
		}    
	}
}

; ============================================================
; Key Bindings
; ============================================================

Esc::
{
	ProcessClose "MFME.exe"
	Run "taskkill /im MFME.exe /F",, "Hide"
	ExitApp	
}