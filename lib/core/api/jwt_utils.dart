
import 'package:jwt_decode/jwt_decode.dart';

class JwtUtils {
  static String extractUserIdFromToken(String token) {
    Map<String, dynamic> payload = Jwt.parseJwt(token);
    return payload['userId']; 
  }

  static String extractRoleFromToken(String token) {
    Map<String, dynamic> payload = Jwt.parseJwt(token);
    return payload['role']; 
  }

  static String extractNameFromToken(String token) {
    Map<String, dynamic> payload = Jwt.parseJwt(token);
    return payload['name']; 
  }

  static String extractOrganizationIdFromToken(String token) {
    Map<String, dynamic> payload = Jwt.parseJwt(token);
    return payload['organizationId'];
  }


}
