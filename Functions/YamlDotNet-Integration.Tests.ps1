$here = Split-Path -Parent $MyInvocation.MyCommand.Path
. "$here\Casting.ps1"
. "$here\Shadow-Copy.ps1"
. "$here\YamlDotNet-Integration.ps1"

$libDir = "$here\..\Libs"

Describe "Load-YamlDotNetLibraries" {

    It "loads assemblies in a way that the dll's can be deleted after loading" {
        Load-YamlDotNetLibraries $libDir
        $shadowDir = "$($env:Temp)\poweryaml\shadow"
        Remove-Item $shadowDir -Recurse
        (Test-Path $shadowDir).should.be($false)
    }

}

Describe "Convert-YamlScalarNodeToValue" {

    It "takes a YamlScalar and converts it to a value type" {

        Load-YamlDotNetLibraries $libDir
        $node = New-Object YamlDotNet.RepresentationModel.YamlScalarNode 5
        $result = Convert-YamlScalarNodeToValue $node

        $result.should.be(5)
    }
}

Describe "Convert-YamlSequenceNodeToList" {

    It "taks a YamlSequence and converts it to an array" {
        $yaml = Get-YamlDocumentFromString "---`n- single item`n- second item"

        $result = Convert-YamlSequenceNodeToList $yaml.RootNode 
        $result.count.should.be(2)
    }

}

Describe "Convert-YamlMappingNodeToHash" {

    It "takes a YamlMappingNode and converts it to a hash" {
        $yaml = Get-YamlDocumentFromString "---`nkey1:   value1`nkey2:   value2"

        $result = Convert-YamlMappingNodeToHash $yaml.RootNode
        $result.keys.count.should.be(2)
    }

}

Describe "Get-YamlDocumentFromString" {

    It "will return a YamlDocument if given proper YAML" {
        $document = Get-YamlDocumentFromString "---"
        $document.GetType().Name.should.be("YamlDocument")
    }

}
