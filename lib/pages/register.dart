import 'package:dio/dio.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get_storage/get_storage.dart';
import 'package:page_transition/page_transition.dart';
import 'package:penmas/components/button.dart';
import 'package:penmas/components/textfield.dart';
import 'package:penmas/pages/login.dart';
import 'package:penmas/theme.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final dio = Dio();
  final myStorage = GetStorage();
  final apiUrl = 'https://mobileapis.manpits.xyz/api';

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

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
                Column(
                  children: [
                    // Username
                    MyTextField(
                      hintText: 'Full Name',
                      title: 'Full Name',
                      myIcons: 'assets/icons/user.svg',
                      hideText: false,
                      myController: nameController,
                    ),

                    const SizedBox(height: 20),

                    // Email
                    MyTextField(
                      hintText: 'Email',
                      title: 'Email',
                      myIcons: 'assets/icons/mail.svg',
                      hideText: false,
                      myController: emailController,
                    ),

                    const SizedBox(height: 20),

                    // Password
                    MyTextField(
                      hintText: 'Password',
                      title: 'Password',
                      myIcons: 'assets/icons/key.svg',
                      hideText: true,
                      myController: passwordController,
                    ),

                    const SizedBox(height: 20),
                  ],
                ),

                const SizedBox(height: 50),

                // Button daftar
                MyButton(
                    title: 'Daftar Sekarang',
                    color: primary,
                    onPressButton: () {
                      goRegister(
                        context,
                        dio,
                        apiUrl,
                        myStorage,
                        nameController,
                        emailController,
                        passwordController,
                      );
                    }),

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

void goRegister(BuildContext context, dio, apiUrl, myStorage, nameController,
    emailController, passwordController) async {
  try {
    final response = await dio.post(
      '$apiUrl/register',
      data: {
        'name': nameController.text,
        'email': emailController.text,
        'password': passwordController.text,
      },
    );
    print(response.data);

    // Pindah halaman ke home jika berhasil register
    Navigator.push(
      context,
      PageTransition(
        child: const LoginPage(),
        type: PageTransitionType.fade,
      ),
    );

    // Jika gagal
  } on DioException catch (e) {
    print('${e.response} - ${e.response?.statusCode}');
  }
}
