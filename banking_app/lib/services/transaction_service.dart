
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
}