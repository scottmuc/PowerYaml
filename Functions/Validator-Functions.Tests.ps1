$pwd = Split-Path -Parent $MyInvocation.MyCommand.Path
. "$pwd\Validator-Functions.ps1"
. "$pwd\..\Pester\Pester.ps1"

Describe "Detect-Tab" {

    It "should return true if a TAB character is found in text" {
        $result = Detect-Tab "   `t     "
        $result.should.be($true)
    }

    It "should return false if no TAB character is found in text" {
        $result = Detect-Tab "          "
        $result.should.be($false)
    }

}

Describe "Validate-File" {

    It "should return false if a file does not exist" {
        $result = Validate-File "some non existent file"
        $result.should.be($false)
    }

    It "should return true for a file that does exist and does not contain a TAB character" {
        $result = Validate-File (Resolve-Path Examples\sample.yml)
        $result.should.be($true)
    }

}
