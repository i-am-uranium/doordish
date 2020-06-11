import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

import '../../constants/app_colors.dart';
import '../../model/line_item.dart';
import '../common/cursor_widget.dart';
import '../common/horizontal_spacer.dart';
import '../common/vertical_spacer.dart';

class CartItem extends StatelessWidget {
  const CartItem({
    Key key,
    this.lineItem,
    this.onRemoveClick,
    this.onItemQuantityIncrease,
    this.onItemQuantityDecrease,
  }) : super(key: key);

  final LineItem lineItem;
  final Function onRemoveClick;
  final Function onItemQuantityIncrease;
  final Function onItemQuantityDecrease;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(
              width: 64,
              height: 64,
              padding: const EdgeInsets.only(top: 16),
              color: AppColors.white,
              child: Image.asset(
                lineItem.meal.imageUrl,
                width: 24,
                height: 24,
              ),
            ),
            const HorizontalSpacer(),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  lineItem.meal.name,
                  style: const TextStyle(
                    color: AppColors.black,
                    fontSize: 12,
                  ),
                ),
                const VerticalSpacer(
                  space: 4,
                ),
                Text(
                  '''${lineItem.meal.quantity.value}${lineItem.meal.mealQuantityUnit}''',
                  softWrap: true,
                  style: const TextStyle(
                    color: AppColors.secondaryText,
                    fontSize: 12,
                    fontWeight: FontWeight.w300,
                  ),
                )
              ],
            )
          ],
        ),
        Row(
          children: [
            Container(
              width: 90,
              height: 24,
              decoration: BoxDecoration(
                border: Border.all(
                  color: AppColors.primaryColor,
                  width: 1.5,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  CursorWidget(
                    child: IconButton(
                      icon: const Icon(
                        MaterialCommunityIcons.minus,
                        size: 10,
                      ),
                      padding: EdgeInsets.zero,
                      onPressed: onItemQuantityDecrease,
                    ),
                  ),
                  Text(
                    '${lineItem.quantity}',
                    style: const TextStyle(
                      fontSize: 12,
                    ),
                  ),
                  CursorWidget(
                    child: IconButton(
                      icon: const Icon(
                        MaterialCommunityIcons.plus,
                        size: 10,
                      ),
                      padding: EdgeInsets.zero,
                      onPressed: onItemQuantityIncrease,
                    ),
                  )
                ],
              ),
            ),
            const HorizontalSpacer(
              space: 12,
            ),
            Text(
              '₹${lineItem.meal.price}',
              softWrap: true,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
            CursorWidget(
              child: IconButton(
                icon: const Icon(
                  Icons.close,
                  size: 16,
                  color: AppColors.closeButton,
                ),
                onPressed: onRemoveClick,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
