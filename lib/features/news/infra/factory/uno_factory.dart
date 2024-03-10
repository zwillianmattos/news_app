import "package:uno/uno.dart";

Uno unoFactory() {
  return Uno(
    baseURL: "https://newsapi.org/v2",
    headers: {
      'X-Api-Key': '2eb849c122b546d3929678e27a902aa6'
    }
  );
}
