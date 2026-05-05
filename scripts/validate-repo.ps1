[CmdletBinding()]
param()

$ErrorActionPreference = "Stop"

$repoRoot = Split-Path -Parent $PSScriptRoot
$skillRoot = Join-Path $repoRoot "skill\leader-skill"
$skillMd = Join-Path $skillRoot "SKILL.md"
$workerTemplate = Join-Path $skillRoot "assets\external-cli-agent.template.json"
$bridgeTemplate = Join-Path $skillRoot "assets\extension-bridge-agent.template.json"
$serviceTemplate = Join-Path $skillRoot "assets\service-mesh-agent.template.json"
$routingTemplate = Join-Path $skillRoot "assets\routing-policy.template.json"
$popularWorkers = Join-Path $skillRoot "assets\popular-agent-workers.example.json"
$validator = Join-Path $skillRoot "scripts\validate_worker_manifest.py"
$routingValidator = Join-Path $skillRoot "scripts\validate_routing_policy.py"

function Assert-Exists {
    param([string]$PathValue, [string]$Label)
    if (-not (Test-Path $PathValue)) {
        throw "$Label not found: $PathValue"
    }
}

Assert-Exists $skillRoot "Skill root"
Assert-Exists $skillMd "SKILL.md"
Assert-Exists (Join-Path $skillRoot "agents\openai.yaml") "openai.yaml"
Assert-Exists (Join-Path $skillRoot "references\framework-compatibility.md") "framework compatibility reference"
Assert-Exists (Join-Path $skillRoot "references\windows-runtime.md") "windows runtime reference"
Assert-Exists $workerTemplate "worker template"
Assert-Exists $bridgeTemplate "extension bridge template"
Assert-Exists $serviceTemplate "service mesh template"
Assert-Exists $routingTemplate "routing policy template"
Assert-Exists $popularWorkers "popular workers example"
Assert-Exists $validator "worker validator"
Assert-Exists $routingValidator "routing policy validator"
Assert-Exists (Join-Path $repoRoot ".github\workflows\validate.yml") "validate workflow"
Assert-Exists (Join-Path $repoRoot ".github\workflows\release.yml") "release workflow"
Assert-Exists (Join-Path $repoRoot "scripts\install-skill.ps1") "install script"
Assert-Exists (Join-Path $repoRoot "scripts\package-release.ps1") "package script"
Assert-Exists (Join-Path $repoRoot "scripts\run-e2e-smoke.ps1") "e2e smoke script"
Assert-Exists (Join-Path $repoRoot "docs\SCREENSHOTS.md") "screenshots page"
Assert-Exists (Join-Path $repoRoot "docs\RELEASE_CHECKLIST.md") "release checklist"
Assert-Exists (Join-Path $repoRoot "examples\mvp-agent-workers.example.json") "MVP worker example"
Assert-Exists (Join-Path $repoRoot "examples\mvp-routing-policy.example.json") "routing policy example"

$content = Get-Content -Raw -Encoding UTF8 $skillMd
if (-not $content.StartsWith("---`n")) {
    throw "SKILL.md is missing YAML frontmatter."
}
if ($content -notmatch "(?m)^name:\s+leader-skill\s*$") {
    throw "SKILL.md frontmatter name is missing or invalid."
}
if ($content -notmatch "(?m)^description:\s+") {
    throw "SKILL.md frontmatter description is missing."
}

python $validator $workerTemplate
if ($LASTEXITCODE -ne 0) {
    throw "Worker manifest validation failed."
}

python $validator $bridgeTemplate
if ($LASTEXITCODE -ne 0) {
    throw "Extension bridge template validation failed."
}

python $validator $serviceTemplate
if ($LASTEXITCODE -ne 0) {
    throw "Service mesh template validation failed."
}

python $validator $popularWorkers
if ($LASTEXITCODE -ne 0) {
    throw "Popular worker example validation failed."
}

python $routingValidator $routingTemplate
if ($LASTEXITCODE -ne 0) {
    throw "Routing policy validation failed."
}

python -m compileall (Join-Path $skillRoot "scripts")
if ($LASTEXITCODE -ne 0) {
    throw "Python script compilation failed."
}

Get-ChildItem -Recurse -Directory $skillRoot | Where-Object { $_.Name -eq "__pycache__" } | ForEach-Object {
    Remove-Item -Recurse -Force $_.FullName
}

Write-Host "Repository validation passed."
