## Mögliche Lösung zur Übung: Formatierung der Ausgabe

### Aufgabe 1:
```powershell
Get-Service | Sort-Object -Property Status,Displayname | Format-Table -GroupBy Status | Out-File -FilePath C:\Testfiles\Services.txt
``` 

