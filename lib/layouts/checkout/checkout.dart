import 'package:flutter/material.dart';

import '../../constants/app_colors.dart';
import '../../constants/strings.dart';
import '../../model/line_item.dart';
import '../../model/meal.dart';
import '../../utils/logger.dart';
import '../cart/cart.dart';
import '../common/dotter_line_painter.dart';
import '../order/order_delivery_detail.dart';
import 'credit_card.dart';
import 'header.dart';

class Checkout extends StatefulWidget {
  const Checkout({
    this.onProfileClick,
    this.onNotificationClick,
    this.onMoreClick,
    this.dragTargetHeight = 48,
    Key key,
  }) : super(key: key);
  final Function onProfileClick;
  final Function onNotificationClick;
  final Function onMoreClick;
  final double dragTargetHeight;

  @override
  CheckoutState createState() => CheckoutState();
}

class CheckoutState extends State<Checkout> {
  double cartViewHeight = 0;
  final ScrollController _scrollController = ScrollController();
  List<LineItem> cartItems = [];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16),
      child: Column(
        children: [
          CheckoutHeader(
            onNotificationClick: () {
              logger.i('on notification click');
            },
            onProfileClick: () {
              logger.i('on profile click');
            },
            onMoreClick: () {
              logger.i('on more click');
            },
          ),
          const OrderDeliveryDetails(),
          Padding(
            padding: const EdgeInsets.only(right: 16, top: 16),
            child: Divider(
              thickness: 1,
              color: AppColors.divider,
            ),
          ),
          AnimatedContainer(
            width: MediaQuery.of(context).size.width * .28,
            height: cartViewHeight,
            padding: const EdgeInsets.only(bottom: 16, right: 16),
            duration: const Duration(milliseconds: 1000),
            curve: Curves.easeIn,
            child: Cart(
              cartItems: cartItems,
              scrollController: _scrollController,
              onItemQuantityDecrease: decreaseCartItemQuantity,
              onItemQuantityIncrease: increaseCartItemQuantity,
              onRemoveItemClick: removeCartItem,
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  AnimatedContainer(
                    padding: const EdgeInsets.only(right: 16),
                    width: MediaQuery.of(context).size.width * .28,
                    height: widget.dragTargetHeight,
                    color: AppColors.dropTargetFill,
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeIn,
                    child: CustomPaint(
                      size: Size(
                        MediaQuery.of(context).size.width * .28,
                        widget.dragTargetHeight,
                      ),
                      painter: DottedLinePainter(),
                      child: _mealDragTarget,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 24,
                      right: 16,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          Strings.total,
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          '${Strings.rupeeSymbol}$_orderTotal',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * .28,
                    height: 40,
                    margin: const EdgeInsets.only(
                      right: 16,
                      top: 16,
                    ),
                    child: RaisedButton(
                      color: AppColors.primaryColor,
                      onPressed: _orderTotal > 0 ? _placeOrder : null,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          8,
                        ),
                      ),
                      child: const Text(
                        Strings.checkout,
                        style: TextStyle(
                          fontSize: 16,
                          color: AppColors.white,
                        ),
                      ),
                    ),
                  ),
                  const CreditCard(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _placeOrder() {
    logger.i('On checkout click');
  }

  void increaseCartItemQuantity(int index) {
    setState(() {
      final LineItem lineItem = cartItems[index];
      if (lineItem.quantity < 10) {
        lineItem.quantity++;
      }
    });
  }

  void decreaseCartItemQuantity(int index) {
    setState(() {
      final LineItem lineItem = cartItems[index];
      if (lineItem.quantity > 1) {
        lineItem.quantity--;
      }
    });
  }

  Widget get _mealDragTarget {
    return DragTarget<Meal>(
      builder: (context, candidateData, rejectedData) {
        return const Center(
          child: Text(
            Strings.dragAndDrop,
            style: TextStyle(
              color: AppColors.primaryColor,
              fontSize: 16,
            ),
          ),
        );
      },
      onWillAccept: (data) => true,
      onAccept: _updateCartItems,
    );
  }

  double get _orderTotal {
    double result = 0;
    for (final lineItem in cartItems) {
      result += lineItem.meal.price * lineItem.quantity;
    }
    return result;
  }

  void _updateCartItems(Meal data) {
    setState(() {
      if (cartItems.isNotEmpty) {
        final LineItem lineItem = cartItems.firstWhere(
          (item) => item.meal.id == data.id,
          orElse: () => null,
        );
        if (lineItem != null) {
          lineItem.quantity++;
        } else {
          cartItems.add(LineItem(meal: data, quantity: 1));
          increaseCartViewHeight();
        }
      } else {
        cartItems.add(LineItem(meal: data, quantity: 1));
        increaseCartViewHeight();
      }
    });
    _scrollController.animateTo(
      cartItems.length * 80.0,
      curve: Curves.easeOut,
      duration: const Duration(milliseconds: 500),
    );
  }

  void increaseCartViewHeight() {
    if (cartViewHeight < 180) {
      cartViewHeight += 80;
    }
  }

  void removeCartItem(int index) {
    setState(() {
      cartItems.removeAt(index);
      decreaseCartViewHeight();
    });
  }

  void decreaseCartViewHeight() {
    if (cartItems.length < 3) {
      cartViewHeight -= 80;
    }
  }
}
