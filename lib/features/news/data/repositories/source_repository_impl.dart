import 'dart:convert';

import 'package:news_app/features/news/data/datasources/news/source_datasource.dart';
import 'package:news_app/features/news/data/models/news/source_model.dart';

import '../../domain/repositories/source_repository.dart';

class SourceRepositoryImpl extends SourceRepository {
  final ISourceDataSource dataSource;

  SourceRepositoryImpl(this.dataSource);

  @override
  Future<List<SourceModel>> getAll() async {
     try {
      final Map<String, dynamic> data = await dataSource.getAll();
      var sources = data['sources'];
      List<SourceModel> list = [];
      for (var sourceData in sources) {
         var sourceModel = SourceModel.fromJson(sourceData);
        list.add(sourceModel);
      }
      return list;
    } catch (e) {
      throw Exception('[Sources ERROR]: $e');
    }
  }

}