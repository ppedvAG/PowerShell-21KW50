## Mögliche Lösung zur Übung: Commandlets

### Aufgabe 1:
```powershell
Get-Command -Noun Computer
#oder Alternativ für mehr Ergebnisse wie zb AdComputer
Get-Command -Noun *Computer*
``` 

### Aufgabe 2:
Hierzu sollte vorher ein Download der Hilfe notwendig sein mit **Update-Help**
```powershell
Get-Help Set-Servuce -Examples
```

### Aufgabe 3:

```powershell
Get-Alias -Name dir,cd
#oder
Get-Command -Name dir,cd
#der
Get-Help dir,cd
```

### Aufgabe 4:
```powershell
Get-ChildItem -Path C:\Testfiles\ -Filter *.txt -Recurse | Remove-Item -WhatIf
```