class FilterModel {
  String name;

  // isSelected must be stateful able  to observe the change
  bool isSelected;

  FilterModel({required this.name, required this.isSelected});

  void toggle() {
    isSelected = !isSelected;
  }
}