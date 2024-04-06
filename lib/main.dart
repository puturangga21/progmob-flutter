import 'package:flutter/material.dart';

import 'package:penmas/login.dart';
// import 'package:penmas/register.dart';
// import 'package:penmas/home_page.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pemrograman Mobile',
      theme: ThemeData(fontFamily: 'Poppins'),
      debugShowCheckedModeBanner: false,
      home: const LoginPage(),
    );
  }
}
