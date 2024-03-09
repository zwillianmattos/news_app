import "package:uno/uno.dart";

Uno unoFactory() {
  return Uno(
    baseURL: "https://newsapi.org/v2/",
    timeout: const Duration(seconds: 10),
    headers: {
      'X-Api-Key': ''
    }
  );
}
