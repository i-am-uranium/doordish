import 'package:flutter/material.dart';

import '../../model/line_item.dart';
import '../common/vertical_spacer.dart';
import 'cart_item.dart';

class Cart extends StatelessWidget {
  const Cart(
      {Key key,
      this.cartItems = const [],
      this.scrollController,
      this.onRemoveItemClick,
      this.onItemQuantityIncrease,
      this.onItemQuantityDecrease})
      : super(key: key);

  final List<LineItem> cartItems;
  final ScrollController scrollController;
  final Function(int) onRemoveItemClick;
  final Function(int) onItemQuantityIncrease;
  final Function(int) onItemQuantityDecrease;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const AlwaysScrollableScrollPhysics(),
      reverse: true,
      shrinkWrap: true,
      controller: scrollController,
      padding: EdgeInsets.zero,
      itemCount: cartItems.length,
      itemBuilder: (context, index) {
        return Column(
          children: [
            CartItem(
              lineItem: cartItems[index],
              onRemoveClick: () => onRemoveItemClick(index),
              onItemQuantityIncrease: () => onItemQuantityIncrease(index),
              onItemQuantityDecrease: () => onItemQuantityDecrease(index),
            ),
            const VerticalSpacer(),
          ],
        );
      },
    );
  }
}
