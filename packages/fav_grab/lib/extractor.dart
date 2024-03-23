import 'dart:convert';
import 'dart:io';
// ignore: library_prefixes
import 'package:html/parser.dart' as htmlParser;
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class FaviconExtractor {
  static final Map<String, String?> _faviconCache = {};

  static Future<String?> getFaviconUrl(String url) async {
    try {
      if (_faviconCache.containsKey(url)) {
        return _faviconCache[url];
      }

      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final document = htmlParser.parse(utf8.decode(response.bodyBytes));
        final appleTouchIconTag =
            document.querySelector('link[rel="apple-touch-icon"]');
        if (appleTouchIconTag != null) {
          final faviconUrl = appleTouchIconTag.attributes['href'];
          if (faviconUrl != null &&
              faviconUrl.isNotEmpty &&
              !_isSvg(faviconUrl) &&
              _isValidImage(faviconUrl)) {
            final resolvedFaviconUrl = _resolveUrl(url, faviconUrl);
            if (await _isValidUrl(resolvedFaviconUrl)) {
              _faviconCache[url] = resolvedFaviconUrl;
              return resolvedFaviconUrl;
            }
          }
        }

        final faviconTags = document.querySelectorAll('link[rel*="icon"]');
        if (faviconTags.isNotEmpty) {
          for (var tag in faviconTags) {
            final faviconUrl = tag.attributes['href'];
            if (faviconUrl != null &&
                faviconUrl.isNotEmpty &&
                !_isSvg(faviconUrl) &&
                _isValidImage(faviconUrl)) {
              final resolvedFaviconUrl = _resolveUrl(url, faviconUrl);
              if (await _isValidUrl(resolvedFaviconUrl)) {
                _faviconCache[url] = resolvedFaviconUrl;
                return resolvedFaviconUrl;
              }
            }
          }
        }

        final directFaviconTag = document.querySelector('link[href\$=".ico"]');
        if (directFaviconTag != null) {
          final faviconUrl = directFaviconTag.attributes['href'];
          if (faviconUrl != null &&
              faviconUrl.isNotEmpty &&
              !_isSvg(faviconUrl) &&
              _isValidImage(faviconUrl)) {
            final resolvedFaviconUrl = _resolveUrl(url, faviconUrl);
            if (await _isValidUrl(resolvedFaviconUrl)) {
              _faviconCache[url] = resolvedFaviconUrl;
              return resolvedFaviconUrl;
            }
          }
        }

        final metaFaviconTag =
            document.querySelector('meta[property="og:image"]');
        if (metaFaviconTag != null) {
          final faviconUrl = metaFaviconTag.attributes['content'];
          if (faviconUrl != null &&
              faviconUrl.isNotEmpty &&
              !_isSvg(faviconUrl) &&
              _isValidImage(faviconUrl)) {
            final resolvedFaviconUrl = _resolveUrl(url, faviconUrl);
            _faviconCache[url] = resolvedFaviconUrl;

            if (await _isValidUrl(resolvedFaviconUrl)) {
              _faviconCache[url] = resolvedFaviconUrl;
              return resolvedFaviconUrl;
            }
          }
        }
      }
    } catch (e) {
      print('[FAV GRAB ERROR]: $e');
      return null;
    }
  }

  static bool _isSvg(String url) {
    return url.toLowerCase().endsWith('.svg');
  }

  static bool _isValidImage(String url) {
    return url.toLowerCase().endsWith('.png') ||
        url.toLowerCase().endsWith('.jpg') ||
        url.toLowerCase().endsWith('.ico');
  }

  static String _resolveUrl(String baseUrl, String faviconUrl) {
    return !faviconUrl.startsWith('http')
        ? Uri.parse(baseUrl).resolve(faviconUrl).toString()
        : faviconUrl;
  }

  static Future<bool> _isValidUrl(String url) async {
    try {
      final response = await http.head(Uri.parse(url));
      return response.statusCode == 200;
    } catch (e) {
      return false;
    }
  }
}
