import 'package:jwt_decoder/jwt_decoder.dart';

class JwtHelper {
  static bool isTokenExpired(String token) {
    return JwtDecoder.isExpired(token);
  }

  static DateTime? getExpirationDate(String token) {
    return JwtDecoder.getExpirationDate(token);
  }
}
