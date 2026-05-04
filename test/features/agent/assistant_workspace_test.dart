import 'package:doordish/features/agent/assistant_workspace.dart';
import 'package:doordish/features/agent/mock_ordering_agent.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Widget buildSubject() {
    return MaterialApp(
      home: AssistantWorkspace(agent: MockOrderingAgent()),
    );
  }

  testWidgets('shows assistant shell and trust panels', (tester) async {
    await tester.pumpWidget(buildSubject());

    expect(find.text('Doordish'), findsOneWidget);
    expect(find.text('Trust-first ordering assistant'), findsOneWidget);
    expect(find.byType(TextField), findsOneWidget);
    expect(find.text('Plan'), findsOneWidget);
    expect(find.text('Safety rules'), findsOneWidget);
  });

  testWidgets('prompt search shows recommendation cards', (tester) async {
    await tester.pumpWidget(buildSubject());

    await tester.enterText(
      find.byType(TextField),
      'Find healthy dinner under Rs 300',
    );
    await tester.tap(find.text('Find options'));
    await tester.pumpAndSettle();

    expect(find.text('High-protein paneer bowl'), findsOneWidget);
    expect(find.textContaining('Rs 286'), findsOneWidget);
    expect(find.text('Review cart'), findsWidgets);
  });

  testWidgets('selecting recommendation shows cart confirmation',
      (tester) async {
    await tester.pumpWidget(buildSubject());

    await tester.enterText(find.byType(TextField), 'quick lunch under Rs 300');
    await tester.tap(find.text('Find options'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Review cart').first);
    await tester.pumpAndSettle();

    expect(find.text('Cart confirmation'), findsOneWidget);
    expect(find.text('Confirm order'), findsOneWidget);
    expect(find.textContaining('Final payable'), findsOneWidget);
  });

  testWidgets('confirming cart shows placed order status', (tester) async {
    await tester.pumpWidget(buildSubject());

    await tester.enterText(find.byType(TextField), 'quick lunch under Rs 300');
    await tester.tap(find.text('Find options'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Review cart').first);
    await tester.pumpAndSettle();
    await tester.scrollUntilVisible(
      find.text('Confirm order'),
      220,
      scrollable: find.byType(Scrollable).first,
    );
    await tester.pumpAndSettle();
    await tester.tap(find.text('Confirm order'));
    await tester.pumpAndSettle();

    expect(find.textContaining('Order placed'), findsOneWidget);
    expect(find.text('Prepare issue summary'), findsOneWidget);
  });
}
