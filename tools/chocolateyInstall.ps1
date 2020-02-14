$packageName = 'apacheds'
$Url = 'http://apache.hippo.nl/directory/apacheds/dist/2.0.0.AM25/apacheds-2.0.0.AM25.zip'
$global:installLocation = "C:\ApacheDS"
$checksum = '0f3aa2011c8723fb79435260d0ee7bbd'
$checksumType = 'md5'

if(!$PSScriptRoot){ $PSScriptRoot = Split-Path $MyInvocation.MyCommand.Path -Parent }
. "$PSScriptRoot\OverwriteParameters030.ps1"
. "$PSScriptRoot\Install-ChocolateyService030.ps1"

OverwriteParameters030

Install-ChocolateyZipPackage "$packageName" "$Url" "$global:installLocation" -checksum "$checksum" -checksumType "$checksumType"

$packageVersion = (gci "$global:installLocation\apacheds-*\").FullName -replace ".*apacheds-" | sort -Descending | Select -first 1
$apachedsHome = "${global:installLocation}\apacheds-${packageVersion}"

Install-ChocolateyService030 "apacheds" "ApacheDS" "nssm install ApacheDS `"java`" -jar `"${apachedsHome}\lib\apacheds-service-${packageVersion}.jar`" `"${apachedsHome}\instances\default-$packageVersion`"" "10389"