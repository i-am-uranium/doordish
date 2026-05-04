# Doordish

Doordish is an open-source, trust-first ordering assistant for everyday food decisions.

The project is being revived from an old Flutter web proof of concept into a daily-use product backed by an LLM and, eventually, Swiggy MCP. The current MVP runs in mock mode so contributors can build and test the user experience without production Swiggy access.

## What It Does Today

- Turns a natural language goal into practical food recommendations.
- Ranks options by total estimated cost, ETA, rating, and trust signals.
- Builds a draft cart without placing an order.
- Requires explicit confirmation before marking an order as placed.
- Keeps an activity trail for LLM/MCP-style actions.
- Generates support-ready context for order issues.

Example prompts:

- `Find dinner under Rs 300 total, high protein, delivery under 30 minutes.`
- `I have a meeting in 40 minutes. Find something reliable and quick.`
- `Build a vegetarian lunch cart for two people under Rs 500.`

## Why This Exists

Food delivery users often struggle with hidden final costs, confusing discounts, late deliveries, missing items, and weak support flows. Doordish focuses on trust before checkout: show the real cart, explain tradeoffs, and keep useful context when something goes wrong.

## Current Architecture

- `lib/main.dart` starts the new Flutter app shell.
- `lib/features/agent/assistant_workspace.dart` contains the assistant-first UI.
- `lib/features/agent/ordering_agent.dart` defines the agent boundary.
- `lib/features/agent/mock_ordering_agent.dart` provides deterministic mock LLM/MCP behavior.

The Flutter client does not own real LLM keys or Swiggy OAuth tokens. Those belong in a backend service when the real MCP integration is added.

## Local Development

Install Flutter, then run:

```bash
flutter pub get
flutter test
flutter run -d chrome
```

For a web-server target:

```bash
flutter run -d web-server --web-hostname 127.0.0.1 --web-port 8080
```

## Roadmap

- Add a backend service for LLM orchestration and Swiggy MCP.
- Implement OAuth and token storage on the backend.
- Replace mock recommendations with live Swiggy Food MCP calls.
- Add Instamart and Dineout after the Food flow is safe and useful.
- Add persisted user preferences and order issue history.
- Keep checkout guarded by explicit user confirmation.

## Design Notes

See:

- `docs/superpowers/specs/2026-05-04-doordish-mcp-agent-design.md`
- `docs/superpowers/plans/2026-05-04-doordish-trust-agent-mvp.md`
