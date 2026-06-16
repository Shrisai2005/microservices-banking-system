import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'screens/auth/login_screen.dart';
import 'theme/theme_provider.dart';

void main() {

  runApp(

    ChangeNotifierProvider(

      create: (_) =>
          ThemeProvider(),

      child:
          const BankingApp(),
    ),
  );
}

class BankingApp extends StatelessWidget {

  const BankingApp({
    super.key,
  });

  @override
  Widget build(
      BuildContext context) {

    final themeProvider =
        Provider.of<
            ThemeProvider>(
      context,
    );

    return MaterialApp(

      debugShowCheckedModeBanner:
          false,

      title: "Banking App",

      themeMode:
          themeProvider.themeMode,

      theme: ThemeData(

        useMaterial3: true,

        scaffoldBackgroundColor:
            const Color(
                0xFFF5F7FA),

        colorScheme:
            ColorScheme.fromSeed(
          seedColor:
              const Color(
                  0xFF1565C0),
        ),
      ),

      darkTheme: ThemeData.dark(
        useMaterial3: true,
      ),

      home:
          const LoginScreen(),
    );
  }
}