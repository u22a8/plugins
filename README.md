# qed-plugins

A community marketplace of [Claude Code](https://docs.claude.com/en/docs/claude-code/overview) plugins for productivity, development workflows, and code quality.

## What is this?

`qed-plugins` is a plugin marketplace that extends [Claude Code](https://docs.claude.com/en/docs/claude-code/overview) — Anthropic's AI coding CLI — with additional slash commands, hooks, agents, and MCP server integrations. Browse the available plugins below, or [contribute your own](#contributing).

## Available Plugins

| Plugin | Description | Commands |
|--------|-------------|----------|
| [git-workflow](./plugins/git-workflow/) | Automate committing, pushing, and pull request creation | `/commit`, `/commit-push-pr`, `/clean-gone` |
| [test-runner](./plugins/test-runner/) | Run tests and surface actionable failure details | `/run-tests`, `/run-affected-tests` |

## Installation

### Install the marketplace

Point Claude Code at this marketplace so you can install plugins by name:

```bash
# In your Claude Code session
/marketplace add https://github.com/onebit0fme/qed-plugins
```

### Install a specific plugin

```bash
/plugin install https://github.com/onebit0fme/qed-plugins --name git-workflow
```

### Manual installation (`.claude/settings.json`)

```json
{
  "plugins": [
    {
      "source": "https://github.com/onebit0fme/qed-plugins",
      "name": "git-workflow"
    }
  ]
}
```

After installation, the plugin's slash commands are available immediately in your Claude Code session.

## Contributing

Contributions are welcome! See [CONTRIBUTING.md](./CONTRIBUTING.md) for full guidelines.

The short version:
1. Fork the repository.
2. Create `plugins/<your-plugin-name>/` with a `.claude-plugin/plugin.json` manifest and your commands/hooks.
3. Register the plugin in `.claude-plugin/marketplace.json`.
4. Open a pull request.

## Repository Structure

```
qed-plugins/
├── .claude-plugin/
│   └── marketplace.json    # Marketplace manifest — lists all available plugins
├── plugins/
│   ├── git-workflow/       # Git workflow automation plugin
│   └── test-runner/        # Test runner plugin
├── CONTRIBUTING.md
└── README.md
```

## License

[Apache License 2.0](./LICENSE)