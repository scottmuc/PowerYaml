Import-Module .\PowerYaml.psm1
. ..\Pester\Pester.ps1

Describe "PowerYaml API (Get-Yaml)" {

    It "Obtains a HashTable given a yaml hash" {
        $yaml = Get-Yaml -YamlString "key: value"
        $yaml.GetType().Name.should.be("HashTable")
    }

    It "Obtains an Object[] given a yaml array" {
        $yaml = Get-Yaml -YamlString "- test
- test2"
        $yaml.GetType().Name.should.be("Object[]")
    }

    It "Can parse a yaml file without specifying a ypath" {
        $yaml_file = Resolve-Path Examples\sample.yml
        $yaml = Get-Yaml -YamlFile $yaml_file
        $yaml.keys.count.should.be(1)
    }

    It "Can parse a yaml file and navigate to a subsection" {
        $yaml_file = Resolve-Path Examples\sample.yml
        $yaml = Get-Yaml -YamlFile $yaml_file -ypath parent, child
        $yaml.keys.count.should.be(3)  
    }

}

Remove-Module PowerYaml
