import 'package:flutter/material.dart';

import '../../constants/app_colors.dart';
import '../../constants/strings.dart';
import '../../model/meal_sorting.dart';
import '../common/horizontal_spacer.dart';

class MealsGridSection extends StatelessWidget {
  const MealsGridSection({
    @required this.sortedBy,
    this.mealsCount = 0,
    this.onMealSortingChange,
    Key key,
  }) : super(key: key);
  final int mealsCount;
  final ValueChanged<MealSorting> onMealSortingChange;
  final MealSorting sortedBy;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Text(
              '$mealsCount',
              style: const TextStyle(
                fontSize: 14,
              ),
            ),
            const HorizontalSpacer(),
            const Text(
              Strings.mealsFound,
              style: TextStyle(
                fontSize: 14,
                color: AppColors.secondaryText,
              ),
            ),
          ],
        ),
        Row(
          children: [
            const Text(
              '${Strings.sortedBy}:',
              style: TextStyle(
                color: AppColors.secondaryText,
                fontSize: 14,
              ),
            ),
            const HorizontalSpacer(),
            DropdownButton<MealSorting>(
              value: sortedBy,
              underline: const SizedBox(),
              items: MealSorting.values.map(_dropDownMenuItemChild).toList(),
              onChanged: onMealSortingChange,
            )
          ],
        ),
      ],
    );
  }

  DropdownMenuItem<MealSorting> _dropDownMenuItemChild(MealSorting sortBy) {
    return DropdownMenuItem<MealSorting>(
      value: sortBy,
      child: Text(
        _dropDownMenuItemChildText(sortBy),
        style: const TextStyle(
          fontSize: 14,
        ),
      ),
    );
  }

  String _dropDownMenuItemChildText(MealSorting sortBy) {
    switch (sortBy) {
      case MealSorting.priceAsc:
        return 'Cost Low To High';
        break;
      case MealSorting.priceDesc:
        return 'Cost High To Low';
        break;
      case MealSorting.rating:
        return 'Rating High To Low';
        break;
      case MealSorting.popularity:
        return 'Popularity';
        break;
    }
    return '';
  }
}
