
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {

  static Future<void> saveToken(
      String token) async {

    final prefs =
        await SharedPreferences.getInstance();

    await prefs.setString(
      "token",
      token,
    );
  }

  static Future<String?> getToken() async {

    final prefs =
        await SharedPreferences.getInstance();

    return prefs.getString("token");
  }

  static Future<void> saveEmail(
      String email) async {

    final prefs =
        await SharedPreferences.getInstance();

    await prefs.setString(
      "email",
      email,
    );
  }

  static Future<String?> getEmail() async {

    final prefs =
        await SharedPreferences.getInstance();

    return prefs.getString("email");
  }

  static Future<void> saveAccountNumber(
      String accountNumber) async {

    final prefs =
        await SharedPreferences.getInstance();

    await prefs.setString(
      "accountNumber",
      accountNumber,
    );
  }

  static Future<String?> getAccountNumber() async {

    final prefs =
        await SharedPreferences.getInstance();

    return prefs.getString(
      "accountNumber",
    );
  }

  static Future<void> logout() async {

    final prefs =
        await SharedPreferences.getInstance();

    await prefs.clear();
  }
}