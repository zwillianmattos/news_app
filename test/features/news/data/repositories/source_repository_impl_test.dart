import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:news_app/features/news/data/datasources/news/source_datasource_impl.dart';
import 'package:news_app/features/news/data/models/news/source_model.dart';
import 'package:news_app/features/news/data/repositories/source_repository_impl.dart';
import 'package:news_app/features/news/domain/entities/source.dart';
import 'package:uno/uno.dart';

class SourceDataSourceMock extends Mock implements SourceDataSource {}
class UnoMock extends Mock implements Uno {}

void main() {
  group('SourceRepositoryImpl', () {
    test('getAll should return a list of sources', () async {
      // Arrange
      final sourceDataSource = SourceDataSourceMock();
      final repository = SourceRepositoryImpl(sourceDataSource);
      // Configurando o mock para simular a resposta do dataSource
      when(() => sourceDataSource.getAll()).thenAnswer(
        (_) async => sourcesMock,
      );
      // Act
      final result = await repository.getAll();
      // Assert
      expect(result, isA<List<SourceModel>>());
      expect(result.length, equals(1)); 
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
