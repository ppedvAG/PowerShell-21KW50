<#
.SYNOPSIS
    Kurzbeschreibung: Abfrage von Events
.DESCRIPTION
    Langebschreibung: Dieses Skript kann dazu verwenden werden Events (Anmeldung,Abmeldung,fehlgeschlagene Anmeldung) aus dem EventLog abzufragen und aufzulisten.
.PARAMETER EventId
    Hiermit kann das zu abfragende Event spezifiziert werden.
    Mögliche Werte sind: 4624 | 4625 | 4634
.EXAMPLE
Get-LogonEvent.ps1 -EventId 4634

   Index Time          EntryType   Source                 InstanceID Message
   ----- ----          ---------   ------                 ---------- -------
   45485 Dez 15 13:41  SuccessA... Microsoft-Windows...         4634 Ein Konto wurde abgemeldet....
   45482 Dez 15 13:41  SuccessA... Microsoft-Windows...         4634 Ein Konto wurde abgemeldet....
   45480 Dez 15 13:40  SuccessA... Microsoft-Windows...         4634 Ein Konto wurde abgemeldet....
   45479 Dez 15 13:40  SuccessA... Microsoft-Windows...         4634 Ein Konto wurde abgemeldet....
   45476 Dez 15 13:39  SuccessA... Microsoft-Windows...         4634 Ein Konto wurde abgemeldet....
.EXAMPLE
 .\Get-LogonEvent.ps1 -EventId 4634 -Verbose
AUSFÜHRLICH: Vom User wurden folgende Werte übergeben
AUSFÜHRLICH: 4634 | 5 | localhost

   Index Time          EntryType   Source                 InstanceID Message
   ----- ----          ---------   ------                 ---------- -------
   45485 Dez 15 13:41  SuccessA... Microsoft-Windows...         4634 Ein Konto wurde abgemeldet....
   45482 Dez 15 13:41  SuccessA... Microsoft-Windows...         4634 Ein Konto wurde abgemeldet....
   45480 Dez 15 13:40  SuccessA... Microsoft-Windows...         4634 Ein Konto wurde abgemeldet....
   45479 Dez 15 13:40  SuccessA... Microsoft-Windows...         4634 Ein Konto wurde abgemeldet....
   45476 Dez 15 13:39  SuccessA... Microsoft-Windows...         4634 Ein Konto wurde abgemeldet....
#>
[cmdletBinding()]
param(
[Parameter(Mandatory=$true)]
[ValidateSet(4624,4625,4634)]
[int]$EventId,

[ValidateRange(5,10)]
[int]$Newest = 5,

[ValidateScript({Test-NetConnection -ComputerName $PSItem -commonTCPPort WinRm -InformationLevel Quiet})]
[string]$ComputerName = "localhost"

)

Write-Verbose -Message "Vom User wurden folgende Werte übergeben"
Write-Verbose -Message "$EventId | $Newest | $ComputerName"

Write-Debug -Message "Vor Abfrage"

Get-EventLog -LogName Security -ComputerName $ComputerName | Where-Object EventId -eq $EventId | Select-Object -First $Newest
