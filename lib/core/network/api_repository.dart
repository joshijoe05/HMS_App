import 'package:http/http.dart' as http;

abstract interface class ApiRepository {
  Future<http.Response> get({required String url, Map<String, dynamic>? body, bool isProtected = true});
  Future<http.Response> post({required String url, Map<String, dynamic>? body, bool isProtected = true});
  Future<http.Response> put({required String url, Map<String, dynamic>? body, bool isProtected = true});
}
