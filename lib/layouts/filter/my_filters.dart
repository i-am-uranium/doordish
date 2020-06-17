import 'package:flutter/material.dart';

import '../../constants/app_colors.dart';
import '../../constants/strings.dart';
import '../../model/meal_filter_categories.dart';
import '../common/horizontal_spacer.dart';

class MyFilters extends StatelessWidget {
  MyFilters({
    @required this.onPopularCategorySelect,
    @required this.onRemoveCategoryClick,
    this.categories,
    Key key,
  }) : super(key: key);

  final List<MealFilterCategory> categories;
  final ValueChanged<MealFilterCategory> onPopularCategorySelect;
  final ValueChanged<MealFilterCategory> onRemoveCategoryClick;

  final List<MealFilterCategory> _popularFilters =
      MealFilterCategory.popularFilters;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 36,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              const Text(
                '${Strings.myFilters}:',
                style: TextStyle(
                  fontSize: 12,
                  letterSpacing: 1,
                ),
              ),
              const HorizontalSpacer(),
              if (categories != null)
                SizedBox(
                  width: 285,
                  child: ListView.builder(
                    reverse: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: categories.length,
                    itemBuilder: (context, index) => _filterChip(
                      categories[index],
                      onSelect: () => onRemoveCategoryClick(categories[index]),
                    ),
                  ),
                )
              else
                const SizedBox(),
            ],
          ),
          _popularFilterWidget(),
        ],
      ),
    );
  }

  Widget _popularFilterWidget() {
    return Row(
      children: [
        const Text(
          '${Strings.popularFilters}:',
          style: TextStyle(
            fontSize: 12,
            letterSpacing: 1,
          ),
        ),
        Row(
          children: _popularFilters
              .map(
                (e) => _filterChip(e, onSelect: () {
                  onPopularCategorySelect(e);
                }),
              )
              .toList(),
        )
      ],
    );
  }

  Widget _filterChip(MealFilterCategory foodCategories, {Function onSelect}) {
    return Row(
      children: [
        FilterChip(
          backgroundColor: foodCategories.selected
              ? AppColors.primaryColor
              : AppColors.filterChipInActiveBackground,
          padding: const EdgeInsets.all(2),
          onSelected: (value) => onSelect(),
          avatar: Container(
            width: 20,
            height: 20,
            padding: EdgeInsets.zero,
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Image.asset(
              foodCategories.icon,
              color: foodCategories.selected
                  ? AppColors.primaryColor
                  : AppColors.black,
            ),
          ),
          label: Text(
            foodCategories.name,
          ),
          labelStyle: TextStyle(
            color: foodCategories.selected ? AppColors.white : AppColors.black,
            fontSize: 12,
            letterSpacing: .5,
          ),
        ),
        const HorizontalSpacer(),
      ],
    );
  }
}
