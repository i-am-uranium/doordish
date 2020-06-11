class DistanceRange {
  DistanceRange({
    this.min,
    this.max,
    this.unit,
    this.selected = false,
  });
  final int min;
  final int max;
  final String unit;
  bool selected;

  static List<DistanceRange> get list {
    return [
      DistanceRange(min: 1, max: 3, unit: 'km'),
      DistanceRange(min: 3, max: 6, unit: 'km'),
      DistanceRange(min: 6, max: 9, unit: 'km'),
      DistanceRange(min: 9, max: 12, unit: 'km'),
    ];
  }
}
