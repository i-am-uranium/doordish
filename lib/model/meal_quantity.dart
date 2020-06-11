enum MealQuantityType { gm, kg, ml, ltr }

class MealQuantity {
  MealQuantity({this.value, this.type});

  final int value;
  final MealQuantityType type;
}
