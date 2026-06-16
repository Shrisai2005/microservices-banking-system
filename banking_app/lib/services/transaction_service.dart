
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../storage/local_storage.dart';
import '../utils/constants.dart';

class TransactionService {

  Future<List<dynamic>> getTransactions(
      String accountNumber) async {

    String? token =
        await LocalStorage.getToken();

    final response = await http.get(

      Uri.parse(
        "${Constants.baseUrl}/api/transactions/$accountNumber",
      ),

      headers: {
        "Authorization": "Bearer $token",
      },
    );

    print(response.statusCode);
    print(response.body);

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }

    return [];
  }

Future<List<dynamic>> getRecentTransactions(
    String accountNumber) async {

  final transactions =
      await getTransactions(
          accountNumber);

  if (transactions.length <= 3) {
    return transactions;
  }

  return transactions
      .reversed
      .take(3)
      .toList();
}
}