import 'dart:convert';
import 'package:news_app/features/news/data/repositories/cache/cache_repository.dart';
import 'package:uno/uno.dart';

import 'source_datasource.dart';

class SourceDataSource extends ISourceDataSource {
  final Uno http;
  final CacheRepository cacheRepository;
  
  SourceDataSource(this.http, this.cacheRepository);

  @override
  Future<Map<String, dynamic>> getAll() async {
    String cachedData = await cacheRepository.getData('source_data_cache') ?? '';
    if (cachedData.isNotEmpty) {
      return json.decode(cachedData) as Map<String, dynamic>;
    } else {
      final Response response = await http.get('/top-headlines/sources');
      final Map<String, dynamic> responseData = response.data as Map<String, dynamic>;
      await cacheRepository.saveData('source_data_cache', json.encode(responseData));
      return responseData;
    }
  }
}
