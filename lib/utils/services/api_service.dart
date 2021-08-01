import 'package:http/http.dart' as http;

class ApiSerivce {
  Map<String, String>? _headers = {};

  Future<http.Response> get(String endpoint) {
    return http.get(Uri.parse(endpoint), headers: _headers);
  }

  Future<http.Response> post(String endpoint, Object? body) {
    return http.post(Uri.parse(endpoint), headers: _headers, body: body);
  }
}
