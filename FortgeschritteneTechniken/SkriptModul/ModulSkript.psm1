function New-TestFilesDir
{
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
        #Wird später durch etwas besseres ersetzt.
        Write-Host -Object "Ordner bereits vorhanden" -ForegroundColor Red
        exit
    }
}
else
{
    New-Item -Path $TestFilesDir -ItemType Directory
}

New-TestFiles -Destinationpath $TestFilesDir -FileCount $FileCount -Name "File"

for($i = 1; $i -le $DirCount; $i++)
{
    $DirNumber = "{0:D3}" -f $i
    $DirName = "Directory" + $DirNumber

    $subdir = New-Item -Path $TestFilesDir -Name $DirName -ItemType Directory

    New-TestFiles -Destinationpath $subdir.FullName -FileCount $FileCount -Name ("Dir$i" + "Datei")
}
}

function New-TestFiles
{
[cmdletBinding()]
param(
    [Parameter(Mandatory=$true)]
    [ValidateScript({Test-Path -Path $PSItem})]
    [string]$Destinationpath,

    [ValidateRange(1,100)]
    [int]$FileCount = 9,

    [ValidateLength(3,20)]
    [string]$Name = "File"
)

    for($i = 1; $i -le $FileCount; $i++)
    {
        $FileNumber = "{0:D3}" -f $i
        $FileName = $Name + $FileNumber + ".txt"
   
        New-Item -Path $Destinationpath -Name $FileName -ItemType File
    }
}
