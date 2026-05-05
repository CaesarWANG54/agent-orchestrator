[CmdletBinding()]
param(
    [string]$Version = "dev"
)

$ErrorActionPreference = "Stop"

$repoRoot = Split-Path -Parent $PSScriptRoot
$skillRoot = Join-Path $repoRoot "skill\leader-skill"
$distRoot = Join-Path $repoRoot "dist"
$stageRoot = Join-Path $distRoot "stage"
$packageRoot = Join-Path $stageRoot "leader-skill"
$zipPath = Join-Path $distRoot ("leader-skill-{0}.zip" -f $Version)
$hashPath = "$zipPath.sha256"
$manifestPath = Join-Path $distRoot "release-manifest.json"

if (Test-Path $distRoot) {
    Remove-Item -Recurse -Force $distRoot
}

New-Item -ItemType Directory -Path $packageRoot -Force | Out-Null

powershell -ExecutionPolicy Bypass -File (Join-Path $PSScriptRoot "validate-repo.ps1")

Copy-Item -Recurse -Force (Join-Path $skillRoot "*") $packageRoot

Get-ChildItem -Recurse -Directory $packageRoot | Where-Object { $_.Name -eq "__pycache__" } | ForEach-Object {
    Remove-Item -Recurse -Force $_.FullName
}

Compress-Archive -Path $packageRoot -DestinationPath $zipPath -CompressionLevel Optimal

$hash = (Get-FileHash -Path $zipPath -Algorithm SHA256).Hash.ToLowerInvariant()
Set-Content -Path $hashPath -Value ("{0}  {1}" -f $hash, (Split-Path -Leaf $zipPath)) -Encoding UTF8

$manifest = [ordered]@{
    package = "leader-skill"
    version = $Version
    artifact = (Split-Path -Leaf $zipPath)
    sha256 = $hash
    generated_at = (Get-Date).ToString("o")
}

$manifest | ConvertTo-Json -Depth 5 | Set-Content -Path $manifestPath -Encoding UTF8

Write-Host "Release package created:"
Write-Host "  $zipPath"
Write-Host "  $hashPath"
Write-Host "  $manifestPath"
