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

    if (response.statusCode == 200) {
      return double.parse(response.body);
    }

    return null;
  }
}