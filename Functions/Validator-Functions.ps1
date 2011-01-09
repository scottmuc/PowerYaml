function Validate-File([string] $file)
{
    $file_exists = Test-Path $file
    if (-not $file_exists) 
    {
        Write-Host "Cannot parse a file that does not exist: $file" -fore red
        return $false
    }
    
    gc $file | % { $file_contents += $_ }    
    if ((Detect-Tab $file_contents)) 
    {
        Write-Host Cannot parse YAML text that contains TAB characters -fore red
        return $false
    }

    return $true
}

function Detect-Tab([string] $yaml_string) 
{
    return $yaml_string.Contains("`t")
}

