import 'package:flutter/material.dart';
import 'package:penmas/components/textfield.dart';
import 'package:penmas/theme.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 70, left: 33, right: 33),
            child: Column(
              children: [
                // Icon
                Image.asset('assets/images/title.png'),

                const SizedBox(height: 36),

                // Heading
                SizedBox(
                  width: 230,
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
                    ),

                    SizedBox(height: 20),

                    // Password
                    MyTextField(
                      hintText: 'Password',
                      title: 'Password',
                      myIcons: 'assets/icons/key.svg',
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
                Container(
                  width: double.infinity,
                  height: 36,
                  decoration: BoxDecoration(
                    color: primary,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Center(
                    child: Text(
                      'Login',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),

                // Atau login dengan

                const SizedBox(height: 50),

                Row(
                  children: [
                    Expanded(
                      child: Divider(
                        thickness: 0.5,
                        color: neutral,
                      ),
                    ),
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
                    Expanded(
                      child: Divider(
                        thickness: 0.5,
                        color: neutral,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 40),

                Row(
                  children: [
                    Flexible(
                      fit: FlexFit.tight,
                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color(0XFFF8FAFC),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: const EdgeInsets.symmetric(
                          vertical: 10,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 8),
                              child: Image.asset('assets/images/facebook.png'),
                            ),
                            Text(
                              'Facebook',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: secondary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 15),
                    Flexible(
                      fit: FlexFit.tight,
                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color(0XFFF8FAFC),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: const EdgeInsets.symmetric(
                          vertical: 10,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 8),
                              child: Image.asset('assets/images/google.png'),
                            ),
                            Text(
                              'Google',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: secondary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ));
  }
}
