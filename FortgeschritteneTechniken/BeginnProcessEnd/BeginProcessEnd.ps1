function Test-BPE 
{
[cmdletBinding()]
param(
    [Parameter(Mandatory=$true, ValueFromPipeline=$true)]
    [string]$Parameter
)
    Begin
    {
        Write-Host -Object "Wird am Start einmal ausgeführt" -ForegroundColor Cyan
    }
    Process
    {
        Write-Host -Object "Wird für jedes übergebene Obejkt ausgeführt: $Parameter" -ForegroundColor Green
    }
    End
    {
        Write-Host -Object "Wird am Ende einmal ausgeführt" -ForegroundColor Cyan
    }
}