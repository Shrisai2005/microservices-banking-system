
import 'package:flutter/material.dart';
import '../../services/account_service.dart';
import '../../storage/local_storage.dart';
class WithdrawScreen extends StatefulWidget {
  const WithdrawScreen({super.key});

  @override
  State<WithdrawScreen> createState() =>
      _WithdrawScreenState();
}

class _WithdrawScreenState
    extends State<WithdrawScreen> {

  final amountController =
      TextEditingController();


  String accountNumber = "";

  bool isLoading = false;

Future<void> withdrawMoney() async {

  final account =
      await LocalStorage
          .getAccountNumber();

  if (account == null) {

    ScaffoldMessenger.of(context)
        .showSnackBar(
      const SnackBar(
        content: Text(
          "Account not found",
        ),
      ),
    );

    return;
  }

  accountNumber = account;

  setState(() {
    isLoading = true;
  });

  bool success =
      await AccountService().withdraw(

    accountNumber,

    double.parse(
      amountController.text,
    ),
  );

  setState(() {
    isLoading = false;
  });

  if (success) {

    if (!mounted) return;

    ScaffoldMessenger.of(context)
        .showSnackBar(
      const SnackBar(
        content: Text(
          "Withdrawal Successful",
        ),
      ),
    );

    Navigator.pop(context);

  } else {

    ScaffoldMessenger.of(context)
        .showSnackBar(
      const SnackBar(
        content: Text(
          "Withdrawal Failed",
        ),
      ),
    );
  }
}

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text("Withdraw"),
      ),

      body: Padding(

        padding: const EdgeInsets.all(20),

        child: Column(

          children: [

            TextField(
              controller: amountController,
              keyboardType:
                  TextInputType.number,
              decoration:
                  const InputDecoration(
                labelText:
                    "Enter Amount",
                border:
                    OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20),

            SizedBox(
              width: double.infinity,

              child: ElevatedButton(

                onPressed:
                    isLoading
                        ? null
                        : withdrawMoney,

                child: isLoading
                    ? const CircularProgressIndicator()
                    : const Text(
                        "Withdraw",
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}