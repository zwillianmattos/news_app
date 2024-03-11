class CountryModel {
  final String code;
  final String name;
  final bool isChecked;

  CountryModel({
    required this.code,
    required this.name,
    this.isChecked = false,
  });
}
