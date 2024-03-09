
import '../entities/source.dart';

abstract class SourceRepository {
  Future<List<Source>> getAll();
}