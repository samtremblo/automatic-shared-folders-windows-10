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

#sharepath has to correspond to whatever your shared drive path is. If you changed c:\ to e:\turnip\ this also has to be e:\turnip\ 
$sharepath = "c:\"
$Acl = Get-ACL $SharePath
$AccessRule= New-Object System.Security.AccessControl.FileSystemAccessRule("everyone","FullControl","ContainerInherit,Objectinherit","none","Allow")
$Acl.AddAccessRule($AccessRule)
Set-Acl $SharePath $Acl

#Supposed to make local folders accessible without any protection, but windows 10 is shit so it doesnt work. Needs to be done manually so it wont block you from other computers. Remove folder protection in advanced network settings.
$RegistryPath = 'HKLM:SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters'
$Name = 'RestrictNullSessAccess'
$Value = '0'
New-ItemProperty -Path $RegistryPath -Name $Name -Value $Value -PropertyType DWORD -Force 
$RegistryPath = 'HKLM:SYSTEM\CurrentControlSet\Control\Lsa'
$Name = 'everyoneincludesanonymous'
$Value = '1'
New-ItemProperty -Path $RegistryPath -Name $Name -Value $Value -PropertyType DWORD -Force 
