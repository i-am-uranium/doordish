import 'distance_range.dart';
import 'food_categories.dart';

class MealFilter {
  MealFilter({
    this.categories,
    this.distanceRange,
    this.minPrice,
    this.maxPrice,
  });

  List<FoodCategories> categories;
  DistanceRange distanceRange;
  int minPrice;
  int maxPrice;
}
