import 'package:flutter/material.dart';
import 'package:penmas/login.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Pengaduan Masyarakat',
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
    );
  }
}
