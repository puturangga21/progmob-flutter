import 'package:flutter/material.dart';
import 'package:penmas/login.dart';
import 'package:penmas/register.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Pemrograman Mobile',
      debugShowCheckedModeBanner: false,
      home: RegisterPage(),
    );
  }
}
