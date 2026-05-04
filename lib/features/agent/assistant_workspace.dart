import 'package:flutter/material.dart';

import 'ordering_agent.dart';

class AssistantWorkspace extends StatefulWidget {
  const AssistantWorkspace({
    required this.agent,
    super.key,
  });

  final OrderingAgent agent;

  @override
  State<AssistantWorkspace> createState() => _AssistantWorkspaceState();
}

class _AssistantWorkspaceState extends State<AssistantWorkspace> {
  final TextEditingController _promptController = TextEditingController(
    text:
        'Find dinner under Rs 300 total, high protein, delivery under 30 minutes.',
  );

  List<AssistantRecommendation> _recommendations = [];
  List<ActivityEvent> _activityTrail = [];
  DraftCart? _cart;
  IssueSummary? _issueSummary;
  bool _loading = false;
  String _currentGoal =
      'Set a budget, diet, cuisine, location, or delivery deadline.';

  @override
  void dispose() {
    _promptController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final isWide = width >= 980;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const _Header(),
              const SizedBox(height: 18),
              Expanded(
                child: isWide
                    ? Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 7,
                            child: SingleChildScrollView(
                              child: _AssistantPanel(
                                promptController: _promptController,
                                loading: _loading,
                                recommendations: _recommendations,
                                cart: _cart,
                                issueSummary: _issueSummary,
                                onFindOptions: _findOptions,
                                onReviewCart: _reviewCart,
                                onConfirmCart: _confirmCart,
                                onPrepareIssueSummary: _prepareIssueSummary,
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          SizedBox(
                            width: 360,
                            child: SingleChildScrollView(
                              child: _SidePanel(
                                currentGoal: _currentGoal,
                                activityTrail: _activityTrail,
                              ),
                            ),
                          ),
                        ],
                      )
                    : ListView(
                        children: [
                          _AssistantPanel(
                            promptController: _promptController,
                            loading: _loading,
                            recommendations: _recommendations,
                            cart: _cart,
                            issueSummary: _issueSummary,
                            onFindOptions: _findOptions,
                            onReviewCart: _reviewCart,
                            onConfirmCart: _confirmCart,
                            onPrepareIssueSummary: _prepareIssueSummary,
                          ),
                          const SizedBox(height: 16),
                          _SidePanel(
                            currentGoal: _currentGoal,
                            activityTrail: _activityTrail,
                          ),
                        ],
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _findOptions() async {
    setState(() {
      _loading = true;
      _cart = null;
      _issueSummary = null;
      _currentGoal = _promptController.text.trim();
    });

    final response = await widget.agent.recommend(_promptController.text);

    setState(() {
      _recommendations = response.recommendations;
      _activityTrail = response.activityTrail;
      _loading = false;
    });
  }

  Future<void> _reviewCart(AssistantRecommendation recommendation) async {
    final cart = await widget.agent.createDraftCart(recommendation);

    setState(() {
      _cart = cart;
      _activityTrail = cart.activityTrail;
      _issueSummary = null;
    });
  }

  Future<void> _confirmCart() async {
    final cart = _cart;
    if (cart == null) {
      return;
    }

    final placed = await widget.agent.confirmCart(cart);

    setState(() {
      _cart = placed;
      _activityTrail = placed.activityTrail;
    });
  }

  Future<void> _prepareIssueSummary() async {
    final cart = _cart;
    if (cart == null) {
      return;
    }

    final summary = await widget.agent.prepareIssueSummary(
      cart,
      'Item missing or order quality issue',
    );

    setState(() {
      _issueSummary = summary;
      _activityTrail = widget.agent.activityTrail;
    });
  }
}

class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 18,
      runSpacing: 10,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        Text(
          'Doordish',
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.w800,
                color: const Color(0xFF14251B),
              ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
          decoration: BoxDecoration(
            color: const Color(0xFFE5F7EC),
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Text(
            'Trust-first ordering assistant',
            style: TextStyle(
              color: Color(0xFF17673C),
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ],
    );
  }
}

class _AssistantPanel extends StatelessWidget {
  const _AssistantPanel({
    required this.promptController,
    required this.loading,
    required this.recommendations,
    required this.cart,
    required this.issueSummary,
    required this.onFindOptions,
    required this.onReviewCart,
    required this.onConfirmCart,
    required this.onPrepareIssueSummary,
  });

  final TextEditingController promptController;
  final bool loading;
  final List<AssistantRecommendation> recommendations;
  final DraftCart? cart;
  final IssueSummary? issueSummary;
  final VoidCallback onFindOptions;
  final ValueChanged<AssistantRecommendation> onReviewCart;
  final VoidCallback onConfirmCart;
  final VoidCallback onPrepareIssueSummary;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _Section(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'What do you need today?',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: promptController,
                minLines: 2,
                maxLines: 4,
                decoration: const InputDecoration(
                  hintText:
                      'Example: healthy dinner under Rs 300, delivery under 30 minutes',
                ),
              ),
              const SizedBox(height: 12),
              FilledButton.icon(
                onPressed: loading ? null : onFindOptions,
                icon: loading
                    ? const SizedBox(
                        width: 16,
                        height: 16,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Icon(Icons.manage_search),
                label: const Text('Find options'),
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),
        if (recommendations.isEmpty)
          const _EmptyState()
        else
          ...recommendations.map(
            (recommendation) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: _RecommendationCard(
                recommendation: recommendation,
                onReviewCart: () => onReviewCart(recommendation),
              ),
            ),
          ),
        if (cart != null) ...[
          const SizedBox(height: 2),
          _CartConfirmation(
            cart: cart!,
            onConfirmCart: onConfirmCart,
            onPrepareIssueSummary: onPrepareIssueSummary,
          ),
        ],
        if (issueSummary != null) ...[
          const SizedBox(height: 12),
          _Section(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Support-ready summary',
                  style: TextStyle(fontWeight: FontWeight.w800),
                ),
                const SizedBox(height: 8),
                Text(issueSummary!.supportText),
              ],
            ),
          ),
        ],
      ],
    );
  }
}

