$pwd = Split-Path -Parent $MyInvocation.MyCommand.Path
$sut = (Split-Path -Leaf $MyInvocation.MyCommand.Path).Replace(".Tests", "")
. "$pwd\$sut"

Describe "when accessing a yaml scalar value of '5'" {
    $patched = Add-CastingFunctions("5")

    Context "and I do not attempt to cast it" {
        It "returns a string" {
            $patched.GetType().Name.should.be("string")
        }
    }

    Context "and I attempt to cast it as an integer" {
        It "returns a value that is of type integer" {
            $patched.ToInt().GetType().Name.should.be("Int32")
        }
    }

    Context "and I attempt to cast it as a long" {
        It "returns a value that is of type long" {
            $patched.ToLong().GetType().Name.should.be("Int64")
        }
    }

    Context "and I attempt to cast it as a double" {
        It "returns a value that is a double" {
            $patched.ToDouble().GetType().Name.should.be("Double")
        }
    }

    Context "and I attempt to cast it as a decimal" {
        It "returns a value that is a decimal" {
            $patched.ToDecimal().GetType().Name.should.be("Decimal")
        }
    }

    Context "and I attempt to cast it as a byte" {
        It "returns a value that is a byte" {
            $patched.ToByte().GetType().Name.should.be("Byte")
        }
    }
}

Describe "when accessing boolean values" {

    Context "and I'm attempting to cast the value 'true'" {
        $patched = Add-CastingFunctions("true")

        It "return a value that is a boolean" {
            $patched.ToBoolean().GetType().Name.should.be("Boolean")
        }

        It "returns a value that is true" {
            $patched.ToBoolean().should.be($true)
        }
    }

    Context "and I'm attempting to cast the value 'false'" {
        $patched = Add-CastingFunctions("false")

        It "return a value that is a boolean" {
            $patched.ToBoolean().GetType().Name.should.be("Boolean")
        }

        It "returns a value that is false" {
            $patched.ToBoolean().should.be($false)
        }
    }
}
