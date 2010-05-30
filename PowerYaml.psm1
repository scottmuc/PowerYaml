$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path

$dllImports = @(
	"Libs\YamlDotNet.Core.dll",
	"Libs\YamlDotNet.Configuration.dll", 
	"Libs\YamlDotNet.Converters.dll",
	"Libs\YamlDotNet.RepresentationModel.dll"
)

$dllImports | 
	% { Join-Path -path $scriptDir -ChildPath $_ } |
	% { [Reflection.Assembly]::LoadFrom($_) }

function Get-YamlStream([string] $file)
{
	$streamReader = [System.IO.File]::OpenText($file)
	$yamlStream = New-Object YamlDotNet.RepresentationModel.YamlStream
	
	$yamlStream.Load([System.IO.TextReader] $streamReader)
	$streamReader.Close()
    return $yamlStream	
}

function Get-YamlDocument([string] $file)
{
    $yamlStream = Get-YamlStream $file
	$document = $yamlStream.Documents[0]
    return $document
}

function Convert-YamlMappingNodeToHash($node)
{
    $hash = @{}
    
    foreach($key in $node.Keys)
    {
        $keyName = $key.Value
        $hash.$keyName = $node[$key].Value
    }
    
    return $hash
}

<# 
 .Synopsis
  Returns a name-value collection of a subset of a Yaml file

 .Description
  Single function that returns a hash of the name/value pairs that

 .Parameter file
  File reference to a yaml document

 .Parameter ypath
  A command delimitted list of nodes to traverse
#>
function Get-YamlNameValues([string] $file = $(throw "-file is required"), $ypath)
{
    $yaml = Get-YamlDocument -file $file
    $nodes = $yaml.RootNode.Children
 
    Foreach($p in $ypath)
    {
        $nodes.Keys |
            Where-Object { $_.Value -eq $p } | 
            % { $nodes = $nodes[$_].Children }    
    }
	
    return Convert-YamlMappingNodeToHash $nodes
}

Export-ModuleMember -Function Get-YamlNameValues