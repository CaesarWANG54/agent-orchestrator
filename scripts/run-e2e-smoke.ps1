[CmdletBinding()]
param(
    [string]$MvpWorkspace = "",
    [string]$MvpConfigPath = "",
    [switch]$ProbeInstalledTools,
    [switch]$LivePing
)

$ErrorActionPreference = "Stop"

$repoRoot = Split-Path -Parent $PSScriptRoot
$skillRoot = Join-Path $repoRoot "skill\leader-skill"
$workerValidator = Join-Path $skillRoot "scripts\validate_worker_manifest.py"
$routingValidator = Join-Path $skillRoot "scripts\validate_routing_policy.py"
$exampleManifest = Join-Path $repoRoot "examples\mvp-agent-workers.example.json"
$bridgeTemplate = Join-Path $skillRoot "assets\extension-bridge-agent.template.json"
$serviceTemplate = Join-Path $skillRoot "assets\service-mesh-agent.template.json"
$routingPolicy = Join-Path $repoRoot "examples\mvp-routing-policy.example.json"
$popularWorkers = Join-Path $skillRoot "assets\popular-agent-workers.example.json"

function Invoke-Step {
    param(
        [string]$Name,
        [scriptblock]$Action
    )
    Write-Host "==> $Name"
    & $Action
}

Invoke-Step "Repository validation" {
    powershell -ExecutionPolicy Bypass -File (Join-Path $PSScriptRoot "validate-repo.ps1")
    if ($LASTEXITCODE -ne 0) {
        throw "Repository validation failed."
    }
}

Invoke-Step "Example manifest validation" {
    python $workerValidator $exampleManifest
    if ($LASTEXITCODE -ne 0) {
        throw "Example manifest validation failed."
    }
}

Invoke-Step "Popular workers validation" {
    python $workerValidator $popularWorkers
    if ($LASTEXITCODE -ne 0) {
        throw "Popular workers validation failed."
    }
}

Invoke-Step "Extension bridge template validation" {
    python $workerValidator $bridgeTemplate
    if ($LASTEXITCODE -ne 0) {
        throw "Extension bridge template validation failed."
    }
}

Invoke-Step "Service mesh template validation" {
    python $workerValidator $serviceTemplate
    if ($LASTEXITCODE -ne 0) {
        throw "Service mesh template validation failed."
    }
}

Invoke-Step "Routing policy validation" {
    python $routingValidator $routingPolicy
    if ($LASTEXITCODE -ne 0) {
        throw "Routing policy validation failed."
    }
}

if ($ProbeInstalledTools) {
    $toolChecks = @(
        @{ Name = "openclaw"; Command = { openclaw --version } },
        @{ Name = "claude"; Command = { claude --version } },
        @{ Name = "codex"; Command = { codex --version } },
        @{ Name = "ollama"; Command = { ollama list } }
    )

    foreach ($tool in $toolChecks) {
        $cmd = Get-Command $tool.Name -ErrorAction SilentlyContinue
        if ($null -eq $cmd) {
            Write-Host "SKIP $($tool.Name): not installed"
            continue
        }
        Invoke-Step "Tool probe: $($tool.Name)" $tool.Command
        if ($LASTEXITCODE -ne 0) {
            throw "Tool probe failed: $($tool.Name)"
        }
    }
}

if ($LivePing) {
    if (-not $MvpWorkspace) {
        throw "LivePing requires -MvpWorkspace."
    }
    if (-not $MvpConfigPath) {
        $MvpConfigPath = Join-Path $MvpWorkspace "mvp.config.json"
    }
    if (-not (Test-Path $MvpWorkspace)) {
        throw "MVP workspace not found: $MvpWorkspace"
    }
    if (-not (Test-Path $MvpConfigPath)) {
        throw "MVP config not found: $MvpConfigPath"
    }
    Invoke-Step "MVP Agent quick ping" {
        Push-Location $MvpWorkspace
        try {
            python -m mvp --config $MvpConfigPath ping --mode quick
            if ($LASTEXITCODE -ne 0) {
                throw "MVP Agent quick ping failed."
            }
        } finally {
            Pop-Location
        }
    }
}

Write-Host "E2E smoke completed."
