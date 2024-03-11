
import 'package:news_app/features/news/data/models/country/country_model.dart';

abstract class CountryRepository {
  List<CountryModel> getAll();
}