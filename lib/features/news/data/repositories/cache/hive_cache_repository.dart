import 'package:hive/hive.dart';
import 'package:news_app/features/news/data/repositories/cache/cache_repository.dart';

class HiveCacheRepository implements CacheRepository {
  @override
  Future<void> saveData(String key, String data) async {
    final box = await Hive.openBox<String>('source_data_cache');
    await box.put(key, data);
    await box.close();
  }

  @override
  Future<String?> getData(String key) async {
    final box = await Hive.openBox<String>('source_data_cache');
    final String? data = box.get(key);
    await box.close();
    return data;
  }
}