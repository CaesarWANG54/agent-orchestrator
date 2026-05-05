# Release Checklist

Use this before pushing a tagged public release.

## Required

- Run `powershell -ExecutionPolicy Bypass -File .\scripts\validate-repo.ps1`
- Run `powershell -ExecutionPolicy Bypass -File .\scripts\package-release.ps1 -Version <version>`
- Run `powershell -ExecutionPolicy Bypass -File .\scripts\run-e2e-smoke.ps1`
- Confirm `examples/mvp-agent-workers.example.json` still matches the documented adapter model
- Confirm `examples/mvp-routing-policy.example.json` still matches the documented planner, builder, reviewer, fallback, and budget-routing model
- Confirm no secrets exist in examples, logs, or screenshots

## Recommended

- Run `powershell -ExecutionPolicy Bypass -File .\scripts\run-e2e-smoke.ps1 -ProbeInstalledTools`
- If an actual `MVP Agent` workspace is available, run:
  - `powershell -ExecutionPolicy Bypass -File .\scripts\run-e2e-smoke.ps1 -ProbeInstalledTools -LivePing -MvpWorkspace <path> -MvpConfigPath <path-to-mvp.config.json>`
- Capture or refresh repository screenshots listed in `docs/SCREENSHOTS.md`
- Check that release artifacts exist in `dist/`
