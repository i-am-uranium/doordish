import '../constants/assets.dart';

class FoodCategories {
  FoodCategories({
    this.name,
    this.selected,
    this.icon,
  });

  final String name;
  final String icon;
  bool selected;

  static List<FoodCategories> get list {
    return [
      FoodCategories(
        name: 'All',
        selected: false,
      ),
      FoodCategories(
        name: 'Sushi',
        selected: false,
        icon: Assets.sushiRool,
      ),
      FoodCategories(
        name: 'Fast Food',
        selected: false,
        icon: Assets.frenchFries,
      ),
      FoodCategories(
        name: 'Burgers',
        selected: false,
        icon: Assets.burger,
      ),
      FoodCategories(
        name: 'Pizza',
        selected: false,
        icon: Assets.burger,
      ),
      FoodCategories(
        name: 'Coffee',
        selected: false,
        icon: Assets.coffee,
      ),
      FoodCategories(
        name: 'Deserts',
        selected: false,
        icon: Assets.donuts,
      ),
      FoodCategories(
        name: 'Breakfast',
        selected: false,
        icon: Assets.bread_1,
      ),
      FoodCategories(
        name: 'Soup',
        selected: false,
        icon: Assets.bowl,
      ),
      FoodCategories(
        name: 'Vegan',
        selected: false,
        icon: Assets.kiwi,
      ),
      FoodCategories(
        name: 'Dinner',
        selected: false,
        icon: Assets.cooking,
      ),
      FoodCategories(
        name: 'Healthy',
        selected: false,
        icon: Assets.chickenThigh,
      ),
    ];
  }
}
