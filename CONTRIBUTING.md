# Contributing to qed-plugins

Thank you for wanting to contribute a plugin! This guide explains how to add a new plugin to the qed-plugins marketplace.

## Prerequisites

- [Claude Code](https://docs.claude.com/en/docs/claude-code/overview) installed
- Familiarity with [Claude Code's plugin system](https://docs.claude.com/en/docs/claude-code/plugins)
- A GitHub account

## Adding a New Plugin

### 1. Fork and clone

```bash
git clone https://github.com/<your-username>/qed-plugins.git
cd qed-plugins
```

### 2. Create the plugin directory

```bash
mkdir -p plugins/<your-plugin-name>/.claude-plugin
```

Replace `<your-plugin-name>` with a lowercase, hyphen-separated name (e.g. `my-awesome-plugin`).

### 3. Create the plugin manifest

Create `plugins/<your-plugin-name>/.claude-plugin/plugin.json`:

```json
{
  "name": "your-plugin-name",
  "description": "A short description of what this plugin does (under 120 characters).",
  "version": "1.0.0",
  "author": {
    "name": "Your Name",
    "email": "you@example.com"
  }
}
```

**Required fields:** `name`, `description`, `version`, `author.name`

### 4. Add plugin content

Depending on what your plugin does, add one or more of the following:

#### Slash commands (`commands/`)

Create a Markdown file for each command. The filename (without `.md`) becomes the command name.

```
plugins/your-plugin-name/commands/my-command.md
```

Command files use front-matter to declare allowed tools:

```markdown
---
allowed-tools: Bash(git status:*), Read
description: A one-line description shown in the command picker
---

## Context

- Some context: !`some command`

## Your task

Describe what Claude should do when this command is invoked.
```

#### Hooks (`hooks/`)

Create `hooks/hooks.json` to register event hooks:

```json
{
  "description": "What this hook does",
  "hooks": {
    "PreToolUse": [
      {
        "matcher": "Edit|Write",
        "hooks": [
          {
            "type": "command",
            "command": "python3 ${CLAUDE_PLUGIN_ROOT}/hooks/my_hook.py"
          }
        ]
      }
    ]
  }
}
```

Supported hook events: `PreToolUse`, `PostToolUse`, `SessionStart`, `Stop`.

#### MCP servers (`.mcp.json`)

```json
{
  "mcpServers": {
    "my-server": {
      "command": "node",
      "args": ["${CLAUDE_PLUGIN_ROOT}/server/index.js"]
    }
  }
}
```

### 5. Add a README

Create `plugins/<your-plugin-name>/README.md` that documents:
- What the plugin does
- Each command or hook with usage examples
- Any requirements (external CLI tools, API keys, etc.)
- Installation instructions

### 6. Register in the marketplace

Add your plugin to `.claude-plugin/marketplace.json`:

```json
{
  "name": "your-plugin-name",
  "description": "Same description as in plugin.json",
  "version": "1.0.0",
  "author": {
    "name": "Your Name"
  },
  "source": "./plugins/your-plugin-name",
  "category": "productivity"
}
```

**Valid categories:** `productivity`, `development`, `learning`, `security`, `integration`

### 7. Open a pull request

Push your branch and open a PR against `main`. Please include:
- A description of what the plugin does
- Example output or a short demo (screenshot or code snippet)

## Plugin Guidelines

- **Focused**: Each plugin should do one thing well.
- **Safe**: Do not include commands that could cause data loss without user confirmation. Avoid shipping secret values.
- **Documented**: Every command and hook must be documented in the README.
- **Versioned**: Use [Semantic Versioning](https://semver.org/). Start at `1.0.0`.
- **Named**: Plugin names must be lowercase and hyphen-separated (e.g. `my-plugin`, not `MyPlugin` or `my_plugin`).

## Questions

Open an issue or start a discussion in the repository if you have questions.
