# Claudinator

An opinionated Claude Code setup for Ruby on Rails software development.  


## Agents

The `agents` folder goes into `~/.claude/agents`

- **app-sentiment-researcher** - Analyzes user sentiment for applications by researching negative feedback across forums, review sites, and discussions to identify pain points and improvement opportunities
- **brainstormer** - Generates exhaustive ideation and research for app ideas, product concepts, or problem solutions with comprehensive lists of possibilities and features
- **domain-availability-checker** - Checks domain name availability for .com and .ai extensions using whois lookups for specific domain lists
- **domain-name-generator** - Generates creative domain name suggestions based on keywords or business descriptions using industry naming patterns
- **twitter-expert-finder** - Identifies and analyzes influential Twitter users within specific industries or topics, discovering prolific tweeters who shape conversations in their domain

## Commands

The `commands` folder goes into `~/.claude/commands`

### Ideation
- **ideator** - Provides comprehensive analysis for business ideas including variations, market sentiment, domains, and influencers
- **domain-search** - Two-stage domain discovery: generates 15-20 creative domain suggestions, then checks availability in parallel for efficient results

### Development Workflow
- **issue** - Creates well-structured GitHub issues from feature descriptions
- **work** - Analyzes GitHub issue, creates branch, plans implementation, then executes the work
- **pr** - Automates PR creation with code formatting and test verification
- **review** - Provides expert Ruby on Rails code review with line-specific feedback
- **resolve** - Addresses unresolved PR comments with fixes and automated cleanup
- **commit** - Creates git commits with context-aware messages based on current changes
- **reverse** - Rails-focused problem solving through Socratic questioning to avoid over-engineering

### Learning & Reflection
- **quiz** - Generates interactive quizzes to reinforce learning from coding sessions
- **reflect** - Captures and saves key learnings from completed tasks
- **lw** - Provide a summary of last weeks work appropriate for non-technical stakeholders
- **today** - Provide a summary of todays work appropriate for non-technical stakeholders

## MCP Servers

This repository includes Model Context Protocol (MCP) servers that extend Claude's capabilities:

### Included MCP Servers
- **Playwright** - Web automation and browser testing capabilities
- **Context7** - Documentation retrieval for libraries and frameworks
- **Whois** - Domain and IP information lookup

### Installation
Run the install script to set up all MCP servers:
```bash
./install.sh
```

The script is idempotent - it can be run multiple times safely and will skip already installed servers.

## Settings

Copy the `settings.json` file to `~/.claude/settings.json`
