import 'package:flutterprojectsetup/models/post.dart';

///
/// This class contains all URL which is being called to fetch data from server
///
class ApiClient {
  static String baseUrl = 'https://jsonplaceholder.typicode.com/';
  final String jsonHeaderName = 'Content-Type';
  final String jsonHeaderValue = 'application/json; charset=UTF-8';
  final int successResponse = 200;

  Map<String, String> getJsonHeader() {
    var header = <String, String>{};
    header[jsonHeaderName] = jsonHeaderValue;
    return header;
  }

  static convertMapToObject<T>(val) {
    if (val is List) {
      final list = <T>[];
      for (var element in val) {
        list.add(getValue<T>(element));
      }
      return list;
    } else {
      return getValue<T>(val);
    }
  }

  static getValue<T>(value) {
    switch (T) {
      case Post:
        return Post.fromJson(value);

      default:
        return value;
    }
  }
}
