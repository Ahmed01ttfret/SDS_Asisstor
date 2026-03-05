import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'Home/First_Page.dart';


void main() async{
  await dotenv.load(fileName: ".env");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme:// Example ThemeData for your Flutter App
      ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF1B263B), // Navy Blue
          primary: const Color(0xFF1B263B),
          secondary: const Color(0xFFF8961E), // Safety Orange
          error: const Color(0xFFC94C4C),     // Alert Red
          surface: const Color(0xFFF8F9FA),   // Light Gray
        ),
        textTheme: const TextTheme(
          displayMedium: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF1B263B)),
          bodyLarge: TextStyle(fontSize: 16, color: Colors.black87),
        ),

      ),
      home: const Index(),
    );
  }
}