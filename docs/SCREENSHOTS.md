# Screenshot Guide

This page is the screenshot gallery and capture plan for the GitHub repository.

It is intentionally structured so the repository can ship now and accept better visuals later without changing the page layout.

## Recommended Gallery

### 1. Main Workbench

Show the leader-style control plane with:

- left status rail
- right chat or orchestration pane
- current worker roles
- current routing mode

Suggested filename:

`docs/screenshots/main-workbench.png`

### 2. Quick Ping / Deep Ping Status

Show:

- fast local quick checks
- multi-agent framework status
- model or agent targets

Suggested filename:

`docs/screenshots/ping-status.png`

### 3. Task Routing and Delegation

Show:

- planner selection
- subtask assignment
- builder and reviewer lanes
- local fallback behavior

Suggested filename:

`docs/screenshots/task-routing.png`

### 4. Worker Contract Example

Show:

- external CLI worker config
- platform metadata
- mode family

Suggested filename:

`docs/screenshots/worker-contract.png`

## Release-Ready Captions

Use captions like:

- `Leader-style orchestration across multiple agent platforms on Windows 10/11.`
- `Low-latency quick ping path with local-state probing and cached control-plane checks.`
- `Cost-aware routing that keeps repetitive work local and escalates only when quality or write access requires it.`
- `Config-driven adapter model for OpenClaw, Hermes, Claude Code, Codex, Ollama, and future CLI-based agents.`

## Capture Checklist

- Use a clean light theme if possible.
- Hide unrelated desktop clutter.
- Make sure no secrets or tokens appear in terminal, config, or logs.
- Prefer screenshots with one clear focus each instead of overloaded dashboards.
- Use PNG.

## Placeholder Note

If screenshots are not yet captured, keep this page and add images later using:

```markdown
![Main workbench](./screenshots/main-workbench.png)
```

