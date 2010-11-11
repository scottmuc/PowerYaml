$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path

function Load-YamlDotNetLibraries([string] $dllPath)
{
	gci $dllPath | % { [Reflection.Assembly]::LoadFrom($_.FullName) }
}

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

function Validate-File([string] $file)
{
    $file_exists = Test-Path $file
    if (-not $file_exists) 
    {
        Write-Host "Cannot parse a file that does not exist: $file" -fore red
        exit
    }
    
    gc $file | % { $file_contents += $_ }    
    if ($file_contents.Contains("`t")) 
    {
        Write-Host Cannot parse YAML text that contains TAB characters -fore red
        exit
    }
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
    Validate-File $file
    
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

Load-YamlDotNetLibraries (Join-Path $scriptDir -ChildPath "Libs")
Export-ModuleMember -Function Get-YamlNameValues