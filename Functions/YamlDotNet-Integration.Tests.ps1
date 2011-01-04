$pwd = Split-Path -Parent $MyInvocation.MyCommand.Path
. "$pwd\YamlDotNet-Integration.ps1"
. "$pwd\..\Pester\Source\Pester.ps1"

Describe "Convert-YamlScalarNodeToValue" {

    It "takes a YamlScalar and converts it to a value type" {

        $node = New-Object YamlDotNet.RepresentationModel.YamlScalarNode 5
        $result = Convert-YamlScalarNodeToValue $node

        $result.should.be(5)
    }

}

Describe "Convert-YamlSequenceNodeToList" {

    It "taks a YamlSequence and converts it to an array" {
        $yaml = Get-YamlDocumentFromString "---
- single item
- second item"

        $result = Convert-YamlSequenceNodeToList $yaml.RootNode 
        $result.count.should.be(2)
    }

}

Describe "Get-YamlDocumentFromString" {
    
    It "will return a YamlDocument if given proper YAML" {
        $document = Get-YamlDocumentFromString "---"
        $document.GetType().Name.should.be("YamlDocument")
    }

}

