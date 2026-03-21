# qed-plugins — Plugin Directory

This directory contains all Claude Code plugins available through the qed-plugins marketplace.

## Available Plugins

| Name | Description | Commands |
|------|-------------|----------|
| [git-workflow](./git-workflow/) | Automate common git operations | `/commit`, `/commit-push-pr`, `/clean-gone` |
| [test-runner](./test-runner/) | Run tests and summarize failures | `/run-tests`, `/run-affected-tests` |

## Plugin Structure

Each plugin follows the standard Claude Code plugin layout:

```
plugin-name/
├── .claude-plugin/
│   └── plugin.json       # Plugin metadata (name, version, author)
├── commands/             # Slash commands — one Markdown file per command (optional)
├── agents/               # Specialised sub-agents (optional)
├── skills/               # Agent skills (optional)
├── hooks/                # Event hooks (optional)
├── .mcp.json             # MCP server configuration (optional)
└── README.md             # Plugin documentation
```

## Adding a Plugin

See [CONTRIBUTING.md](../CONTRIBUTING.md) for full guidelines. The short version:

1. Create `plugins/<your-plugin-name>/` following the structure above.
2. Add `.claude-plugin/plugin.json` with `name`, `version`, `description`, and `author`.
3. Register the plugin in `../.claude-plugin/marketplace.json`.
4. Open a pull request — the CI validation workflow will check your manifest.

## Learn More

- [Claude Code Plugin Documentation](https://docs.claude.com/en/docs/claude-code/plugins)
- [Plugin System Overview](https://docs.claude.com/en/docs/claude-code/overview)