class _RecommendationCard extends StatelessWidget {
  const _RecommendationCard({
    required this.recommendation,
    required this.onReviewCart,
  });

  final AssistantRecommendation recommendation;
  final VoidCallback onReviewCart;

  @override
  Widget build(BuildContext context) {
    return _Section(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      recommendation.title,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w800,
                          ),
                    ),
                    const SizedBox(height: 4),
                    Text(recommendation.restaurantName),
                  ],
                ),
              ),
              Text(
                'Rs ${recommendation.estimatedTotal}',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(recommendation.fitReason),
          const SizedBox(height: 10),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _MetricChip(
                  icon: Icons.schedule,
                  label: '${recommendation.etaMinutes} min'),
              _MetricChip(
                  icon: Icons.star,
                  label: recommendation.rating.toStringAsFixed(1)),
              for (final signal in recommendation.trustSignals)
                _MetricChip(icon: Icons.verified_outlined, label: signal.label),
            ],
          ),
          const SizedBox(height: 12),
          OutlinedButton.icon(
            onPressed: onReviewCart,
            icon: const Icon(Icons.receipt_long),
            label: const Text('Review cart'),
          ),
        ],
      ),
    );
  }
}

class _CartConfirmation extends StatelessWidget {
  const _CartConfirmation({
    required this.cart,
    required this.onConfirmCart,
    required this.onPrepareIssueSummary,
  });

  final DraftCart cart;
  final VoidCallback onConfirmCart;
  final VoidCallback onPrepareIssueSummary;

  @override
  Widget build(BuildContext context) {
    return _Section(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  cart.isPlaced
                      ? 'Order placed: ${cart.orderId}'
                      : 'Cart confirmation',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w800,
                      ),
                ),
              ),
              Icon(
                cart.isPlaced ? Icons.check_circle : Icons.lock_outline,
                color: cart.isPlaced ? Colors.green : Colors.orange,
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(cart.restaurantName),
          const SizedBox(height: 8),
          for (final item in cart.items)
            Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: Text(
                  '${item.quantity} x ${item.name} - Rs ${item.lineTotal}'),
            ),
          const Divider(height: 22),
          Text('Subtotal Rs ${cart.subtotal}'),
          Text('Fees Rs ${cart.fees}'),
          Text('Discount Rs ${cart.discount}'),
          const SizedBox(height: 6),
          Text(
            'Final payable Rs ${cart.total}',
            style: const TextStyle(fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 12),
          if (!cart.isPlaced)
            FilledButton.icon(
              onPressed: onConfirmCart,
              icon: const Icon(Icons.check),
              label: const Text('Confirm order'),
            )
          else
            OutlinedButton.icon(
              onPressed: onPrepareIssueSummary,
              icon: const Icon(Icons.support_agent),
              label: const Text('Prepare issue summary'),
            ),
        ],
      ),
    );
  }
}

class _SidePanel extends StatelessWidget {
  const _SidePanel({
    required this.currentGoal,
    required this.activityTrail,
  });

  final String currentGoal;
  final List<ActivityEvent> activityTrail;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _Section(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Plan', style: TextStyle(fontWeight: FontWeight.w800)),
              const SizedBox(height: 8),
              Text(currentGoal),
            ],
          ),
        ),
        const SizedBox(height: 12),
        const _SafetyRules(),
        const SizedBox(height: 12),
        _Section(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Activity trail',
                style: TextStyle(fontWeight: FontWeight.w800),
              ),
              const SizedBox(height: 8),
              if (activityTrail.isEmpty)
                const Text('No tool calls yet.')
              else
                for (final event in activityTrail)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          event.label,
                          style: const TextStyle(fontWeight: FontWeight.w700),
                        ),
                        Text(event.detail),
                      ],
                    ),
                  ),
            ],
          ),
        ),
      ],
    );
  }
}

class _SafetyRules extends StatelessWidget {
  const _SafetyRules();

  @override
  Widget build(BuildContext context) {
    const rules = [
      'No order without explicit confirmation.',
      'Show total, fees, discount, and items first.',
      'Keep support-ready context after checkout.',
    ];

    return _Section(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Safety rules',
            style: TextStyle(fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 8),
          for (final rule in rules)
            Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(Icons.check, size: 17),
                  const SizedBox(width: 6),
                  Expanded(child: Text(rule)),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

class _MetricChip extends StatelessWidget {
  const _MetricChip({
    required this.icon,
    required this.label,
  });

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Chip(
      avatar: Icon(icon, size: 16),
      label: Text(label),
      visualDensity: VisualDensity.compact,
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    return const _Section(
      child: Text(
        'Ask for a meal by budget, diet, cuisine, delivery time, or reliability. '
        'Doordish will compare options by final estimated cost and trust signals.',
      ),
    );
  }
}

class _Section extends StatelessWidget {
  const _Section({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFE1E4DC)),
      ),
      child: child,
    );
  }
}
