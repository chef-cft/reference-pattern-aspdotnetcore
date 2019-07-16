     Add-Type -TypeDefinition (Get-Content "$PSScriptRoot\LsaWrapper.cs" | Out-String)
     $lsa_wrapper = New-Object -type LsaWrapper
     $lsa_wrapper.SetRight($username, "SeServiceLogonRight")
     $oService = Get-WmiObject -Query "SELECT * FROM Win32_Service WHERE Name = 'habitat'"
     $oService.Change($null,$null,$null,$null,$null,$null,$username,$password) | Out-Null
     Restart-Service -Name Habitat
     
     hab svc load devopslifter/nop-commerce --bind database:sqlserver.default