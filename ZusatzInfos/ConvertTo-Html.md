# ConvertTo-Html

Dieser Konvertierung ist ideal für kleine StatusSeiten oder auch um HTML Formatierte E-Mails zu versenden.
```powershell
$a = "<style>"
$a = $a + "BODY{background-color:yellowgreen}"
$a = $a + "TABLE{border-width 1px; border-style: solid; border-color: black; border-collapse: collapse;}"
$a = $a + "TH{border-width 1px; border-style: solid; border-color: black;background-color:thistle}"
$a = $a + "TD{border-width 1px; border-style: solid; border-color: black;background-color:PAleGoldenrod}"
$a = $a + "</style>"

$html = Get-Service | Select-Object -Property Status,Name,DisplayName | ConvertTo-Html -Head $a -Body "<H2>Service Information</H2>"

Out-File -InputObject $html -FilePath C:\Testfiles\services.html -Force
#oder
#Send-MailMessage -BodyAsHtml -Body $html 
```
