import 'dart:convert';
// ignore: library_prefixes
import 'package:html/parser.dart' as htmlParser;
import 'package:http/http.dart' as http;

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
        final appleTouchIconTag = document.querySelector('link[rel="apple-touch-icon"]');
        if (appleTouchIconTag != null) {
          final faviconUrl = appleTouchIconTag.attributes['href'];
          if (faviconUrl != null && faviconUrl.isNotEmpty) {
            final resolvedFaviconUrl =
                !faviconUrl.startsWith('http') ? Uri.parse(url).resolve(faviconUrl).toString() : faviconUrl;
            _faviconCache[url] = resolvedFaviconUrl;
            return resolvedFaviconUrl;
          }
        }
        final faviconTags = document.querySelectorAll('link[rel*="icon"]');
        if (faviconTags.isNotEmpty) {
          for (var tag in faviconTags) {
            final faviconUrl = tag.attributes['href'];
            if (faviconUrl != null && faviconUrl.isNotEmpty) {
              final resolvedFaviconUrl = !faviconUrl.startsWith('http')
                  ? Uri.parse(url).resolve(faviconUrl).toString()
                  : faviconUrl;
              _faviconCache[url] = resolvedFaviconUrl;
              return resolvedFaviconUrl;
            }
          }
        }
        final directFaviconTag = document.querySelector('link[href\$=".ico"]');
        if (directFaviconTag != null) {
          final faviconUrl = directFaviconTag.attributes['href'];
          if (faviconUrl != null && faviconUrl.isNotEmpty) {
            final resolvedFaviconUrl = !faviconUrl.startsWith('http')
                ? Uri.parse(url).resolve(faviconUrl).toString()
                : faviconUrl;
            _faviconCache[url] = resolvedFaviconUrl;
            return resolvedFaviconUrl;
          }
        }
        final metaFaviconTag =
            document.querySelector('meta[property="og:image"]');
        if (metaFaviconTag != null) {
          final faviconUrl = metaFaviconTag.attributes['content'];
          if (faviconUrl != null && faviconUrl.isNotEmpty) {
            final resolvedFaviconUrl = !faviconUrl.startsWith('http')
                ? Uri.parse(url).resolve(faviconUrl).toString()
                : faviconUrl;
            _faviconCache[url] = resolvedFaviconUrl;
            return resolvedFaviconUrl;
          }
        }
      }
    } catch (e) {
      print('[FAV GRAB ERROR]: $e');
    }
    return null;
  }
}
