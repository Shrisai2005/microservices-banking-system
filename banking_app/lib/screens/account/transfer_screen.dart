import 'package:flutter/material.dart';
import '../../services/account_service.dart';
import '../../storage/local_storage.dart';

class TransferScreen extends StatefulWidget {
  const TransferScreen({super.key});

  @override
  State<TransferScreen> createState() =>
      _TransferScreenState();
}

class _TransferScreenState
    extends State<TransferScreen> {

  final toAccountController =
      TextEditingController();

  final amountController =
      TextEditingController();

  
  String fromAccount = "";

  bool isLoading = false;


Future<void> transferMoney() async {

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

  fromAccount = account;

  setState(() {
    isLoading = true;
  });

  bool success =
      await AccountService().transfer(

    fromAccount,

    toAccountController.text.trim(),

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
          "Transfer Successful",
        ),
      ),
    );

    Navigator.pop(context);

  } else {

    ScaffoldMessenger.of(context)
        .showSnackBar(
      const SnackBar(
        content: Text(
          "Transfer Failed",
        ),
      ),
    );
  }
}


  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text("Transfer"),
      ),

      body: Padding(

        padding: const EdgeInsets.all(20),

        child: Column(

          children: [

            TextField(
              controller:
                  toAccountController,
              decoration:
                  const InputDecoration(
                labelText:
                    "Receiver Account Number",
                border:
                    OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20),

            TextField(
              controller:
                  amountController,
              keyboardType:
                  TextInputType.number,
              decoration:
                  const InputDecoration(
                labelText:
                    "Amount",
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
                        : transferMoney,

                child: isLoading
                    ? const CircularProgressIndicator()
                    : const Text(
                        "Transfer",
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}