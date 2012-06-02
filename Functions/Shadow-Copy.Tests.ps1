$here = Split-Path -Parent $MyInvocation.MyCommand.Path
$sut = (Split-Path -Leaf $MyInvocation.MyCommand.Path).Replace(".Tests.", ".")
. "$here\$sut"

Describe "Shadow-Copy" {

    Setup -File "testfile"
    $isolatedShadowPath = "$TestDrive\poweryaml\shadow"

    It "copies a file to a transient location" {
        Shadow-Copy -File "$TestDrive\testfile" -ShadowPath $isolatedShadowPath
        (Test-Path "$isolatedShadowPath\testfile").should.be($true)
    }

    It "returns a path to the shadow copied file" {
        $shadow = Shadow-Copy -File "$TestDrive\testfile" -ShadowPath $isolatedShadowPath
        $shadow.should.be("$isolatedShadowPath\testfile")
    }

    It "does not complain if trying to overwrite locked files" {
        $file = [System.io.File]::Open("$isolatedShadowPath\testfile", 'Open', 'Read', 'None')
        $shadow = Shadow-Copy -File "$TestDrive\testfile" -ShadowPath $isolatedShadowPath
        $file.Close()
        "made it here, therefore no errors".should.be("made it here, therefore no errors")
    }
}
