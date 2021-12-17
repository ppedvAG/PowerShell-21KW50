function Color-Console {
    $Host.ui.RawUI.BackgroundColor = "White"
    $Host.UI.RawUI.ForegroundColor = "Black"

    $opentime = (Get-Date).ToShortTimeString()
    $Version = $Host.Version.Major
    $Host.UI.RawUI.WindowTitle = "$opentime PSVersion:$Version"

    if((Get-Command -Name Set-PSReadlineOption).Version.Major -lt 2)
    {
        Set-PSReadlineOption -TokenKind Command -ForegroundColor DarkBlue
        Set-PSReadlineOption -TokenKind Comment -ForegroundColor Green
        Set-PSReadlineOption -TokenKind Variable -ForegroundColor DarkCyan
        Set-PSReadlineOption -TokenKind Member -ForegroundColor DarkRed
        Set-PSReadlineOption -TokenKind Number -ForegroundColor Magenta
    }
    else
    {
        Set-PSReadLineOption -Colors @{"Parameter" = [ConsoleColor]::Blue
                               "Command"   = [Consolecolor]::DarkBlue
                               "Number"    = [Consolecolor]::DarkRed
                               "Member"    = [ConsoleColor]::Gray
                               "String"    = [Consolecolor]::DarkGreen
                               "Comment"   = [ConsoleColor]::Green
                               "Keyword"   = [ConsoleColor]::Magenta
                               "None"      = [ConsoleColor]::Black
                               "Operator"  = [ConsoleColor]::DarkMagenta
                               "Type"      = [ConsoleColor]::Cyan
                               "Variable"  = [ConsoleColor]::DarkCyan}
    }  

    Clear-Host
}

Color-Console

function Get-Motd
{
   $motd = Invoke-RestMethod -Uri "http://numbersapi.com/random/?json"

   return $motd
}
$motd = Get-Motd
Write-Host -Object  $motd.text

$LineNumber=0

function Prompt
{
    $identiy = [Security.Principal.WindowsIdentity]::GetCurrent()
    $principal = [Security.Principal.WindowsPrincipal] $identiy
    $adminrole = [Security.Principal.windowsBuiltinRole]::Administrator

    if($principal.IsInRole($adminrole))
    {
        $Status = "[EL]"
    }
    else
    {
        $Status = "[US]"
    }

    $location = Get-Location
    $global:LineNumber ++
    if($location.Path.Length -gt 25)
    {
        Write-Host -Object "Path:  $($location.Path)"
        Write-Host -Object "$LineNumber $status" -NoNewline
    }
    else
    {
        Write-Host -Object "$LineNumber $($location.Path)" -NoNewline
    }
}