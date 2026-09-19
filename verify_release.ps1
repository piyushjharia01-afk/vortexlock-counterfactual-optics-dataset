$ErrorActionPreference = 'Stop'

$url = 'https://github.com/anjalikhatri019-hub/vortexlock-counterfactual-optics-dataset/releases/download/v1.2.0/VORTEXLOCK_public_dataset.zip'
$expectedBytes = 629488570
$expectedSha256 = '2ce91621da624a43934f9d3ba55b648242c3d49a8640c53b26337fa55556eeeb'
$destination = Join-Path $PSScriptRoot 'anonymous_download_VORTEXLOCK_public_dataset.zip'

Invoke-WebRequest -Uri $url -OutFile $destination
$actualBytes = (Get-Item -LiteralPath $destination).Length
$actualSha256 = (Get-FileHash -Algorithm SHA256 -LiteralPath $destination).Hash.ToLowerInvariant()

if ($actualBytes -ne $expectedBytes) {
    throw "Size mismatch: expected $expectedBytes, got $actualBytes"
}
if ($actualSha256 -ne $expectedSha256) {
    throw "SHA-256 mismatch: expected $expectedSha256, got $actualSha256"
}

Write-Output "PASS: anonymous release download matches the canonical public dataset."
