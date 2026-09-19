$ErrorActionPreference = 'Stop'

$url = 'https://github.com/anjalikhatri019-hub/vortexlock-counterfactual-optics-dataset/releases/download/v1.3.0/VORTEXLOCK_public_dataset.zip'
$expectedBytes = 629881775
$expectedSha256 = '91a87c725839b1d9346ed8c8079dd8dcad81dd1065ea2ec7e03be13eaca0754f'
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
