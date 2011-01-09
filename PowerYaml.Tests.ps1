Import-Module .\PowerYaml.psm1
. ..\Pester\Source\Pester.ps1

Describe "PowerYaml" {

    It "Can parse a yaml string containing a hash" {
        $yaml = Get-Yaml -YamlString "key: value"
        $yaml.keys.count.should.be(1)
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
