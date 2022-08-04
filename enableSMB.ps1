#Sets network rules as publicly acessible for everyone 
netsh advfirewall firewall set rule group="Network Discovery" new enable=Yes
Set-NetFirewallRule -DisplayGroup "File And Printer Sharing" -Enabled True -Profile Any


#Makes local network discovery actually work on windows???? 
$RegistryPath = 'HKLM:SYSTEM\CurrentControlSet\Services\LanmanWorkstation\Parameters'
$Name = 'requiresecuritySignature'
$Value = '0'
New-ItemProperty -Path $RegistryPath -Name $Name -Value $Value -PropertyType DWORD -Force 


#Supposed to make local folders accessible without any protection, but windows 10 is shit so it doesnt work. Needs to be done manually so it wont block you from other computers. Remove folder protection in advanced network settings.
$RegistryPath = 'HKLM:SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters'
$Name = 'RestrictNullSessAccess'
$Value = '0'
New-ItemProperty -Path $RegistryPath -Name $Name -Value $Value -PropertyType DWORD -Force 
$RegistryPath = 'HKLM:SYSTEM\CurrentControlSet\Control\Lsa'
$Name = 'everyoneincludesanonymous'
$Value = '1'
New-ItemProperty -Path $RegistryPath -Name $Name -Value $Value -PropertyType DWORD -Force 

#Automatically start smb
Set-service -Name upnphost -StartupType Automatic
Set-service -Name FDResPub -StartupType Automatic
Set-service -Name upnphost -StartupType Automatic
Set-service -Name SSDPSRV -StartupType Automatic

Start-service upnphost

#enable snb
Get-WindowsOptionalFeature -Online -FeatureName "SMB1Protocol"
Enable-WindowsOptionalFeature -Online -FeatureName "SMB1Protocol" -All
