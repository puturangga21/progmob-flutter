import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

import 'package:penmas/pages/home_page.dart';
import 'package:penmas/pages/login.dart';
import 'package:penmas/pages/register.dart';

void main() async {
  await GetStorage.init();
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
      routes: {
        '/': (context) => const HomePage(),
        '/login': (context) => const LoginPage(),
        '/register': (context) => const RegisterPage(),
      },
      initialRoute: '/',
    );
  }
}
