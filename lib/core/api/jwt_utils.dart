
import 'package:jwt_decode/jwt_decode.dart';

class JwtUtils {
  static String extractUserIdFromToken(String token) {
    Map<String, dynamic> payload = Jwt.parseJwt(token);
    return payload['userId']; // Предполагается, что userId хранится в токене
  }

  static String extractRoleFromToken(String token) {
    Map<String, dynamic> payload = Jwt.parseJwt(token);
    return payload['role']; // Предполагается, что роль хранится в токене
  }

  static String extractNameFromToken(String token) {
    Map<String, dynamic> payload = Jwt.parseJwt(token);
    return payload['name']; // Предполагается, что имя хранится в токене
  }

  static String extractOrganizationIdFromToken(String token) {
    Map<String, dynamic> payload = Jwt.parseJwt(token);
    return payload['organizationId']; // Предполагается, что ID организации хранится в токене
  }


}
