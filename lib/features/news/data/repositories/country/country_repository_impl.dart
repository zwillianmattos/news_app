import 'package:news_app/features/news/data/datasources/country/country_datasource.dart';
import 'package:news_app/features/news/data/models/country/country_model.dart';
import 'package:news_app/features/news/domain/repositories/country_repository.dart';

class CountryRepositoryImpl extends CountryRepository {
  final CountryDataSource dataSource;

  CountryRepositoryImpl(this.dataSource);

  @override
  List<CountryModel> getAll() {
    try {
      return dataSource.getAll();
    } catch (e) {
      throw Exception('[Sources ERROR]: $e');
    }
  }
}
