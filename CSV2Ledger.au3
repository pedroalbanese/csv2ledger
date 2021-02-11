#NoTrayIcon
#include <Array.au3>
#include <File.au3>

If $cmdline[0] == 0 Then
	ConsoleWrite("CSV2Ledger - ALBANESE Lab " & Chr(184) & " 2018-2021" & @CRLF) ;
	ConsoleWrite("Ledger CLI's convert command equivalent." & @CRLF & @CRLF) ;
	ConsoleWrite("Usage:    " & @ScriptName & " <inputfile> <source:account> <target:account>" & @CRLF) ;
	ConsoleWrite("          " & @ScriptName & " <inputfile> <target:account>" & @CRLF & @CRLF) ;
	ConsoleWrite("INI File: [<alias>]" & @CRLF) ;
	ConsoleWrite("          Account=<source:account>" & @CRLF) ;
	Exit
EndIf
Dim $arecords
If Not _FileReadToArray($cmdline[1], $arecords) Then
	MsgBox(4096, "Error", " Error reading log to Array     error:" & @error)
	Exit
EndIf
$atemp = StringSplit($arecords[1], ",")
$code = ""
For $x = 1 To $atemp[0]
	If $atemp[$x] = "date" Then
		$datef = $x
	EndIf
Next
For $x = 1 To $atemp[0]
	If $atemp[$x] = "payee" Then
		$payeef = $x
	EndIf
Next
If StringInStr($arecords[1], "code") Then
	For $x = 1 To $atemp[0]
		If $atemp[$x] = "code" Then
			$codef = $x
		EndIf
	Next
EndIf
For $x = 1 To $atemp[0]
	If $atemp[$x] = "amount" Then
		$amountf = $x
	EndIf
Next
If StringInStr($arecords[1], "cost") Then
	For $x = 1 To $atemp[0]
		If $atemp[$x] = "cost" Then
			$costf = $x
		EndIf
	Next
EndIf
For $x = 2 To $arecords[0]
	$btemp = StringSplit($arecords[$x], ",")
	If $cmdline[0] == 2 Then
		If StringInStr($arecords[1], "cost") Then
			$acc1 = "Expenses:Unknown"
			$date = $btemp[$datef]
			If IsDeclared("codef") Then
				If $btemp[$codef] <> "" Then
					$code = "(" & $btemp[$codef] & ") "
				Else
					$code = ""
				EndIf
			EndIf
			$payee = $btemp[$payeef]
			$asections = IniReadSectionNames("CSV2Ledger.ini")
			For $i = 1 To $asections[0]
				If StringInStr($payee, $asections[$i]) Then
					$section = IniReadSection("CSV2Ledger.ini", $asections[$i])
					$acc1 = $section[1][1]
				EndIf
			Next
			$acc2 = $cmdline[2]
			$cost = $btemp[$costf]
			$amount = $btemp[$amountf]
			If StringLeft($amount, 2) <> "-1" Or StringLeft($amount, 1) == "$" Then
				$amount2 = "                                                " & $amount
			Else
				$amount2 = "                                                " & $amount
			EndIf
			If StringLeft($amount, 1) == "-" Then
				$amount3 = "                                                " & $cost
			Else
				If $cost == "" Then
					$amount3 = " "
				Else
					$amount3 = "                                               " & "-" & $cost
				EndIf
			EndIf
			$plength = StringLen($amount)
			$ilength = StringLen($acc1)
			$rlength = StringLen($acc2)
			$jlength = StringLen($cost)
			$tlength = StringTrimLeft($amount3, $rlength)
			$tlength = StringTrimLeft($tlength, $jlength)
			$slength = StringTrimLeft($amount2, $plength)
			$slength = StringTrimLeft($slength, $ilength)
			ConsoleWrite(@CRLF & $date & " * " & $code & $payee & @CRLF & "    " & $acc1 & $slength & @CRLF & "    " & $acc2 & $tlength & @CRLF)
		Else
			$acc1 = "Expenses:Unknown"
			$date = $btemp[$datef]
			If IsDeclared("codef") Then
				If $btemp[$codef] <> "" Then
					$code = "(" & $btemp[$codef] & ") "
				Else
					$code = ""
				EndIf
			EndIf
			$payee = $btemp[$payeef]
			$asections = IniReadSectionNames("CSV2Ledger.ini")
			For $i = 1 To $asections[0]
				If StringInStr($payee, $asections[$i]) Then
					$section = IniReadSection("CSV2Ledger.ini", $asections[$i])
					$acc1 = $section[1][1]
				EndIf
			Next
			$acc2 = $cmdline[2]
			$amount = $btemp[$amountf]
			$amount2 = "                                                " & $amount
			$plength = StringLen($amount)
			$ilength = StringLen($acc1)
			$slength = StringTrimLeft($amount2, $plength)
			$slength = StringTrimLeft($slength, $ilength)
			ConsoleWrite(@CRLF & $date & " * " & $code & $payee & @CRLF & "    " & $acc1 & $slength & @CRLF & "    " & $acc2 & @CRLF)
		EndIf
	EndIf
	If $cmdline[0] == 3 Then
		If StringInStr($arecords[1], "cost") Then
			$date = $btemp[$datef]
			If IsDeclared("codef") Then
				If $btemp[$codef] <> "" Then
					$code = "(" & $btemp[$codef] & ") "
				Else
					$code = ""
				EndIf
			EndIf
			$payee = $btemp[$payeef]
			$acc1 = $cmdline[2]
			$acc2 = $cmdline[3]
			$cost = $btemp[$costf]
			$amount = $btemp[$amountf]
			If StringLeft($amount, 2) <> "-1" Or StringLeft($amount, 1) == "$" Then
				$amount2 = "                                                " & $amount
			Else
				$amount2 = "                                                " & $amount
			EndIf
			If StringLeft($amount, 1) == "-" Then
				$amount3 = "                                                " & $cost
			Else
				If $cost == "" Then
					$amount3 = " "
				Else
					$amount3 = "                                               " & "-" & $cost
				EndIf
			EndIf
			$plength = StringLen($amount)
			$ilength = StringLen($acc1)
			$rlength = StringLen($acc2)
			$jlength = StringLen($cost)
			$tlength = StringTrimLeft($amount3, $rlength)
			$tlength = StringTrimLeft($tlength, $jlength)
			$slength = StringTrimLeft($amount2, $plength)
			$slength = StringTrimLeft($slength, $ilength)
			ConsoleWrite(@CRLF & $date & " * " & $code & $payee & @CRLF & "    " & $acc1 & $slength & @CRLF & "    " & $acc2 & $tlength & @CRLF)
		Else
			$date = $btemp[$datef]
			If IsDeclared("codef") Then
				If $btemp[$codef] <> "" Then
					$code = "(" & $btemp[$codef] & ") "
				Else
					$code = ""
				EndIf
			EndIf
			$payee = $btemp[$payeef]
			$acc1 = $cmdline[2]
			$acc2 = $cmdline[3]
			$amount = $btemp[$amountf]
			$amount2 = "                                                " & $amount
			$plength = StringLen($amount)
			$ilength = StringLen($acc1)
			$slength = StringTrimLeft($amount2, $plength)
			$slength = StringTrimLeft($slength, $ilength)
			ConsoleWrite(@CRLF & $date & " * " & $code & $payee & @CRLF & "    " & $acc1 & $slength & @CRLF & "    " & $acc2 & @CRLF)
		EndIf
	EndIf
Next
