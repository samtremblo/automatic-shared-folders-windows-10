# Automatic-shared-drives-win10
Windows 10 is shit for public shared drives on a local network, automates the process using C drive,

**this shares the whole C drive to everyone by default on the local network. Use at your own risk.**

1. clone repo
2. cd  */ Automatic-shared-drives-win10
3. as administrator, run ./enableSMB.ps1 , Will allow you to see and access public drives on local network.
4. as administrator, run ./shareDrive  , **will share your whole c drive to local network**
5. go to Control Panel\Network and Internet\Network and Sharing Center\Advanced sharing settings and disable password protected sharing
