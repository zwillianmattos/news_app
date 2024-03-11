import 'package:news_app/features/news/data/models/country/country_model.dart';
import 'package:news_app/features/news/domain/repositories/country_repository.dart';


class ChooseCountryUseCase {
  final CountryRepository repository;
  ChooseCountryUseCase(this.repository);

  Future<List<CountryModel>> getAll() async {
    return repository.getAll();
  }
}