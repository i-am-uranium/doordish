import 'ordering_agent.dart';

class MockOrderingAgent implements OrderingAgent {
  final List<ActivityEvent> _activityTrail = [];

  @override
  List<ActivityEvent> get activityTrail => List.unmodifiable(_activityTrail);

  @override
  Future<RecommendationResponse> recommend(String prompt) async {
    _activityTrail
      ..clear()
      ..add(
        ActivityEvent(
          label: 'Parsed intent',
          detail: 'Budget, speed, diet, and reliability signals extracted.',
        ),
      )
      ..add(
        ActivityEvent(
          label: 'Mock MCP search',
          detail: 'Queried food recommendations using local sample data.',
        ),
      );

    final normalizedPrompt = prompt.toLowerCase();
    final recommendations = normalizedPrompt.contains('healthy') ||
            normalizedPrompt.contains('protein')
        ? _healthyRecommendations
        : _quickRecommendations;

    return RecommendationResponse(
      recommendations: recommendations,
      activityTrail: activityTrail,
    );
  }

  @override
  Future<DraftCart> createDraftCart(
    AssistantRecommendation recommendation,
  ) async {
    final subtotal = recommendation.items.fold<int>(
      0,
      (sum, item) => sum + item.lineTotal,
    );
    final fees = 42;
    final discount = recommendation.estimatedTotal < subtotal + fees
        ? subtotal + fees - recommendation.estimatedTotal
        : 0;
    final total = subtotal + fees - discount;
    final event = ActivityEvent(
      label: 'Draft cart created',
      detail: 'Cart is ready for review. Order placement is locked.',
    );
    _activityTrail.add(event);

    return DraftCart(
      id: 'cart-${recommendation.id}',
      restaurantName: recommendation.restaurantName,
      items: recommendation.items,
      subtotal: subtotal,
      fees: fees,
      discount: discount,
      total: total,
      confirmationRequired: true,
      isPlaced: false,
      orderId: '',
      activityTrail: activityTrail,
    );
  }

  @override
  Future<DraftCart> confirmCart(DraftCart cart) async {
    final event = ActivityEvent(
      label: 'Mock order placed',
      detail: 'User confirmed final cart total Rs ${cart.total}.',
    );
    _activityTrail.add(event);

    return cart.copyWith(
      confirmationRequired: false,
      isPlaced: true,
      orderId: 'DD-MOCK-1042',
      activityTrail: activityTrail,
    );
  }

  @override
  Future<IssueSummary> prepareIssueSummary(
    DraftCart cart,
    String issue,
  ) async {
    final itemList =
        cart.items.map((item) => '${item.quantity} x ${item.name}').join(', ');
    final supportText = 'Order ${cart.orderId} from ${cart.restaurantName}: '
        '$itemList. Paid Rs ${cart.total}. User reported: $issue.';

    _activityTrail.add(
      const ActivityEvent(
        label: 'Issue summary prepared',
        detail: 'Support-ready order context generated.',
      ),
    );

    return IssueSummary(issue: issue, supportText: supportText);
  }

  static const List<AssistantRecommendation> _healthyRecommendations = [
    AssistantRecommendation(
      id: 'protein-bowl',
      restaurantName: 'Green Spoon Kitchen',
      title: 'High-protein paneer bowl',
      fitReason:
          'Fits the Rs 300 target, keeps protein high, and has a short ETA.',
      estimatedTotal: 286,
      etaMinutes: 24,
      rating: 4.6,
      items: [
        CartLineItem(name: 'Paneer Protein Bowl', quantity: 1, price: 244),
      ],
      trustSignals: [
        TrustSignal(
            label: 'Total-cost fit',
            detail: 'Estimated payable stays under budget.'),
        TrustSignal(label: 'Fast enough', detail: 'ETA leaves a small buffer.'),
        TrustSignal(
            label: 'Clear cart',
            detail: 'Single item lowers missing-item risk.'),
      ],
    ),
    AssistantRecommendation(
      id: 'grilled-chicken',
      restaurantName: 'Lean Tiffin Co.',
      title: 'Grilled chicken rice plate',
      fitReason:
          'Best protein match with reliable rating, slightly tighter on ETA.',
      estimatedTotal: 299,
      etaMinutes: 29,
      rating: 4.4,
      items: [
        CartLineItem(
            name: 'Grilled Chicken Rice Plate', quantity: 1, price: 257),
      ],
      trustSignals: [
        TrustSignal(
            label: 'Protein match',
            detail: 'Best match for the health constraint.'),
        TrustSignal(
            label: 'Budget guard', detail: 'No add-ons selected by default.'),
      ],
    ),
  ];

  static const List<AssistantRecommendation> _quickRecommendations = [
    AssistantRecommendation(
      id: 'quick-thali',
      restaurantName: 'Everyday Thali House',
      title: 'Mini thali lunch',
      fitReason:
          'Low decision load, clear pricing, and practical for workday lunch.',
      estimatedTotal: 238,
      etaMinutes: 21,
      rating: 4.5,
      items: [
        CartLineItem(name: 'Mini Veg Thali', quantity: 1, price: 196),
      ],
      trustSignals: [
        TrustSignal(
            label: 'Reliable ETA',
            detail: 'Usually arrives inside a lunch break.'),
        TrustSignal(
            label: 'Simple pack',
            detail: 'One combo item is easier to verify.'),
      ],
    ),
    AssistantRecommendation(
      id: 'idli-combo',
      restaurantName: 'South Corner',
      title: 'Idli vada combo',
      fitReason: 'Fastest option and comfortably under budget.',
      estimatedTotal: 182,
      etaMinutes: 18,
      rating: 4.3,
      items: [
        CartLineItem(name: 'Idli Vada Combo', quantity: 1, price: 140),
      ],
      trustSignals: [
        TrustSignal(
            label: 'Fastest pick', detail: 'Best ETA among available options.'),
        TrustSignal(
            label: 'Budget fit', detail: 'Leaves room for price changes.'),
      ],
    ),
  ];
}
