import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../../constants/app_colors.dart';
import '../../model/meal.dart';
import '../../model/meal_filter.dart';
import '../../utils/logger.dart';
import '../common/horizontal_spacer.dart';
import '../common/vertical_spacer.dart';
import 'load_more_button.dart';
import 'meal_filters.dart';
import 'meal_menu_item.dart';
import 'search_bar.dart';

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

class _MealMenuWidgetState extends State<MealMenuWidget>
    with SingleTickerProviderStateMixin {
  List<Meal> meals = [];
  MealFilter filters;
  bool _showLoadMoreButton = false;

  final _scrollController = ScrollController();
  final _scrollThreshold = 500.0;

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    if (maxScroll - currentScroll <= _scrollThreshold) {
      logger.i('max scroll reached fetch more meals');
      if (!_showLoadMoreButton) {
        setState(() {
          _showLoadMoreButton = true;
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    meals = Meal.list;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SearchBar(
          onSearchTextChange: (value) {
            logger.i('Search text is: $value');
          },
          onFilterApply: (value) {
            setState(() => filters = value);
            logger.i('On filter apply: ${value.minPrice}');
          },
        ),
        const VerticalSpacer(),
        MealFilters(filters: filters),
        const VerticalSpacer(),
        Row(
          children: [
            Padding(
              padding: EdgeInsets.only(left: 8),
              child: Row(
                children: [
                  Text(
                    '345',
                    style: TextStyle(
                      fontSize: 14,
                    ),
                  ),
                  HorizontalSpacer(),
                  Text(
                    'Meals found',
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColors.secondaryText,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const VerticalSpacer(),
        Expanded(
          child: GridView.builder(
            controller: _scrollController,
            shrinkWrap: true,
            itemCount: meals.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              childAspectRatio: 22 / 21,
              crossAxisCount: 3,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
            ),
            itemBuilder: (context, index) => MealMenuItem(
              meal: meals[index],
              onLikeClick: (liked) =>
                  setState(() => meals[index].liked = liked),
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
          child: const LoadMoreButton(),
        ),
        const VerticalSpacer(space: 16),
      ],
    );
  }
}
