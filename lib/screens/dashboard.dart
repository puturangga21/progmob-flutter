import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:page_transition/page_transition.dart';
import 'package:penmas/components/card_banner.dart';
import 'package:penmas/pages/add_user.dart';
import 'package:penmas/pages/list_user.dart';
import 'package:penmas/theme.dart';

class MyDashboard extends StatefulWidget {
  const MyDashboard({super.key});

  @override
  State<MyDashboard> createState() => _MyDashboardState();
}

class _MyDashboardState extends State<MyDashboard> {
  final myStorage = GetStorage();

  String userName = '';

  @override
  void initState() {
    super.initState();
    loadUserData();
  }

  void loadUserData() {
    final user = myStorage.read('user');
    if (user != null) {
      setState(() {
        userName = user['name'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 33),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Teks heading
            Container(
              margin: const EdgeInsets.only(top: 60),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Hi $userName!',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w600,
                      color: secondary,
                    ),
                  ),
                  Text(
                    'Selamat datang di dashboard',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: secondary,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(
              height: 24,
            ),

            CardBanner(
              title: 'Tambah User',
              image: 'assets/images/card2.png',
              onPressButton: () {
                Navigator.pushReplacement(
                  context,
                  PageTransition(
                    child: const AddUser(),
                    type: PageTransitionType.fade,
                  ),
                );
              },
            ),
            const SizedBox(
              height: 16,
            ),
            CardBanner(
              title: 'Daftar User',
              image: 'assets/images/card3.png',
              onPressButton: () {
                Navigator.pushReplacement(
                  context,
                  PageTransition(
                    child: const ListUser(),
                    type: PageTransitionType.fade,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
