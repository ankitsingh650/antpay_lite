
import 'dart:convert';

class AuthToken{
  static String getAuthToken() {
    const String username = 'antApp_2023';
    const String password = 'Ant_Secure&@1!65';

    String auth = '$username:$password';
    String encodedAuth = base64Encode(utf8.encode(auth));

    return 'Basic $encodedAuth';
  }
}