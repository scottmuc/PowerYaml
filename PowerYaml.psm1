. $PSScriptRoot\Functions\YamlDotNet-Integration.ps1
. $PSScriptRoot\Functions\Validator-Functions.ps1
    
<# 
 .Synopsis
  Returns a name-value collection of a subset of a Yaml file

 .Description
  Single function that returns a hash of the name/value pairs that

 .Parameter file
  File reference to a yaml document

 .Parameter ypath
  A comma delimitted list of nodes to traverse
#>
function Get-YamlFromFile([string] $file = $(throw "-file is required"), $ypath = "")
{
    Validate-File $file
    
    $yaml = Get-YamlDocument -file $file
    $node = $yaml.RootNode

    Foreach($p in $ypath)
    {
        $node.Children.Keys |
            Where-Object { $_.Value -eq $p } | 
            % { $node = $node.Children[$_] }
    }

    return Convert-YamlMappingNodeToHash $node
}

function Get-YamlFromString([string] $yaml_string) 
{
    $yaml = Get-YamlDocumentFromString $yaml_string
    $nodes = $yaml.RootNode

    return Convert-YamlMappingNodeToHash $nodes
}

Load-YamlDotNetLibraries (Join-Path $PSScriptRoot -ChildPath "Libs")
Export-ModuleMember -Function Get-YamlFromFile, Get-YamlFromString 
