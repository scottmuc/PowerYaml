. $PSScriptRoot\Functions\YamlDotNet-Integration.ps1
. $PSScriptRoot\Functions\Validator-Functions.ps1
    
<# 
 .Synopsis
  Returns an object that can be dot navigated

 .Parameter YamlFile
  File reference to a yaml document

 .Parameter YamlString
  Yaml string to be converted

 .Parameter ypath
  A comma delimitted list of nodes to traverse
#>
function Get-Yaml([string] $YamlString = "", [string] $YamlFile = "", $ypath = "") 
{
    $yaml = $null

    if ($YamlString -ne "")
    {
        $yaml = Get-YamlDocumentFromString $YamlString
    } 
    elseif ($YamlFile -ne "")
    {
        Validate-File $YamlFile
        $yaml = Get-YamlDocument -file $YamlFile
    }

    $nodes = $yaml.RootNode
    Foreach($p in $ypath)
    {
        $nodes.Children.Keys |
            Where-Object { $_.Value -eq $p } | 
            % { $nodes = $nodes.Children[$_] }
    }

    return Explode-Node $nodes
}


Load-YamlDotNetLibraries (Join-Path $PSScriptRoot -ChildPath "Libs")
Export-ModuleMember -Function Get-Yaml 
