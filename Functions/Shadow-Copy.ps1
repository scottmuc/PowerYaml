function Shadow-Copy($file, $shadowPath = "$($env:TEMP)\poweryaml\shadow") {

    if (-not (Test-Path $shadowPath ) ) {
        New-Item $shadowPath -ItemType directory | Out-Null
    }

    Copy-Item $file $shadowPath

    $fileName = (Get-Item $file).Name
    "$shadowPath\$fileName"
}
