import 'package:flutter/material.dart';
import 'pages/login_page.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      title: 'PBM Mobile',

      theme: ThemeData(
        useMaterial3: true,

        scaffoldBackgroundColor:
            const Color(0xFFF5F7FA),

        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF1E3A5F),
        ),

        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF1E3A5F),
          foregroundColor: Colors.white,
          centerTitle: true,
          elevation: 0,
        ),

        inputDecorationTheme:
            InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,

          border: OutlineInputBorder(
            borderRadius:
                BorderRadius.circular(16),
            borderSide: BorderSide.none,
          ),

          enabledBorder: OutlineInputBorder(
            borderRadius:
                BorderRadius.circular(16),
            borderSide: BorderSide.none,
          ),

          focusedBorder: OutlineInputBorder(
            borderRadius:
                BorderRadius.circular(16),
            borderSide: const BorderSide(
              color: Color(0xFF1E3A5F),
              width: 2,
            ),
          ),
        ),

        elevatedButtonTheme:
            ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor:
                const Color(0xFF1E3A5F),

            foregroundColor: Colors.white,

            shape: RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.circular(16),
            ),
          ),
        ),
      ),

      home: const LoginPage(),
    );
  }
}