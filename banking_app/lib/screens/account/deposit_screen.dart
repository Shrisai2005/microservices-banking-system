
import 'package:flutter/material.dart';
import '../../services/account_service.dart';
import '../../storage/local_storage.dart';
class DepositScreen extends StatefulWidget {
  const DepositScreen({super.key});

  @override
  State<DepositScreen> createState() =>
      _DepositScreenState();
}

class _DepositScreenState
    extends State<DepositScreen> {

  final amountController =
      TextEditingController();

  String accountNumber = "";

  bool isLoading = false;


Future<void> depositMoney() async {

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
      await AccountService().deposit(

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
          "Deposit Successful",
        ),
      ),
    );

    Navigator.pop(context);

  } else {

    ScaffoldMessenger.of(context)
        .showSnackBar(
      const SnackBar(
        content: Text(
          "Deposit Failed",
        ),
      ),
    );
  }
}

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text("Deposit"),
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
                        : depositMoney,

                child: isLoading
                    ? const CircularProgressIndicator()
                    : const Text(
                        "Deposit",
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}