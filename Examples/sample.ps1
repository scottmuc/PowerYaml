$yaml = Resolve-Path sample.yml 
Import-Module ..\PowerYaml.psm1 

Get-YamlFromFile -file $yaml -ypath parent, child

Remove-Module PowerYaml
