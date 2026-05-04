abstract class OrderingAgent {
  Future<RecommendationResponse> recommend(String prompt);

  Future<DraftCart> createDraftCart(AssistantRecommendation recommendation);

  Future<DraftCart> confirmCart(DraftCart cart);

  Future<IssueSummary> prepareIssueSummary(DraftCart cart, String issue);

  List<ActivityEvent> get activityTrail;
}

class RecommendationResponse {
  const RecommendationResponse({
    required this.recommendations,
    required this.activityTrail,
  });

  final List<AssistantRecommendation> recommendations;
  final List<ActivityEvent> activityTrail;
}

class AssistantRecommendation {
  const AssistantRecommendation({
    required this.id,
    required this.restaurantName,
    required this.title,
    required this.fitReason,
    required this.estimatedTotal,
    required this.etaMinutes,
    required this.rating,
    required this.items,
    required this.trustSignals,
  });

  final String id;
  final String restaurantName;
  final String title;
  final String fitReason;
  final int estimatedTotal;
  final int etaMinutes;
  final double rating;
  final List<CartLineItem> items;
  final List<TrustSignal> trustSignals;
}

class TrustSignal {
  const TrustSignal({
    required this.label,
    required this.detail,
  });

  final String label;
  final String detail;
}

class DraftCart {
  const DraftCart({
    required this.id,
    required this.restaurantName,
    required this.items,
    required this.subtotal,
    required this.fees,
    required this.discount,
    required this.total,
    required this.confirmationRequired,
    required this.isPlaced,
    required this.orderId,
    required this.activityTrail,
  });

  final String id;
  final String restaurantName;
  final List<CartLineItem> items;
  final int subtotal;
  final int fees;
  final int discount;
  final int total;
  final bool confirmationRequired;
  final bool isPlaced;
  final String orderId;
  final List<ActivityEvent> activityTrail;

  DraftCart copyWith({
    bool? confirmationRequired,
    bool? isPlaced,
    String? orderId,
    List<ActivityEvent>? activityTrail,
  }) {
    return DraftCart(
      id: id,
      restaurantName: restaurantName,
      items: items,
      subtotal: subtotal,
      fees: fees,
      discount: discount,
      total: total,
      confirmationRequired: confirmationRequired ?? this.confirmationRequired,
      isPlaced: isPlaced ?? this.isPlaced,
      orderId: orderId ?? this.orderId,
      activityTrail: activityTrail ?? this.activityTrail,
    );
  }
}

class CartLineItem {
  const CartLineItem({
    required this.name,
    required this.quantity,
    required this.price,
  });

  final String name;
  final int quantity;
  final int price;

  int get lineTotal => quantity * price;
}

class ActivityEvent {
  const ActivityEvent({
    required this.label,
    required this.detail,
  });

  final String label;
  final String detail;
}

class IssueSummary {
  const IssueSummary({
    required this.issue,
    required this.supportText,
  });

  final String issue;
  final String supportText;
}
