# Doordish MCP Agent Design

Date: 2026-05-04
Status: Draft for user review

## Product Direction

Doordish will be revived as an open-source, daily-use food and errands assistant backed by an LLM and Swiggy MCP. It is no longer a Flutter web proof of concept. The product goal is to help users make better ordering decisions, understand total cost, reduce ordering mistakes, and keep a reliable trail when something goes wrong.

The first release should focus on a trust-first ordering assistant. Swiggy MCP is the commerce execution layer, while Doordish owns the user experience, reasoning, guardrails, and open-source extensibility.

## Research Signals

The strongest user pain points are trust and decision load, not basic restaurant discovery.

- Pricing is confusing. Recent food delivery surveys report that many Indian users notice higher online prices than restaurant prices, and about three in four users complain about higher menu prices, taxes, platform charges, or both.
- Quality and support issues are frequent. Reported complaints include damaged or spilled food, stale food, missing items, wrong orders, and denied refunds.
- Users need outcome-based help: fast lunch, dinner under a total budget, healthy meals, groceries for meal prep, or party shopping.
- MCP setup is still developer-shaped. Normal users should not need to understand manifests, OAuth redirects, JSON config files, or client-specific setup.

Sources:

- Swiggy MCP overview: https://mcp.swiggy.com/builders/docs/start/what-is-swiggy-mcp/
- Swiggy MCP manifest: https://github.com/Swiggy/swiggy-mcp-server-manifest
- Swiggy MCP production guidance: https://mcp.swiggy.com/builders/docs/build/ship-to-production/
- Business Standard coverage of LocalCircles food app pricing survey: https://www.business-standard.com/industry/news/55-consumers-food-apps-charge-more-restaurants-localcircles-survey-126010600752_1.html
- MCP authorization specification: https://modelcontextprotocol.io/specification/2025-06-18/basic/authorization

## MVP

The MVP is a trust-first ordering agent for Swiggy Food.

Primary user promise:

> "Tell Doordish what you need, and it will find practical options, explain the tradeoffs, show the true cart before checkout, and never place an order without your explicit confirmation."

Example prompts:

- "Find dinner under Rs 300 total, high protein, delivery under 30 minutes."
- "I have a meeting in 40 minutes. Find something reliable and quick near home."
- "Build a vegetarian lunch cart for two people under Rs 500."
- "Track my order and keep details ready if something is missing."

## User Experience

The first screen should be the assistant workspace, not a landing page. The app should feel like a practical command center for repeated use.

Core areas:

- Assistant thread: natural language input, LLM responses, and structured recommendation cards.
- Plan panel: current goal, budget, address, dietary constraints, and delivery urgency.
- Results panel: restaurant or item options ranked by fit, total cost, delivery time, rating, and risk notes.
- Cart confirmation: itemized cart, fees, discounts, final payable amount, address, and payment mode before any order action.
- Activity trail: tool calls, order status, issue notes, and support-ready details such as timestamps and session IDs where available.

The app should preserve the old Doordish brand warmth but reduce decorative food-dashboard clutter. This is now a utility product.

## Functional Scope

MVP includes:

- Connect to Swiggy Food MCP through the backend.
- Let users set default city/address context after authentication.
- Convert user intent into safe MCP tool calls through an LLM orchestrator.
- Search restaurants and menus by budget, time, cuisine, dietary preference, and rating.
- Compare options using estimated total cost, not just menu price.
- Build a cart and require explicit user confirmation before checkout/order placement.
- Track order status after placement.
- Record enough context to help the user report missing, wrong, delayed, or damaged orders.

MVP excludes:

- Instamart grocery automation.
- Dineout booking.
- Automatic order placement without confirmation.
- Multi-user team ordering.
- Price comparison against restaurant dine-in menus unless Swiggy MCP exposes reliable source data.
- Refund automation beyond preparing evidence and guidance.

## Architecture

Doordish should use a Flutter frontend with a backend service. The Flutter app should not call Swiggy MCP or LLM APIs directly because OAuth tokens, model keys, logs, rate limiting, and tool-call guardrails belong on the server.

