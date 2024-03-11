
import 'package:flutter_modular/flutter_modular.dart';
import 'package:news_app/features/news/data/datasources/news/source_datasource.dart';
import 'package:news_app/features/news/data/datasources/news/source_datasource_impl.dart';
import 'package:news_app/features/news/data/repositories/cache/cache_repository.dart';
import 'package:news_app/features/news/data/repositories/cache/hive_cache_repository.dart';
import 'package:news_app/features/news/data/repositories/source_repository_impl.dart';
import 'package:news_app/features/news/domain/repositories/source_repository.dart';
import 'package:news_app/features/news/infra/factory/uno_factory.dart';
import 'package:news_app/features/news/presentation/modules/sources/choose_source/choose_source_page.dart';
import 'package:news_app/features/news/presentation/modules/sources/choose_source/choose_source_controller.dart';
import 'package:news_app/features/news/usecases/sources/choose_source.dart';
import 'package:uno/uno.dart';

class SourceModule extends Module {
  @override
  void binds(i) async {
    i.add<Uno>(unoFactory);
    i.addSingleton<CacheRepository>(HiveCacheRepository.new);
    i.addSingleton<ISourceDataSource>(SourceDataSource.new);
    i.addSingleton<SourceRepository>(SourceRepositoryImpl.new);
    i.addSingleton(ChooseSourceUseCase.new);
    i.addSingleton(ChooseSourcesController.new);
  }

  @override
  void routes(r) {
    r.child('/', child: (_) => const ChooseSourcesPage());
  }
}