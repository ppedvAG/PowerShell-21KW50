$NewACL = Get-Acl -Path C:\test

$identity = "ppedv\John.Sheppard"
$right = "FullControl"
$type = "Allow"

#Neue Regel
$Argumentlist = $identity,$right,$type
$rule = New-Object -TypeName System.Security.AccessControl.FileSystemAccessRule -ArgumentList $Argumentlist

$NewACL.SetAccessRule($rule)
Set-Acl C:\test -AclObject $NewACL