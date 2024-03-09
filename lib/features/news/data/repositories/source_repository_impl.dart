import 'package:news_app/features/news/data/models/news/source_model.dart';

import '../../domain/repositories/source_repository.dart';
import '../datasources/news/source_datasource_impl.dart';

class SourceRepositoryImpl extends SourceRepository {
  final SourceDataSource dataSource;

  SourceRepositoryImpl(this.dataSource);

  @override
  Future<List<SourceModel>> getAll() async {
     try {
      final List<dynamic> data = await dataSource.getAll();
      return data.map((e) => SourceModel.fromJson(e)).toList();
    } catch (e) {
      throw Exception('[Sources ERROR]: $e');
    }
  }

}