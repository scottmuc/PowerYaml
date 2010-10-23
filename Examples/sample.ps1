$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path

$module = Join-Path -Path $scriptDir -ChildPath ..\PowerYaml.psm1
$yaml = Join-Path -Path $scriptDir -ChildPath Sample.yml

Import-Module $module

Write-Host -Foreground Green Attempting to call Get-YamlNameValues

Get-YamlNameValues -file $yaml -ypath parent, child

Remove-Module PowerYaml