# LEADER Skill

`LEADER Skill` is a GitHub-ready orchestration skill for building a Windows-first control plane that can lead, route, and coordinate multiple AI agents.

It is designed for setups where one top-level agent should think like a technical lead:

- break work into clear subtasks
- assign roles across planner, builder, reviewer, and fallback lanes
- reduce token spend by preferring local paths when risk is low
- keep quick health probes cheap and deep probes trustworthy
- stay compatible with modern multi-agent stacks instead of locking into one framework

In short, `LEADER Skill` turns a general-purpose coding agent into a more disciplined multi-agent commander.

## What It Helps Build

With this skill, an agent can design or extend a leader-style orchestration system that:

- coordinates `OpenClaw`, `Hermes Agent`, `Claude Code`, `Codex`, `Ollama`, and similar platforms
- routes by capability, cost, speed, and permission model
- supports CLI-native agents, IDE bridge agents, and service-mesh agents
- keeps Windows runtime behavior quiet and stable
- prepares GitHub-ready manifests, routing policies, adapters, and validation flows

## Core Capabilities

- Worker manifest design
- Routing policy design
- Quick ping and deep ping strategy
- Local-vs-remote budget-aware delegation
- Failure handling and reroute policy
- Windows 10 / Windows 11 runtime guidance
- GitHub packaging for orchestration skills

## Transport Families

`LEADER Skill` already accounts for three major agent transport patterns:

- `agent_cli`
  for CLI-native agents such as OpenClaw, Hermes-over-OpenClaw, Claude Code, Codex, Aider, Goose, and similar tools
- `extension_bridge`
  for editor or IDE-extension-backed agents that need a bridge process
- `service_mesh`
  for HTTP, daemon, queue, or service-backed agent systems

## Repository Layout

```text
.
├─ .github/workflows/
├─ docs/
├─ examples/
├─ scripts/
├─ skill/
│  └─ leader-skill/
│     ├─ SKILL.md
│     ├─ agents/openai.yaml
│     ├─ assets/
│     ├─ references/
│     └─ scripts/
├─ .gitignore
├─ LICENSE
└─ README.md
```

## Install

### PowerShell install

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\install-skill.ps1
```

By default this installs to:

- `%CODEX_HOME%\skills\leader-skill`
- or `%USERPROFILE%\.codex\skills\leader-skill`

### Manual install

Copy:

`skill/leader-skill`

to:

`%CODEX_HOME%\skills\leader-skill`

or:

`%USERPROFILE%\.codex\skills\leader-skill`

## Validation

Validate the repository:

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\validate-repo.ps1
```

Run the smoke test:

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\run-e2e-smoke.ps1
```

Build a release package:

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\package-release.ps1 -Version v0.1.0
```

## Included Examples

This repository includes:

- worker examples for MVP-style orchestrators
- routing-policy examples
- starter manifests for:
  - external CLI agents
  - extension bridge agents
  - service mesh agents

## Practical Positioning

`LEADER Skill` is not just a prompt snippet. It is a structured orchestration kit:

- reusable templates
- compatibility guidance
- validation scripts
- Windows-focused runtime rules
- examples that can be adapted into a real product

It is a strong starting point for anyone trying to build a serious multi-agent leadership layer on top of existing tools instead of reinventing an agent stack from scratch.

## License

MIT

---

# LEADER Skill

`LEADER Skill` 是一个适合放到 GitHub 上直接发布的协调型 skill，用来帮助你构建“能统筹多个 AI Agent”的领导层控制平面。

它的设计目标不是让一个 agent 单独做完所有事，而是让一个顶层 agent 更像技术负责人：

- 先拆任务
- 再分配角色
- 再按成本、速度、权限和质量做路由
- 再回收结果并复核

一句话说，它是把“普通 coding agent”提升成“多 Agent 指挥官”的技能包。

## 它能帮助你做什么

借助这个 skill，可以设计或扩展一套 leader 型多 Agent 系统，它能够：

- 协调 `OpenClaw`、`Hermes Agent`、`Claude Code`、`Codex`、`Ollama` 等主流平台
- 按能力、成本、速度和权限模型做任务分工
- 同时兼容 CLI 型 agent、IDE bridge 型 agent、service mesh 型 agent
- 保持 Windows 下控制面安静、稳定、不乱弹终端
- 产出可直接上 GitHub 的 worker manifest、routing policy、adapter 和校验脚本

## 核心能力

- worker manifest 设计
- routing policy 设计
- quick ping / deep ping 探测策略
- 本地优先与远端优先的成本感知分工
- 失败回退与改派工策略
- Windows 10 / Windows 11 运行规范
- GitHub 可发布的 skill 打包结构

## 支持的三类 Agent 通道

`LEADER Skill` 现在已经考虑了 3 类主流 agent 架构：

- `agent_cli`
  适合 `OpenClaw`、`Hermes-over-OpenClaw`、`Claude Code`、`Codex`、`Aider`、`Goose` 这类 CLI agent
- `extension_bridge`
  适合依赖 IDE 或编辑器扩展桥接的 agent
- `service_mesh`
  适合通过 HTTP、daemon、queue 或服务形式暴露能力的 agent 系统

## 仓库结构

```text
.
├─ .github/workflows/
├─ docs/
├─ examples/
├─ scripts/
├─ skill/
│  └─ leader-skill/
│     ├─ SKILL.md
│     ├─ agents/openai.yaml
│     ├─ assets/
│     ├─ references/
│     └─ scripts/
├─ .gitignore
├─ LICENSE
└─ README.md
```

## 安装方式

### PowerShell 安装

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\install-skill.ps1
```

默认会安装到：

- `%CODEX_HOME%\skills\leader-skill`
- 或 `%USERPROFILE%\.codex\skills\leader-skill`

### 手动安装

把：

`skill/leader-skill`

复制到：

`%CODEX_HOME%\skills\leader-skill`

或：

`%USERPROFILE%\.codex\skills\leader-skill`

## 校验与打包

校验仓库：

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\validate-repo.ps1
```

运行冒烟测试：

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\run-e2e-smoke.ps1
```

打包发布：

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\package-release.ps1 -Version v0.1.0
```

## 附带内容

这个仓库已经包含：

- 适合 MVP 风格 orchestrator 的 worker 示例
- routing policy 示例
- 3 类 starter manifest：
  - external CLI agent
  - extension bridge agent
  - service mesh agent

## 实际定位

`LEADER Skill` 不是一段随手写的 prompt，而是一套相对完整的多 Agent 协调能力包：

- 有模板
- 有兼容说明
- 有校验脚本
- 有 Windows 运行规范
- 有可直接拿来改造的示例

如果你想做一个真正能统领多个 agent 平台的上层控制器，而不是重复从零拼装，这个 skill 会是一个很强的起点。

## License

MIT
