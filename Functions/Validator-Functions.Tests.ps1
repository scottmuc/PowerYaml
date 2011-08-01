$pwd = Split-Path -Parent $MyInvocation.MyCommand.Path
$sut = (Split-Path -Leaf $MyInvocation.MyCommand.Path).Replace(".Tests", "")
. "$pwd\$sut"

Describe "Detect-Tab" {

    It "should return the line number the first TAB character is found on" {
        $lines = @()
        $lines += "   `t    "

        $result = Detect-Tab $lines
        $result.should.be(1)
    }

    It "should return 0 if no TAB character is found in text" {
        $result = Detect-Tab "          "
        $result.should.be(0)
    }
}

Describe "Validate-File" {

    Setup -File "exists.yml"

    It "should return false if a file does not exist" {
        $result = Validate-File "some non existent file"
        $result.should.be($false)
    }

    It "should return true for a file that does exist and does not contain a TAB character" {
        $result = Validate-File "$TestDrive\exists.yml" 
        $result.should.be($true)
    }
}

Describe "Validating a file with tabs" {
    
    Setup -File "bad.yml" "     `t   "

    It "should return false and display what line the TAB occured on" {
        $result = Validate-File "$TestDrive\bad.yml"
        $result.should.be($false)
    }
}
