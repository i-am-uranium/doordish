import 'package:doordish/features/agent/mock_ordering_agent.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late MockOrderingAgent agent;

  setUp(() {
    agent = MockOrderingAgent();
  });

  test('budget and healthy prompt returns recommendations with activity',
      () async {
    final response = await agent.recommend(
      'Find dinner under Rs 300 total, high protein, delivery under 30 minutes.',
    );

    expect(response.recommendations, isNotEmpty);
    expect(
        response.recommendations.first.estimatedTotal, lessThanOrEqualTo(300));
    expect(response.recommendations.first.trustSignals, isNotEmpty);
    expect(response.activityTrail, isNotEmpty);
    expect(response.activityTrail.first.label, contains('intent'));
  });

  test('creating draft cart does not place the order', () async {
    final response = await agent.recommend('quick lunch under Rs 300');
    final cart = await agent.createDraftCart(response.recommendations.first);

    expect(cart.isPlaced, isFalse);
    expect(cart.items, isNotEmpty);
    expect(cart.confirmationRequired, isTrue);
  });

  test('confirming draft cart marks it placed and records activity', () async {
    final response = await agent.recommend('quick lunch under Rs 300');
    final draft = await agent.createDraftCart(response.recommendations.first);

    final placed = await agent.confirmCart(draft);

    expect(placed.isPlaced, isTrue);
    expect(placed.confirmationRequired, isFalse);
    expect(agent.activityTrail.last.label, contains('order'));
  });

  test('issue summary contains order context', () async {
    final response = await agent.recommend('quick lunch under Rs 300');
    final draft = await agent.createDraftCart(response.recommendations.first);
    final placed = await agent.confirmCart(draft);

    final summary = await agent.prepareIssueSummary(
      placed,
      'One item is missing',
    );

    expect(summary.issue, 'One item is missing');
    expect(summary.supportText, contains(placed.restaurantName));
    expect(summary.supportText, contains(placed.orderId));
    expect(summary.supportText, contains('missing'));
  });
}
