import 'package:news_app/features/news/data/models/news/source_model.dart';
import 'package:news_app/features/news/domain/repositories/source_repository.dart';


class ChooseSourceUseCase {
  final SourceRepository repository;
  ChooseSourceUseCase(this.repository);

  Future<List<SourceModel>> getAll() async {
    return repository.getAll();
  }
}