<#
.Synopsis
   Kurzbeschreibung
.DESCRIPTION
   Lange Beschreibung
.EXAMPLE
   Beispiel für die Verwendung dieses Cmdlets
.EXAMPLE
   Ein weiteres Beispiel für die Verwendung dieses Cmdlets
#>
[cmdletBinding()]
param(
    [Parameter(Mandatory=$true)]
    [ValidateScript({Test-Path -Path $PSItem})]
    [string]$Destinationpath,

    [ValidateLength(5,20)]
    [string]$DirName = "TestFiles",

    [ValidateRange(1,100)]
    [int]$DirCount = 2,

    [ValidateRange(1,100)]
    [int]$FileCount = 9,

    [switch]$Force
)

if($Destinationpath.EndsWith("\"))
{
    $TestFilesDir = $Destinationpath + $DirName + "\"
}
else
{
    $TestFilesDir = $Destinationpath + "\" + $DirName + "\"
}

if(Test-Path -Path $TestFilesDir)
{
    if($Force)
    {
        Get-ChildItem -Path $TestFilesDir | Remove-Item -Recurse -Force
    }
    else
    {
        #Diese Zeile wurde am zweiten Tag beim Punkt Fehlerbehandlung hinzugefügt
        throw "Der Ordner ist bereits vorhanden. Wenn dieser überschrieben werden soll. Rufen Sie das Skript mit dem Parameter -Force auf"
    }
}
else
{
    New-Item -Path $TestFilesDir -ItemType Directory
}

for($i = 1; $i -le $FileCount; $i++)
{
    $FileNumber = "{0:D3}" -f $i
    $FileName = "Datei" + $FileNumber + ".txt"
    Write-Debug -Message "Root dir FileCreation"
    New-Item -Path $TestFilesDir -Name $FileName -ItemType File
}

for($i = 1; $i -le $DirCount; $i++)
{
    $DirNumber = "{0:D3}" -f $i
    $DirName = "Directory" + $DirNumber

    $subdir = New-Item -Path $TestFilesDir -Name $DirName -ItemType Directory

    for($j = 1; $j -le $FileCount; $j++)
    {
        $FileNumber = "{0:D3}" -f $j
        $FileName = $subdir.Name + "Datei" + $FileNumber + ".txt"

        New-Item -Path $subdir.FullName -Name $FileName -ItemType File
    }
}
