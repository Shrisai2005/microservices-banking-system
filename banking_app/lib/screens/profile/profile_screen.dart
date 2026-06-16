import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../storage/local_storage.dart';
import '../../services/user_service.dart';
import '../../theme/theme_provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() =>
      _ProfileScreenState();
}

class _ProfileScreenState
    extends State<ProfileScreen> {

  String fullName = "";
  String email = "";
  String accountNumber = "";

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {

    final savedEmail =
        await LocalStorage.getEmail();

    final savedAccount =
        await LocalStorage
            .getAccountNumber();

    final profile =
        await UserService()
            .getProfile(
                savedEmail ?? "");

    print("EMAIL = $savedEmail");
    print("PROFILE = $profile");

    setState(() {

      fullName =
          profile?['fullName'] ?? "";

      email =
          savedEmail ?? "";

      accountNumber =
          savedAccount ?? "";
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text(
          "My Profile",
        ),
      ),

      body: SingleChildScrollView(

        child: Padding(

          padding:
              const EdgeInsets.all(20),

          child: Column(

            children: [

              const SizedBox(height: 20),

              const CircleAvatar(
                radius: 50,
                backgroundColor:
                    Color(0xFF1565C0),
                child: Icon(
                  Icons.person,
                  color: Colors.white,
                  size: 50,
                ),
              ),

              const SizedBox(height: 15),

              Text(
                fullName.isEmpty
                    ? "Loading..."
                    : fullName,
                style:
                    const TextStyle(
                  fontSize: 24,
                  fontWeight:
                      FontWeight.bold,
                ),
              ),

              const SizedBox(height: 20),

              Card(

                elevation: 4,

                shape:
                    RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(
                          20),
                ),

                child: Padding(

                  padding:
                      const EdgeInsets.all(
                          20),

                  child: Column(

                    children: [

                      ListTile(
                        leading:
                            const Icon(
                          Icons.email,
                        ),
                        title:
                            const Text(
                          "Email",
                        ),
                        subtitle:
                            Text(email),
                      ),

                      const Divider(),

                      ListTile(
                        leading:
                            const Icon(
                          Icons.account_balance,
                        ),
                        title:
                            const Text(
                          "Account Number",
                        ),
                        subtitle:
                            Text(
                          accountNumber,
                        ),
                      ),

                      const Divider(),

                      const ListTile(
                        leading:
                            Icon(
                          Icons.badge,
                        ),
                        title: Text(
                          "Account Type",
                        ),
                        subtitle:
                            Text(
                          "SAVINGS",
                        ),
                      ),

                      const Divider(),

                      Consumer<
                          ThemeProvider>(
                        builder: (
                          context,
                          themeProvider,
                          child,
                        ) {

                          return SwitchListTile(

                            secondary:
                                const Icon(
                              Icons.dark_mode,
                            ),

                            title:
                                const Text(
                              "Dark Mode",
                            ),

                            value:
                                themeProvider
                                    .isDarkMode,

                            onChanged:
                                (value) {

                              themeProvider
                                  .toggleTheme();
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}