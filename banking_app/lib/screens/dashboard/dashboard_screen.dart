import 'package:flutter/material.dart';

import '../account/deposit_screen.dart';
import '../account/withdraw_screen.dart';
import '../account/transfer_screen.dart';
import '../transaction/transaction_history_screen.dart';
import '../../services/account_service.dart';
import '../../storage/local_storage.dart';
import '../auth/login_screen.dart';
import '../../widgets/action_card.dart';
import '../../services/transaction_service.dart';
import '../profile/profile_screen.dart';
import '../../utils/page_transition.dart';
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

  String accountNumber = "";
  List<dynamic> recentTransactions = [];

  String get greeting {

    final hour = DateTime.now().hour;

    if (hour < 12) {
      return "Good Morning ☀️";
    }

    if (hour < 17) {
      return "Good Afternoon 🌤";
    }

    return "Good Evening 🌙";
  }

  @override
  void initState() {
    super.initState();
    loadBalance();
  }

  Future<void> loadBalance() async {

    final email =
        await LocalStorage.getEmail();

    if (email == null) return;

    final accountService =
        AccountService();

    final account =
        await accountService
            .getAccountNumberByEmail(
                email);

    if (account == null) return;

    accountNumber = account;

    await LocalStorage
        .saveAccountNumber(
            accountNumber);

    final result =
        await accountService
            .getBalance(
                accountNumber);
    final transactions =
    await TransactionService()
        .getRecentTransactions(
            accountNumber);
    setState(() {
      balance = result ?? 0;
       recentTransactions =
      transactions;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        title: const Text(
          "My Bank",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
actions: [

  Padding(

    padding:
        const EdgeInsets.only(
            right: 20),

    child: GestureDetector(

      onTap: () {

        Navigator.push(
  context,
  FadePageRoute(
    page:
        const ProfileScreen(),
  ),
);
      },

      child: const CircleAvatar(

        backgroundColor:
            Color(0xFF1565C0),

        child: Icon(
          Icons.person,
          color: Colors.white,
        ),
      ),
    ),
  ),
],
      ),

      body: AnimatedOpacity(
  duration: const Duration(
      milliseconds: 800),
  opacity: 1,

  child: SingleChildScrollView(

        child: Padding(

          padding:
              const EdgeInsets.all(20),

          child: Column(

            crossAxisAlignment:
                CrossAxisAlignment.start,

            children: [

              const SizedBox(height: 25),

              Row(

                children: [

                  const CircleAvatar(
                    radius: 28,
                    backgroundColor:
                        Color(0xFF1565C0),
                    child: Icon(
                      Icons.person,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),

                  const SizedBox(width: 15),

                  Expanded(

                    child: Column(

                      crossAxisAlignment:
                          CrossAxisAlignment
                              .start,

                      children: [

                         Text(
                          greeting,
                          style: const TextStyle(
                            fontSize: 28,
                            fontWeight:
                                FontWeight
                                    .bold,
                          ),
                        ),

                        Text(
                          "Account: ••••${accountNumber.length >= 4 ? accountNumber.substring(accountNumber.length - 4) : accountNumber}",
                          style:
                              const TextStyle(
                            color:
                                Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 10),

              Text(
                "Account Number: $accountNumber",
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 15,
                ),
              ),

              const SizedBox(height: 25),

              Container(

                width: double.infinity,

                padding:
                    const EdgeInsets.all(
                        25),

                decoration: BoxDecoration(

                  gradient:
                      const LinearGradient(
                    begin:
                        Alignment.topLeft,
                    end:
                        Alignment
                            .bottomRight,
                    colors: [
                      Color(0xFF1565C0),
                      Color(0xFF42A5F5),
                    ],
                  ),

                  borderRadius:
                      BorderRadius.circular(
                          25),

                  boxShadow: const [

                    BoxShadow(
                      color:
                          Colors.black26,
                      blurRadius: 15,
                      offset:
                          Offset(0, 5),
                    ),
                  ],
                ),

                child: Column(

                  crossAxisAlignment:
                      CrossAxisAlignment
                          .start,

                  children: [

                    const Text(
                      "Available Balance",
                      style: TextStyle(
                        color:
                            Colors.white,
                        fontSize: 18,
                      ),
                    ),

                    const SizedBox(
                        height: 15),

                    isLoading

                        ? const CircularProgressIndicator(
                            color:
                                Colors.white,
                          )

                        : Column(

                            crossAxisAlignment:
                                CrossAxisAlignment
                                    .start,

                            children: [

                              Text(
                                "₹${balance.toStringAsFixed(2)}",
                                style:
                                    const TextStyle(
                                  color:
                                      Colors.white,
                                  fontSize:
                                      38,
                                  fontWeight:
                                      FontWeight
                                          .bold,
                                ),
                              ),

                              const SizedBox(
                                  height: 8),

                              Text(
                                "Savings Account ••••${accountNumber.length >= 4 ? accountNumber.substring(accountNumber.length - 4) : accountNumber}",
                                style:
                                    const TextStyle(
                                  color:
                                      Colors.white70,
                                  fontSize:
                                      14,
                                ),
                              ),

                              const SizedBox(
                                  height: 12),

                              const Row(
                                children: [

                                  Icon(
                                    Icons
                                        .verified,
                                    color:
                                        Colors.white70,
                                    size: 18,
                                  ),

                                  SizedBox(
                                      width: 5),

                                  Text(
                                    "Verified Account",
                                    style:
                                        TextStyle(
                                      color:
                                          Colors.white70,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              const Text(
                "Quick Actions",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight:
                      FontWeight.bold,
                ),
              ),

              const SizedBox(height: 15),

              GridView.count(

                shrinkWrap: true,

                physics:
                    const NeverScrollableScrollPhysics(),

                crossAxisCount: 2,

                crossAxisSpacing: 15,

                mainAxisSpacing: 15,

                childAspectRatio: 2.5,

                children: [

                  ActionCard(
                    icon:
                        Icons.add_circle,
                    title: "Deposit",
                    onTap: () async {

                      await Navigator.push(
  context,
  FadePageRoute(
    page:
        const DepositScreen(),
  ),
);

                      await loadBalance();
                    },
                  ),

                  ActionCard(
                    icon: Icons
                        .remove_circle,
                    title: "Withdraw",
                    onTap: () async {

                     await Navigator.push(
  context,
  FadePageRoute(
    page:
        const WithdrawScreen(),
  ),
);

                      await loadBalance();
                    },
                  ),

                  ActionCard(
                    icon:
                        Icons.swap_horiz,
                    title: "Transfer",
                    onTap: () async {

                      await Navigator.push(
  context,
  FadePageRoute(
    page:
        const TransferScreen(),
  ),
);

                      await loadBalance();
                    },
                  ),

                  ActionCard(
                    icon:
                        Icons.history,
                    title: "History",
                    onTap: () {

                      Navigator.push(
  context,
  FadePageRoute(
    page:
        const TransactionHistoryScreen(),
  ),
);
                    },
                  ),
                ],
              ),

              const SizedBox(height: 25),

const Text(
  "Recent Activity",
  style: TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.bold,
  ),
),

const SizedBox(height: 10),

Card(

  shape: RoundedRectangleBorder(
    borderRadius:
        BorderRadius.circular(20),
  ),

  child: recentTransactions.isEmpty

      ? const Padding(

          padding:
              EdgeInsets.all(20),

          child: Center(
            child: Text(
              "No Transactions Found",
            ),
          ),
        )

      : Column(

          children:
              recentTransactions
                  .map((tx) {

            IconData icon =
                Icons.swap_horiz;

            Color color =
                Colors.blue;

            if (tx[
                    'transactionType'] ==
                'DEPOSIT') {

              icon = Icons
                  .arrow_downward;

              color = Colors.green;
            }

            else if (tx[
                    'transactionType'] ==
                'WITHDRAW') {

              icon = Icons
                  .arrow_upward;

              color = Colors.red;
            }

            return ListTile(

              leading: Icon(
                icon,
                color: color,
              ),

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
            );

          }).toList(),
        ),
),

              const SizedBox(height: 25),

              SizedBox(

                width:
                    double.infinity,

                child:
                    ElevatedButton.icon(

                  style:
                      ElevatedButton
                          .styleFrom(
                    backgroundColor:
                        Colors.red,
                    foregroundColor:
                        Colors.white,
                    padding:
                        const EdgeInsets
                            .symmetric(
                      vertical: 18,
                    ),
                    shape:
                        RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius
                              .circular(
                                  20),
                    ),
                  ),

                  onPressed:
                      () async {

                    await LocalStorage
                        .logout();

                    if (!mounted) return;

                    Navigator
                        .pushAndRemoveUntil(

                      context,

                      MaterialPageRoute(
                        builder: (_) =>
                            const LoginScreen(),
                      ),

                      (route) =>
                          false,
                    );
                  },

                  icon:
                      const Icon(
                    Icons.logout,
                  ),

                  label:
                      const Text(
                    "Logout",
                  ),
                ),
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),),
    );
  }
}