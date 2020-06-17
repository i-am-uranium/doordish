import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../../model/meal.dart';
import '../../model/meal_filter.dart';
import '../../model/meal_filter_categories.dart';
import '../../model/meal_sorting.dart';
import '../../utils/logger.dart';
import '../common/vertical_spacer.dart';
import '../filter/my_filters.dart';
import '../search/search_bar.dart';
import 'load_more_button.dart';
import 'meal_menu_item.dart';
import 'meals_grid_section.dart';

class MealMenuWidget extends StatefulWidget {
  const MealMenuWidget({
    Key key,
    this.onDragStarted,
    this.onDragEnd,
    this.onDragComplete,
  }) : super(key: key);

  final Function onDragStarted;
  final Function onDragEnd;
  final Function onDragComplete;

  @override
  _MealMenuWidgetState createState() => _MealMenuWidgetState();
}

class _MealMenuWidgetState extends State<MealMenuWidget> {
  List<Meal> _meals = [];
  MealFilter _filters;
  bool _showLoadMoreButton = false;
  final List<MealFilterCategory> _appliedCategories = [];
  final ScrollController _scrollController = ScrollController();
  final double _scrollThreshold = 500;
  MealSorting _mealsSortedBy = MealSorting.popularity;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _meals = Meal.list;
    _sortMeals(_mealsSortedBy);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SearchBar(
          onSearchTextChange: (value) {
            logger.i('Search text is: $value');
          },
          onFilterApply: _applyFilter,
          initialFilter: _filters,
        ),
        const VerticalSpacer(),
        MyFilters(
          categories: _appliedCategories,
          onPopularCategorySelect: _addPopularCategory,
          onRemoveCategoryClick: _removeAppliedCategories,
        ),
        const VerticalSpacer(),
        Padding(
          padding: const EdgeInsets.only(left: 8, right: 8),
          child: MealsGridSection(
            mealsCount: _meals.length,
            onMealSortingChange: (sortBy) {
              _sortMeals(sortBy);
              setState(() => _mealsSortedBy = sortBy);
            },
            sortedBy: _mealsSortedBy,
          ),
        ),
        const VerticalSpacer(),
        Expanded(
          child: GridView.builder(
            controller: _scrollController,
            shrinkWrap: true,
            itemCount: _meals.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              childAspectRatio: 219 / 201,
              crossAxisCount: 3,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
            ),
            itemBuilder: (context, index) => MealMenuItem(
              meal: _meals[index],
              onLikeClick: (liked) =>
                  setState(() => _meals[index].liked = liked),
              onSelect: () {
                logger.d('Meal selected: $index');
              },
              onDragEnd: widget.onDragEnd,
              onDragComplete: widget.onDragComplete,
              onDragStarted: widget.onDragStarted,
            ),
          ),
        ),
        AnimatedOpacity(
          opacity: _showLoadMoreButton ? 1.0 : 0.0,
          duration: const Duration(milliseconds: 500),
          child: Column(
            children: const [
              LoadMoreButton(),
              VerticalSpacer(space: 16),
            ],
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _sortMeals(MealSorting sortBy) {
    switch (sortBy) {
      case MealSorting.priceAsc:
        _meals.sort((curr, next) {
          return curr.price.compareTo(next.price);
        });
        break;
      case MealSorting.priceDesc:
        _meals.sort((curr, next) {
          return next.price.compareTo(curr.price);
        });
        break;
      case MealSorting.rating:
        _meals.sort((curr, next) {
          return next.rating.compareTo(curr.rating);
        });
        break;
      case MealSorting.popularity:
        _meals.shuffle();
        break;
    }
  }

  void _applyFilter(MealFilter appliedFilter) {
    if (appliedFilter != null && appliedFilter.categories.isNotEmpty) {
      setState(() {
        _filters = appliedFilter;
        _appliedCategories.addAll(
          appliedFilter.categories.where((element) => element.selected),
        );
        _updateMeals(_appliedCategories);
      });
    }
  }

  void _addPopularCategory(MealFilterCategory value) {
    setState(() {
      final MealFilterCategory alreadyAddedCategory = _appliedCategories
          .firstWhere((element) => element == value, orElse: () => null);
      if (alreadyAddedCategory == null) {
        _appliedCategories.add(value);
      }
      _updateMeals(_appliedCategories);
    });
  }

  void _removeAppliedCategories(MealFilterCategory value) {
    setState(() {
      _appliedCategories.removeWhere((element) => element == value);
      if (_filters != null && _filters.categories != null) {
        final int index = _filters.categories.indexOf(value);
        if (index > 0) {
          _filters.categories.elementAt(index).selected =
              !_filters.categories.elementAt(index).selected;
        }
      }
      _updateMeals(_appliedCategories);
    });
  }

  void _updateMeals(List<MealFilterCategory> categories) {
    if (categories.isEmpty) {
      _meals = Meal.list;
      return;
    }
    final List<Meal> filteredMeals = [];
    for (final Meal meal in _meals) {
      final categoryExist = meal.categories.any((mealCategory) =>
          categories.any((element) => mealCategory == element.category));
      if (categoryExist) {
        filteredMeals.add(meal);
      }
    }
    _meals = filteredMeals;
  }

  void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    if (maxScroll - currentScroll <= _scrollThreshold) {
      if (!_showLoadMoreButton) {
        setState(() {
          _showLoadMoreButton = true;
        });
      }
    }
    if (maxScroll > currentScroll) {
      setState(() {
        _showLoadMoreButton = false;
      });
    }
  }
}
