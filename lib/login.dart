import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:penmas/components/button.dart';
import 'package:penmas/components/card_login_social.dart';
import 'package:penmas/components/textfield.dart';
import 'package:penmas/theme.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

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
                  // Icon
                  SvgPicture.asset('assets/icons/mini_icons.svg'),

                  const SizedBox(height: 36),

                  // Heading
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 40),
                    child: Text(
                      'Sudah Daftar? Silahkan Login',
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

                  // Form
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

                      // Password
                      MyTextField(
                        hintText: 'Password',
                        title: 'Password',
                        myIcons: 'assets/icons/key.svg',
                        hideText: true,
                      ),
                    ],
                  ),

                  const SizedBox(height: 15),

                  // Lupa password?
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'Lupa Password?',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w600,
                          color: secondary,
                          fontSize: 14,
                        ),
                      )
                    ],
                  ),

                  const SizedBox(height: 15),

                  // Tombol
                  MyButton(
                    color: primary,
                    title: 'Login',
                  ),

                  // Atau login dengan
                  const SizedBox(height: 50),

                  Row(
                    children: [
                      // Garis hiasan
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: neutral,
                        ),
                      ),

                      // Teks
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Text(
                          'Atau login dengan',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: neutral,
                          ),
                        ),
                      ),

                      // Garis hiasan
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: neutral,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 40),

                  const Row(
                    children: [
                      // Card login untuk facebook
                      CardLoginSocial(
                        logo: 'assets/icons/facebook.svg',
                        title: 'Facebook',
                      ),

                      SizedBox(width: 15),

                      // Card login untuk google
                      CardLoginSocial(
                        logo: 'assets/icons/google.svg',
                        title: 'Google',
                      ),
                    ],
                  ),

                  const SizedBox(height: 110),

                  RichText(
                    text: TextSpan(
                      text: 'Belum punya akun? ',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 14,
                        color: secondary,
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text: 'Daftar',
                          style: TextStyle(
                              fontWeight: FontWeight.w600, color: primary),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
