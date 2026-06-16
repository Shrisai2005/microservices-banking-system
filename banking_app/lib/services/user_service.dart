import 'dart:convert';
import 'package:http/http.dart' as http;
import '../utils/constants.dart';

class UserService {

  Future<Map<String, dynamic>?> getProfile(
    String email) async {

  final url =
      "${Constants.baseUrl}/api/auth/profile/$email";

  print("PROFILE URL = $url");

  final response = await http.get(
    Uri.parse(url),
  );

  print("PROFILE STATUS = ${response.statusCode}");
  print("PROFILE BODY = ${response.body}");

  if (response.statusCode == 200) {
    return jsonDecode(response.body);
  }

  return null;
}
}