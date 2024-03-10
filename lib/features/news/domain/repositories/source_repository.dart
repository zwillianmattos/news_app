
import 'package:news_app/features/news/data/models/news/source_model.dart';


abstract class SourceRepository {
  Future<List<SourceModel>> getAll();
}