import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:news_app/features/news/data/datasources/news/source_datasource_impl.dart';
import 'package:uno/uno.dart';

class UnoMock extends Mock implements Uno {}

class ResponseMock extends Mock implements Response {}

void main() {
  group('SourceDataSource', () {
    test('getAll should return a map response', () async {
      // Arrange
      final uno = UnoMock();
      final response = ResponseMock();
      final sourceDataSource = SourceDataSource(uno);
      when(() => response.data).thenReturn(sourcesMock);
      when(() => uno.get('/top-headlines/sources')).thenAnswer(
        (_) async => response,
      );
      // Act
      final result = await sourceDataSource.getAll();
      // Assert
      expect(result, isA<Map<String, dynamic>>());
    });
  });
}

final sourcesMock = jsonDecode("""
{
"status": "ok",
"sources": [
{
"id": "abc-news",
"name": "ABC News",
"description": "Your trusted source for breaking news, analysis, exclusive interviews, headlines, and videos at ABCNews.com.",
"url": "https://abcnews.go.com",
"category": "general",
"language": "en",
"country": "us"
}
]
}
""");
