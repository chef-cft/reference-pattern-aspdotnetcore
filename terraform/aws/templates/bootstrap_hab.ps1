SETX HAB_LICENSE accept-no-persist /m
$env:HAB_LICENSE="accept-no-persist"
# Set registry keys to enforce use of TLS 1.2
Set-ItemProperty -Path 'HKLM:\SOFTWARE\Wow6432Node\Microsoft\.NetFramework\v4.0.30319' -Name 'SchUseStrongCrypto' -Value '1' -Type DWord
Set-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\.NetFramework\v4.0.30319' -Name 'SchUseStrongCrypto' -Value '1' -Type DWord
Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/habitat-sh/habitat/master/components/hab/install.ps1'))

# seen this randomly fail with flaky internet errors
# so try until we succeed
do{
    hab pkg install core/windows-service
}
until($LASTEXITCODE -eq 0)

hab pkg exec core/windows-service install
New-NetFirewallRule -DisplayName 'Habitat TCP' -Direction Inbound -Action Allow -Protocol TCP -LocalPort 9631,9638
New-NetFirewallRule -DisplayName 'Habitat UDP' -Direction Inbound -Action Allow -Protocol UDP -LocalPort 9638

$svcPath = Join-Path $env:SystemDrive "hab\svc\windows-service"
[xml]$configXml = Get-Content (Join-Path $svcPath HabService.dll.config)
$configXml.configuration.log4net.appender.file.value
$configXml.configuration.appSettings.add[1].value = "--no-color --peer=${peer_ip}"
$configXml.Save((Join-Path $svcPath HabService.dll.config))