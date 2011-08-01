Import-Module .\PowerYaml.psm1

Describe "PoweYaml when parsing strings" {

    It "Obtains a HashTable given a yaml hash" {
        $yaml = Get-Yaml -FromString "key: value"
        $yaml.GetType().Name.should.be("HashTable")
    }

    It "Obtains an Object[] given a yaml array" {
        $yaml = Get-Yaml -FromString "- test`n- test2"
        $yaml.GetType().Name.should.be("Object[]")
    }
}

Describe "Using Power Yaml to read a file" {
    Setup -File "sample.yml" "test: value"

    It "Can read the file and get the value" {
        $yaml = Get-Yaml -FromFile "$TestDrive\sample.yml"
        $yaml.test.should.be("value")
    }
}

Remove-Module PowerYaml
