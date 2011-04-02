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
function Get-Yaml([string] $FromString = "", [string] $FromFile = "") 
{
    $yaml = $null

    if ($FromString -ne "")
    {
        # TODO add yaml string/document validation
        $yaml = Get-YamlDocumentFromString $FromString
    } 
    elseif ($FromFile -ne "")
    {
        if ((Validate-File $FromFile)) {
            $yaml = Get-YamlDocument -file $FromFile
        }
    }

    return Explode-Node $yaml.RootNode
}


Load-YamlDotNetLibraries (Join-Path $PSScriptRoot -ChildPath "Libs")
Export-ModuleMember -Function Get-Yaml 
