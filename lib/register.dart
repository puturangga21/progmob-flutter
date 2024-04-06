import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:page_transition/page_transition.dart';
import 'package:penmas/components/button.dart';
import 'package:penmas/components/textfield.dart';
import 'package:penmas/login.dart';
import 'package:penmas/theme.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(top: 70, left: 33, right: 33),
            child: Column(
              children: [
                // Mini icon
                SvgPicture.asset('assets/icons/mini_icons.svg'),

                const SizedBox(height: 36),

                // Heading pembuka
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 48),
                  child: Text(
                    'Daftarkan diri terlebih dahulu',
                    style: TextStyle(
                      fontSize: 30,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
                      color: secondary,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),

                const SizedBox(height: 10),

                Text(
                  'Kami menjamin keamanan dan privasi anda',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    color: neutral,
                    fontSize: 12,
                  ),
                ),

                const SizedBox(height: 50),

                // Form pendaftaran
                const Column(
                  children: [
                    // Username
                    MyTextField(
                      hintText: 'Username',
                      title: 'Username',
                      myIcons: 'assets/icons/user.svg',
                      hideText: false,
                    ),

                    SizedBox(height: 20),

                    // Email
                    MyTextField(
                      hintText: 'Email',
                      title: 'Email',
                      myIcons: 'assets/icons/mail.svg',
                      hideText: false,
                    ),

                    SizedBox(height: 20),

                    // Password
                    MyTextField(
                      hintText: 'Password',
                      title: 'Password',
                      myIcons: 'assets/icons/key.svg',
                      hideText: true,
                    ),

                    SizedBox(height: 20),

                    // Telepon
                    MyTextField(
                      hintText: 'Telepon',
                      title: 'Telepon',
                      myIcons: 'assets/icons/flag_id.svg',
                      hideText: false,
                    ),
                  ],
                ),

                const SizedBox(height: 50),

                // Button daftar
                MyButton(
                  title: 'Daftar Sekarang',
                  color: primary,
                  onPressButton: () {},
                ),

                const SizedBox(height: 18),

                // Action jika sudah daftar
                RichText(
                  text: TextSpan(
                    text: 'Sudah daftar? ',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 14,
                      color: secondary,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                          text: 'Login',
                          style: TextStyle(
                              fontWeight: FontWeight.w600, color: primary),

                          // Fungsi untuk pindah halaman
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.push(
                                context,
                                PageTransition(
                                  child: const LoginPage(),
                                  type: PageTransitionType.fade,
                                ),
                              );
                            }),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
