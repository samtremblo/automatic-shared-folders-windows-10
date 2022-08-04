#Makes c drive a shared drive
# c is the name that will appear on the other computers
# c:\ is the selected folder for the shared drive
net share c=c:\
Grant-SmbShareAccess -Name "c" -AccountName "Everyone" -AccessRight Full -Force

#Gives everyone acess, uncomment if 2nd not working
#$acl = Get-Acl c:\
#$permission = "Everyone","FullControl","Allow"
#$rule = New-Object System.Security.AccessControl.FileSystemAccessRule $permission
#$acl.SetAccessRule($rule)
#$acl | Set-Acl c:\

#modify sharepath to other folder if changed to give rights
$sharepath = "c:\"
$Acl = Get-ACL $SharePath
$AccessRule= New-Object System.Security.AccessControl.FileSystemAccessRule("everyone","FullControl","ContainerInherit,Objectinherit","none","Allow")
$Acl.AddAccessRule($AccessRule)
Set-Acl $SharePath $Acl
