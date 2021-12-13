## Mögliche Lösung zur Übung: Pipeline 2

### Aufgabe 1:
```powershell
Get-Process -Name svchost | Measure-Object -Property PM -Sum
``` 

### Fleißaufgabe 1:
```powershell
(Get-Process -Name svchost | Measure-Object -Property PM -Sum).Sum / 1MB
```

### Fleißaufgabe 2:
```powershell
"{0:N2}" -f ((Get-Process -Name svchost | Measure-Object -Property PM -Sum).Sum / 1MB)
#oder mit Hashtable
Get-Process -Name svchost | Measure-Object -Property PM -Sum | Select-Object -Property @{n="Ram(MB)";e={"{0:N2}" -f ($PSItem.Sum / 1MB)}}
```
### Zusatzanfrage 
```powershell
Get-Process | Select-Object -Unique ProcessName | Format-Table -Property ProcessName, `
@{n="Count";e={(Get-Process -Name $PSItem.ProcessNAme | Measure-Object).Count}}, `
@{n="SumPM(MB)";e={(Get-Process -Name $PSItem.ProcessName | Measure-Object -Property PM -Sum).Sum / 1MB};formatString='N2'}
```
