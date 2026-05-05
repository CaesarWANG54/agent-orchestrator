[CmdletBinding()]
param(
    [string]$CodexHome = "",
    [switch]$Force
)

$ErrorActionPreference = "Stop"

$repoRoot = Split-Path -Parent $PSScriptRoot
$skillSource = Join-Path $repoRoot "skill\leader-skill"

if (-not (Test-Path $skillSource)) {
    throw "Skill source not found: $skillSource"
}

if (-not $CodexHome) {
    if ($env:CODEX_HOME) {
        $CodexHome = $env:CODEX_HOME
    } else {
        $CodexHome = Join-Path $HOME ".codex"
    }
}

$targetRoot = Join-Path $CodexHome "skills"
$targetSkill = Join-Path $targetRoot "leader-skill"

New-Item -ItemType Directory -Path $targetRoot -Force | Out-Null

if (Test-Path $targetSkill) {
    if (-not $Force) {
        throw "Target already exists: $targetSkill . Re-run with -Force to replace it."
    }
    Remove-Item -Recurse -Force $targetSkill
}

Copy-Item -Recurse -Force $skillSource $targetSkill

Write-Host "Installed skill to: $targetSkill"
