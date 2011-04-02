function Validate-File([string] $file)
{
    $file_exists = Test-Path $file
    if (-not $file_exists) 
    {
        Write-Host "Cannot parse a file that does not exist: $file"
        return $false
    }

    $lines_in_file = [System.IO.File]::ReadAllLines($file)
    $line_tab_detected = Detect-Tab $lines_in_file

    if ($line_tab_detected -gt 0) 
    {
        Write-Host TAB detected on line $line_tab_detected there cannot parse YAML
        return $false
    }

    return $true
}

function Detect-Tab($lines) 
{
    for($i = 0; $i -lt $lines.count; $i++) {
        if ($lines[$i].Contains("`t")) {
            return ($i + 1) 
        }
    }

    return 0
}

