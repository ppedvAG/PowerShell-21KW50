[cmdletBinding()]
param(
    [Parameter(Mandatory=$true)]
    [ValidateScript({Test-Path -Path $PSItem})]
    [string]$Path,

    [string]$OuPath = "DC=ppedv,DC=kurs",

    [string]$Server = "empty"
)

function Test-AdOrganizationalUnit
{
[cmdletBinding()]
param(
    [Parameter(Mandatory=$true)]
    [string]$Name,

    [string]$OUPath = "DC=ppedv,DC=kurs"
)
    $OU = Get-ADOrganizationalUnit -Filter "Name -eq '$Name'" -SearchBase $OUPath

    switch($OU.Count)
    {
        0 {return $false}
        1 {return $true}
        default {throw "Mehr als eine OU vorhanden"}
    }
}
function Test-AdGroup
{
[cmdletBinding()]
param(
    [Parameter(Mandatory=$true)]
    [string]$Name,

    [string]$OUPath = "DC=ppedv,DC=kurs"
)
    $group = Get-ADGroup -Filter "Name -eq '$Name'" -SearchBase $OUPath
    switch($group.Count)
    {
        0 {return $false}
        1 {return $true}
        default {throw "Mehr als eine Gruppe vorhanden"}
    }
}

if($Server -eq "empty")
{
	$DC = (Resolve-DnsName -Name ppedv.kurs -Type A)[0]
    $Server = (Resolve-DnsName -Name $DC.IP4Address ).NameHost
}

if($Path.EndsWith(".csv"))
{
    Write-Verbose -Message "Case: CSV File"
    $Users = Import-Csv -Path $Path
}
elseif(Test-Path -Path $Path -PathType Container)
{
    $csvfiles = Get-ChildItem -Path $Path -Filter "*.csv"
    if($csvfiles.Length -gt 0)
    {
        Write-Verbose -Message "Case: Path with CSV"
        foreach($file in $csvfiles)
        {
            Write-Verbose -Message ("CSV File: " + $file.FullName)
            $Users += Import-Csv -Path $file.FullName
        }
    }
    else
    {
        throw "Keine .CSV Dateien im Pfad gefunden"
    }
}
else
{
    throw "Keine passenden Dateien im Verzeichnis gefunden"
}

foreach($user in $users)
{
    Write-Debug -Message "UserSchleife"
    $Department = $User.Department
    try
    {
        $oureturn = Test-AdOrganizationalUnit -OUPath $OuPath -Name $Department
    }
    catch
    {
        continue
    }
    if($oureturn -eq $false)
    {
        $targetOu = New-ADOrganizationalUnit -Name $Department -Path $OuPath
    }

    try
    {
        $groupretun = Test-AdGroup -OUPath $OuPath -Name "$Department"
    }
    catch
    {
        continue
    }
    if($groupretun -eq $false)
    {
        Write-Debug -Message "Vor GroupCreation"
        New-ADGroup -Name $Department -Path "OU=$Department,$OuPath" -GroupScope Global
    }

    $newuser = New-ADUser -GivenName $user.GivenName `               -Surname $user.Surname `               -Name $user.Name `
               -SamAccountName $user.SamAccountName `
               -Department $user.DePartment `
               -Path "OU=$Department,$OuPath" `
               -Enabled ([bool]::Parse($user.Enabled)) `
               -AccountPassword (ConvertTo-SecureString -String $user.Password -AsPlainText -Force)  `
               -PassThru

    Add-ADGroupMember -Identity "CN=$Department,OU=$Department,$OuPath" -Members $newuser
}