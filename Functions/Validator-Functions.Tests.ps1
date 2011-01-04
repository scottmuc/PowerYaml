$pwd = Split-Path -Parent $MyInvocation.MyCommand.Path
. "$pwd\Validator-Functions.ps1"
. "$pwd\..\Pester\Source\Pester.ps1"

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
