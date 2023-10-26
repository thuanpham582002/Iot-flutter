class FilterModel {
  String name;

  // isSelected must be stateful able  to observe the change
  bool isSelected;
  Function()? onSelected;

  FilterModel(
      {required this.name, required this.isSelected, required this.onSelected});

  void toggle() {
    isSelected = !isSelected;
    onSelected?.call();
  }
}
