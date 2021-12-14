## Mögliche Lösung zur Übung: Pipeline2

### Möglichkeit 1:

```powershell

Import-Csv -Path .\MyNewAdUsers1.csv | New-ADUser
``` 
User werden deaktiviert angelegt da **New-AdUser** nur Passwörter als SecureString akzeptiert.

### Möglichkeit 2:
User werden aktiviert angelegt da das Passwort in einen Securestring konvertiert werden.
```powershell
Import-Csv -Path C:\Testfiles\MyNewAdUsers2.csv | ForEach-Object -Process {
                    New-ADUser -GivenName $PSItem.GivenName `
                               -Surname $PSItem.SurName `
                               -Name $PSItem.Name `
                               -Path $PSItem.Path `
                               -Department $PSItem.Department `
                               -SamAccountName $PSItem.SamAccountName `
                               -Enabled ([bool]::Parse($PSItem.Enabled)) `
                               -AccountPassword (ConvertTo-SecureString -String $PSItem.Password -AsPlainText -Force)
}
``` 


