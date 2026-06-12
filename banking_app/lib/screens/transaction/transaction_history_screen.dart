
import 'package:flutter/material.dart';

import '../../services/transaction_service.dart';

class TransactionHistoryScreen
    extends StatefulWidget {

  const TransactionHistoryScreen({
    super.key,
  });

  @override
  State<TransactionHistoryScreen>
      createState() =>
          _TransactionHistoryScreenState();
}

class _TransactionHistoryScreenState
    extends State<
        TransactionHistoryScreen> {

  List transactions = [];

  bool isLoading = true;

  final String accountNumber =
      "1781023802024";

  @override
  void initState() {
    super.initState();
    loadTransactions();
  }

  Future<void> loadTransactions()
      async {

    final result =
        await TransactionService()
            .getTransactions(
      accountNumber,
    );

    setState(() {
      transactions = result;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text(
          "Transaction History",
        ),
      ),

      body: isLoading

          ? const Center(
              child:
                  CircularProgressIndicator(),
            )

          : ListView.builder(

              itemCount:
                  transactions.length,

              itemBuilder:
                  (context, index) {

                final tx =
                    transactions[index];

                return Card(

                  margin:
                      const EdgeInsets.all(
                          8),

                  child: ListTile(

                    title: Text(
                      tx[
                          'transactionType'],
                    ),

                    subtitle: Text(
                      tx[
                          'transactionTime'],
                    ),

                    trailing: Text(
                      "₹${tx['amount']}",
                    ),
                  ),
                );
              },
            ),
    );
  }
}