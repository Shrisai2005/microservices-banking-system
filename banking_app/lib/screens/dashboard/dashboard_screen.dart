import '../account/deposit_screen.dart';
import 'package:flutter/material.dart';
import '../account/withdraw_screen.dart';
import '../account/transfer_screen.dart';
import '../transaction/transaction_history_screen.dart';
import '../../services/account_service.dart';
import '../../storage/local_storage.dart';
import '../auth/login_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() =>
      _DashboardScreenState();
}

class _DashboardScreenState
    extends State<DashboardScreen> {

  double balance = 0;
  bool isLoading = true;

  final String accountNumber =
      "1781023802024";

  @override
  void initState() {
    super.initState();
    loadBalance();
  }

  Future<void> loadBalance() async {

    final accountService =
        AccountService();

    final result =
        await accountService.getBalance(
            accountNumber);

    setState(() {
      balance = result ?? 0;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text(
          "Bank Dashboard",
        ),
      ),

      body: Padding(

        padding: const EdgeInsets.all(20),

        child: Column(

          children: [

            Card(

              elevation: 5,

              child: Padding(

                padding:
                    const EdgeInsets.all(20),

                child: Column(

                  children: [

                    const Text(
                      "Current Balance",
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),

                    const SizedBox(height: 10),

                    isLoading
                        ? const CircularProgressIndicator()
                        : Text(
                            "₹$balance",
                            style:
                                const TextStyle(
                              fontSize: 30,
                              fontWeight:
                                  FontWeight.bold,
                            ),
                          ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 30),

ElevatedButton(
  onPressed: () async {

    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const DepositScreen(),
      ),
    );

    await loadBalance();
  },
  child: const Text("Deposit"),
),

ElevatedButton(
  onPressed: () async {

    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const WithdrawScreen(),
      ),
    );

    await loadBalance();
  },
  child: const Text("Withdraw"),
),

ElevatedButton(
  onPressed: () async {

    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const TransferScreen(),
      ),
    );

    await loadBalance();
  },
  child: const Text("Transfer"),
),

ElevatedButton(
  onPressed: () {

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) =>
            const TransactionHistoryScreen(),
      ),
    );
  },
  child: const Text(
    "Transaction History",
  ),
),
ElevatedButton(
  onPressed: () async {

    await LocalStorage.logout();

    if (!mounted) return;

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (_) => const LoginScreen(),
      ),
      (route) => false,
    );
  },
  child: const Text("Logout"),
),
          ],
        ),
      ),
    );
  }
}
