import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:page_transition/page_transition.dart';
import 'package:penmas/api_service.dart';
import 'package:penmas/components/card_banner.dart';
import 'package:penmas/pages/login.dart';
import 'package:penmas/theme.dart';

class MySetting extends StatefulWidget {
  const MySetting({super.key});

  @override
  State<MySetting> createState() => _MySettingState();
}

class _MySettingState extends State<MySetting> {
  final myStorage = GetStorage();
  ApiService apiService = ApiService();

  void goUser() async {
    final response = await apiService.request(
      endpoint: 'user',
      method: 'GET',
    );

    if (response != null) {
      print(response.data);
    }
  }

  void goLogout() async {
    final response = await apiService.request(
      endpoint: 'logout',
      method: 'GET',
    );

    if (response != null) {
      print(response.data);

      // Hapus token dari penyimpanan
      myStorage.remove('token');
      myStorage.remove('user');

      // Balik ke halaman login
      Navigator.pushReplacement(
        context,
        PageTransition(child: const LoginPage(), type: PageTransitionType.fade),
      );
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
                    'Halaman Setting',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w600,
                      color: secondary,
                    ),
                  ),
                  Text(
                    'Selamat datang di halaman setting',
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
              title: 'Cek User',
              image: 'assets/images/card1.png',
              onPressButton: () {
                goUser();
              },
            ),
            const SizedBox(
              height: 16,
            ),

            CardBanner(
              title: 'Logout',
              image: 'assets/images/card4.png',
              onPressButton: () {
                goLogout();
              },
            ),
          ],
        ),
      ),
    );
  }
}
