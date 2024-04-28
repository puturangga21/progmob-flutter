import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:page_transition/page_transition.dart';
import 'package:penmas/components/button.dart';
import 'package:penmas/pages/login.dart';
import 'package:penmas/theme.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Heading
            const SizedBox(
              height: 70,
            ),

            SvgPicture.asset(
              'assets/icons/large_icons.svg',
            ),

            const SizedBox(
              height: 50,
            ),

            // Gambar
            Image.asset(
              'assets/images/splash_screen.png',
            ),

            // Call to action

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 33),
              child: SizedBox(
                width: 400,
                child: Column(
                  children: [
                    Text(
                      'Bangun Bersama Perbaiki Infrastruktur',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        color: secondary,
                        fontSize: 30,
                        fontWeight: FontWeight.w600,
                        height: 1.2,
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    const Text(
                      'Build Better, merupakan platform pelaporan pembangunan yang dibangun untuk masyarakat',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        color: Color(0XFF94A3B8),
                        fontSize: 12,
                        height: 1.4,
                      ),
                    ),
                    const SizedBox(
                      height: 28,
                    ),
                    MyButton(
                      title: 'Get Started',
                      color: primary,
                      onPressButton: () {
                        Navigator.push(
                          context,
                          PageTransition(
                              child: const LoginPage(),
                              type: PageTransitionType.fade),
                        );
                      },
                    )
                  ],
                ),
              ),
            ),

            // Tombol
          ],
        ),
      ),
    );
  }
}