Components:

- Flutter client: assistant UI, cart confirmation UI, user preferences, and local session state.
- Backend API: authenticated user sessions, LLM orchestration, MCP client, policy guardrails, and audit trail.
- LLM orchestrator: translates user goals into plans and tool calls, summarizes tradeoffs, and asks for confirmation.
- MCP gateway/client: connects to Swiggy Food MCP over HTTP, handles OAuth, retries, session IDs, and tool errors.
- Persistence: stores user preferences, active order context, tool-call audit events, and issue notes.

Initial backend can be a small Node.js or Dart server. Node.js is the safer default because MCP and LLM SDK examples are more mature there, while the Flutter app remains the open-source client.

## Data Flow

1. User signs in and connects Swiggy through OAuth.
2. User sends a goal, such as budget, diet, cuisine, address, or time constraint.
3. Backend sends the goal plus safe user context to the LLM.
4. LLM proposes tool calls; backend validates allowed actions and calls Swiggy Food MCP.
5. Backend returns structured recommendations and a plain-language explanation.
6. User selects or edits a proposed cart.
7. Backend shows final cart confirmation.
8. Only after explicit confirmation can backend call the order placement tool.
9. Backend tracks the order and records activity.

## Safety and Trust Rules

- Never place an order without explicit confirmation in the current session.
- Show final total, address, cart contents, fees, discounts, and payment mode before checkout.
- Treat order placement as non-idempotent. On network failure, check order status before retrying.
- Re-run OAuth on auth failures rather than retrying stale tokens.
- Log Swiggy MCP session IDs where available to support debugging.
- Do not put access tokens in URLs, browser storage, analytics, or LLM context.
- Do not ask the LLM to invent facts such as refund eligibility, exact delivery guarantees, or unsupported nutrition data.
- Clearly label estimates versus confirmed data.

## Error Handling

- Auth failure: show a reconnect action and preserve the current user goal.
- Tool timeout or 5xx: retry safe read operations with backoff; for order placement, check order history/status before retry.
- No matching options: ask the user which constraint to relax.
- Price or availability changed: refresh the cart and require confirmation again.
- Cart mutation failure: show the failed item and keep the rest of the draft cart intact.
- Order issue: collect timestamp, order ID, item details, screenshots uploaded by the user if supported later, and a concise support summary.

## Implementation Constraints

The current repo is an old Flutter app that does not run on the installed Dart SDK because `pubspec.yaml` declares `sdk: ">=2.7.0 <3.0.0"`, while Dart 3.10.4 requires null safety. Before building the new product, the app needs a modernization pass:

- Upgrade SDK constraints to Dart 3.
- Replace or upgrade outdated dependencies.
- Migrate source to null safety.
- Replace deprecated Flutter theme APIs.
- Update the widget test, which still expects the default counter app.

## Testing Strategy

Design and unit tests:

- LLM planner policy tests for "must confirm before order."
- MCP gateway tests for read retry, order retry guard, auth failure, and cart refresh.
- Recommendation ranking tests for budget, time, diet, and rating constraints.
- Flutter widget tests for assistant input, result cards, cart confirmation, and error states.

Integration tests:

- Mock Swiggy MCP server for deterministic tool responses.
- End-to-end "find dinner, build cart, confirm" flow.
- End-to-end auth expired flow.
- End-to-end changed price before confirmation flow.

Manual verification:

- Run Flutter web locally.
- Test desktop and mobile-width layouts.
- Verify no secrets appear in client logs, browser storage, URLs, or visible UI.

## Open Questions

- Which backend stack should this open-source project standardize on: Node.js for MCP ecosystem maturity, or Dart for single-language consistency?
- Which LLM provider should be the default for local development, and should providers be pluggable from day one?
- Will Swiggy production access be available for this project, or should the open-source repo ship with a mock MCP mode until users bring their own access?
- Should the first release support web only, or web plus Android from the start?

