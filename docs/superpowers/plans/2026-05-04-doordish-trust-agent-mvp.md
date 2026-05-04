# Doordish Trust Agent MVP Implementation Plan

> **For agentic workers:** REQUIRED: Use superpowers:subagent-driven-development (if subagents available) or superpowers:executing-plans to implement this plan. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Build a runnable Flutter MVP for Doordish as a trust-first daily ordering assistant backed by mockable LLM/MCP boundaries.

**Architecture:** Replace the old app entry point with a focused assistant workspace while leaving legacy widgets in place but unused. Add a small domain layer for user intents, recommendations, carts, and activity events; add a mock agent service that simulates the LLM + Swiggy Food MCP flow; make the UI consume that service through clear interfaces so a real backend can replace it later.

**Tech Stack:** Flutter 3.38 / Dart 3, Material UI, `flutter_test`, no new runtime dependencies for the MVP.

---

## Chunk 1: Modernize the Build Surface

### Task 1: Update Package Constraints

**Files:**
- Modify: `pubspec.yaml`
- Modify: `test/widget_test.dart`

- [ ] **Step 1: Update `pubspec.yaml` for Dart 3**

Set the SDK constraint to `">=3.0.0 <4.0.0"`. Remove old runtime dependencies that the new app entry point will not import: `flutter_icons`, `logger`, `equatable`, `js`, `http`, `flutter_google_maps`, and `timeago`. Keep only Flutter SDK and `flutter_test`.

- [ ] **Step 2: Replace the obsolete counter widget test**

Change `test/widget_test.dart` so it pumps `MyApp` and expects to find the title `Doordish`.

- [ ] **Step 3: Run dependency resolution**

Run: `flutter pub get`

Expected: succeeds and creates/updates `pubspec.lock`.

- [ ] **Step 4: Run the smoke test**

Run: `flutter test test/widget_test.dart`

Expected: fails because the old app still imports legacy code or does not expose the new title consistently. This is acceptable red state before replacing the entry point.

---

## Chunk 2: Domain and Agent Service

### Task 2: Add Failing Domain Service Tests

**Files:**
- Create: `test/services/mock_ordering_agent_test.dart`
- Create: `lib/features/agent/ordering_agent.dart`
- Create: `lib/features/agent/mock_ordering_agent.dart`

- [ ] **Step 1: Write tests for the mock ordering agent**

Tests should cover:

- A budget/healthy prompt returns recommendations and a non-empty activity trail.
- Creating a draft cart does not mark it as order placed.
- Confirming a draft cart marks it as placed and adds an activity event.
- Reporting an issue returns a support-ready summary containing order context.

- [ ] **Step 2: Run tests to verify red**

Run: `flutter test test/services/mock_ordering_agent_test.dart`

Expected: FAIL because the service files do not exist yet.

### Task 3: Implement Domain Models and Mock Agent

**Files:**
- Create: `lib/features/agent/ordering_agent.dart`
- Create: `lib/features/agent/mock_ordering_agent.dart`

- [ ] **Step 1: Add domain models**

Define immutable models in `ordering_agent.dart`:

- `AssistantRecommendation`
- `TrustSignal`
- `DraftCart`
- `CartLineItem`
- `ActivityEvent`
- `IssueSummary`
- `OrderingAgent` abstract class

- [ ] **Step 2: Implement `MockOrderingAgent`**

Use deterministic sample data for Food MCP-style restaurant recommendations. Support:

- `recommend(String prompt)`
- `createDraftCart(AssistantRecommendation recommendation)`
- `confirmCart(DraftCart cart)`
- `prepareIssueSummary(DraftCart cart, String issue)`

- [ ] **Step 3: Run domain tests**

Run: `flutter test test/services/mock_ordering_agent_test.dart`

Expected: PASS.

---

## Chunk 3: Assistant UI

### Task 4: Add Failing Widget Tests

**Files:**
- Create: `test/features/agent/assistant_workspace_test.dart`
- Create: `lib/features/agent/assistant_workspace.dart`
- Modify: `lib/main.dart`

- [ ] **Step 1: Write widget tests**

Tests should cover:

- The app shows `Doordish`, the assistant input, and trust-focused panels.
- Entering a prompt and tapping search shows recommendation cards.
- Selecting a recommendation shows a cart confirmation panel.
- Confirming the cart shows a placed-order status.

- [ ] **Step 2: Run tests to verify red**

Run: `flutter test test/features/agent/assistant_workspace_test.dart`

Expected: FAIL because the widget does not exist yet.

### Task 5: Implement Assistant Workspace

**Files:**
- Create: `lib/features/agent/assistant_workspace.dart`
- Modify: `lib/main.dart`

- [ ] **Step 1: Replace `main.dart` app entry**

Use `MaterialApp` with a modern theme and `AssistantWorkspace(agent: MockOrderingAgent())` as the home.

- [ ] **Step 2: Build the assistant workspace**

Create a responsive UI with:

- Header with product name and "Trust-first ordering assistant" positioning.
- Prompt input and primary action.
- Recommendation cards showing fit reason, final estimated total, ETA, rating, and trust signals.
- Plan panel with current constraints and safety rules.
- Cart confirmation panel with explicit confirm button.
- Activity trail listing mock MCP/LLM events.
- Issue summary action after order placement.

- [ ] **Step 3: Run widget tests**

Run: `flutter test test/features/agent/assistant_workspace_test.dart`

Expected: PASS.

---

## Chunk 4: Verification and Docs

### Task 6: Update Open-Source Project Docs

**Files:**
- Modify: `README.md`

- [ ] **Step 1: Rewrite README**

Describe Doordish as an open-source trust-first ordering assistant. Include:

- MVP scope.
- Local run instructions.
- Mock mode note.
- Future Swiggy MCP/backend integration direction.

- [ ] **Step 2: Run all tests**

Run: `flutter test`

Expected: PASS.

- [ ] **Step 3: Run Flutter web build**

Run: `flutter build web`

Expected: PASS.

- [ ] **Step 4: Start local web app**

Run: `flutter run -d web-server --web-hostname 127.0.0.1 --web-port 8080`

Expected: local server starts at `http://127.0.0.1:8080`.

