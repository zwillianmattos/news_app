class CountryModel {
  String code;
  String name;
  bool isChecked;

  CountryModel({
    required this.code,
    required this.name,
    this.isChecked = false,
  });
}
