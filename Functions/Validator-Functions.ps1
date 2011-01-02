function Validate-File([string] $file)
{
    $file_exists = Test-Path $file
    if (-not $file_exists) 
    {
        Write-Host "Cannot parse a file that does not exist: $file" -fore red
        exit
    }
    
    gc $file | % { $file_contents += $_ }    
    if ($file_contents.Contains("`t")) 
    {
        Write-Host Cannot parse YAML text that contains TAB characters -fore red
        exit
    }
}

