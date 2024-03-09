import 'package:uno/uno.dart';

import 'source_datasource.dart';

class SourceDataSource extends ISourceDataSource {
  final Uno http;
  SourceDataSource(this.http);

  @override
  Future<Map<String, dynamic>> getAll() async {
    final Response response = await http.get('/top-headlines/sources');
    return response.data as Map<String, dynamic>;
  }
}