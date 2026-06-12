
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../utils/constants.dart';

class AuthService {

  Future<String?> login(
      String email,
      String password) async {

    try {

      print("========== LOGIN DEBUG ==========");
      print("Email: ${email.trim()}");
      print("Password: ${password.trim()}");
      print("URL: ${Constants.baseUrl}/api/auth/login");

      final response = await http.post(

        Uri.parse(
          "${Constants.baseUrl}/api/auth/login",
        ),

        headers: {
          "Content-Type": "application/json",
        },

        body: jsonEncode({
          "email": email.trim(),
          "password": password.trim(),
        }),
      );

      print("Status Code: ${response.statusCode}");
      print("Response Body: ${response.body}");
      print("=================================");

      if (response.statusCode == 200) {
        return response.body;
      }

      return null;

    } catch (e) {

      print("Login Error: $e");
      return null;
    }
  }
}