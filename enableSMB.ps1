#Sets network rules as publicly acessible for everyone 
netsh advfirewall firewall set rule group="Network Discovery" new enable=Yes
Set-NetFirewallRule -DisplayGroup "File And Printer Sharing" -Enabled True -Profile Any


#Makes local network discovery actually work on windows???? 
$RegistryPath = 'HKLM:SYSTEM\CurrentControlSet\Services\LanmanWorkstation\Parameters'
$Name = 'requiresecuritySignature'
$Value = '0'
New-ItemProperty -Path $RegistryPath -Name $Name -Value $Value -PropertyType DWORD -Force 

#Automatically start smb
Set-service -Name upnphost -StartupType Automatic
Set-service -Name FDResPub -StartupType Automatic
Set-service -Name upnphost -StartupType Automatic
Set-service -Name SSDPSRV -StartupType Automatic

Start-service upnphost

#enable smb
Get-WindowsOptionalFeature -Online -FeatureName "SMB1Protocol"
Enable-WindowsOptionalFeature -Online -FeatureName "SMB1Protocol" -All
