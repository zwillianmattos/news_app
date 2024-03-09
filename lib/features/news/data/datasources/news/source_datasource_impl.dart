import 'package:uno/uno.dart';

import 'source_datasource.dart';

class SourceDataSource extends ISourceDataSource {
  final Uno http;
  SourceDataSource(this.http);

  @override
  Future<List<dynamic>> getAll() async {
    final Response response = await http.get('/top-headlines/sources');
    return response.data as List<dynamic>;
  }
}