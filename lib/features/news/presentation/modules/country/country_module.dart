import 'package:flutter_modular/flutter_modular.dart';
import 'package:news_app/features/news/data/datasources/country/country_datasource.dart';
import 'package:news_app/features/news/data/repositories/country/country_repository_impl.dart';
import 'package:news_app/features/news/domain/repositories/country_repository.dart';
import 'package:news_app/features/news/infra/factory/uno_factory.dart';
import 'package:news_app/features/news/presentation/modules/country/choose_country/choose_country_controller.dart';
import 'package:news_app/features/news/presentation/modules/country/choose_country/choose_country_page.dart';
import 'package:news_app/features/news/usecases/sources/choose_country.dart';
import 'package:uno/uno.dart';

class CountryModule extends Module {
  @override
  void binds(i) async {
    i.add<Uno>(unoFactory);
    i.addSingleton(CountryDataSource.new);
    i.addSingleton<CountryRepository>(CountryRepositoryImpl.new);
    i.addSingleton(ChooseCountryUseCase.new);
    i.addSingleton(ChooseCountryController.new);
  }

  @override
  void routes(r) {
    r.child('/', child: (_) => const ChooseYourCountryPage());
  }
}