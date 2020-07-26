import 'package:flutter/material.dart';

import '../../constants/app_colors.dart';
import '../../constants/strings.dart';
import '../../model/meal.dart';
import 'hand_cursor_inkwell.dart';
import 'horizontal_spacer.dart';
import 'vertical_spacer.dart';

class FloatingMealCard extends StatelessWidget {
  const FloatingMealCard({
    @required this.meal,
    this.onOrderNowClick,
    Key key,
  }) : super(key: key);
  final Meal meal;
  final ValueChanged<Meal> onOrderNowClick;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Container(
        height: 144,
        width: 300,
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  meal.name,
                  style: const TextStyle(fontSize: 18),
                ),
                const HorizontalSpacer(
                  space: 16,
                ),
                Container(
                  width: 1,
                  height: 20,
                  color: AppColors.primaryColor,
                ),
                const HorizontalSpacer(
                  space: 16,
                ),
                Text(
                  '${Strings.rupeeSymbol}${meal.price}',
                  style: const TextStyle(fontSize: 18),
                ),
              ],
            ),
            const VerticalSpacer(
              space: 16,
            ),
            Text(
              meal.description,
              style: const TextStyle(
                color: AppColors.secondaryText,
                fontSize: 13,
                fontWeight: FontWeight.w300,
              ),
            ),
            const VerticalSpacer(),
            HandCursorInkWell(
              onClick: () => onOrderNowClick(meal),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Text(
                    Strings.orderNow,
                    style: TextStyle(
                      color: AppColors.primaryColor,
                      fontSize: 13,
                    ),
                  ),
                  HorizontalSpacer(),
                  Icon(
                    Icons.arrow_forward,
                    size: 20,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
