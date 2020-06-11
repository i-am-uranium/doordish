import 'package:flutter/material.dart';

import '../../constants/app_colors.dart';
import '../../constants/assets.dart';
import '../../constants/strings.dart';
import '../../model/food_categories.dart';
import '../../model/meal_filter.dart';
import '../common/horizontal_spacer.dart';

class MealFilters extends StatefulWidget {
  const MealFilters({
    this.filters,
    Key key,
  }) : super(key: key);
  final MealFilter filters;

  @override
  _MealFiltersState createState() => _MealFiltersState();
}

class _MealFiltersState extends State<MealFilters> {
  MealFilter _filters;
  final List<FoodCategories> _popularFilters = [
    FoodCategories(
      name: 'Burgers',
      selected: false,
      icon: Assets.burger,
    ),
    FoodCategories(
      name: 'Pizza',
      selected: false,
      icon: Assets.burger,
    )
  ];
  @override
  void didUpdateWidget(MealFilters oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (_filters != null && widget.filters != null) {
      widget.filters.categories.addAll(_filters.categories);
    }
    if (widget.filters != null) {
      _filters = widget.filters;
    }
  }

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
              if (_filters != null)
                SizedBox(
                  width: 285,
                  child: ListView.builder(
                    reverse: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: _filters.categories.length,
                    itemBuilder: (context, index) =>
                        _filterChip(_filters.categories[index], () {
                      setState(() {
                        _filters.categories[index].selected =
                            !_filters.categories[index].selected;
                      });
                    }),
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
        _filterChip(_popularFilters[0], () {
          _filters ??= MealFilter();
          _filters.categories ??= [];
          setState(() {
            if (!_popularFilters[0].selected) {
              _popularFilters[0].selected = true;
              _filters.categories.add(_popularFilters[0]);
            }
          });
        }),
        _filterChip(_popularFilters[1], () {
          _filters ??= MealFilter();
          _filters.categories ??= [];
          setState(() {
            if (!_popularFilters[1].selected) {
              _popularFilters[1].selected = true;
              _filters.categories.add(_popularFilters[1]);
            }
          });
        }),
      ],
    );
  }

  Widget _filterChip(FoodCategories foodCategories, Function onSelect) {
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
