
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../storage/local_storage.dart';
import '../utils/constants.dart';

class AccountService {

  Future<double?> getBalance(
      String accountNumber) async {

    String? token =
        await LocalStorage.getToken();

    final response = await http.get(

      Uri.parse(
        "${Constants.baseUrl}/api/accounts/balance/$accountNumber",
      ),

      headers: {
        "Authorization": "Bearer $token",
      },
    );

    print(response.statusCode);
    print(response.body);

    if (response.statusCode == 200) {
      return double.parse(response.body);
    }

    return null;
  }

  Future<bool> deposit(
      String accountNumber,
      double amount) async {

    String? token =
        await LocalStorage.getToken();

    final response = await http.post(

      Uri.parse(
        "${Constants.baseUrl}/api/accounts/deposit",
      ),

      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },

      body: jsonEncode({
        "accountNumber": accountNumber,
        "amount": amount,
      }),
    );

    print(response.statusCode);
    print(response.body);

    return response.statusCode == 200;
  }

Future<bool> withdraw(
    String accountNumber,
    double amount) async {

  String? token =
      await LocalStorage.getToken();

  final response = await http.post(

    Uri.parse(
      "${Constants.baseUrl}/api/accounts/withdraw",
    ),

    headers: {
      "Content-Type": "application/json",
      "Authorization": "Bearer $token",
    },

    body: jsonEncode({
      "accountNumber": accountNumber,
      "amount": amount,
    }),
  );

  print(response.statusCode);
  print(response.body);

  return response.statusCode == 200;
}

Future<bool> transfer(
    String fromAccount,
    String toAccount,
    double amount) async {

  String? token =
      await LocalStorage.getToken();

  final response = await http.post(

    Uri.parse(
      "${Constants.baseUrl}/api/accounts/transfer",
    ),

    headers: {
      "Content-Type": "application/json",
      "Authorization": "Bearer $token",
    },

    body: jsonEncode({
      "fromAccount": fromAccount,
      "toAccount": toAccount,
      "amount": amount,
    }),
  );

  print(response.statusCode);
  print(response.body);

  return response.statusCode == 200;
}

}