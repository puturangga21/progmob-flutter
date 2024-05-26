import 'package:dio/dio.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get_storage/get_storage.dart';
import 'package:page_transition/page_transition.dart';
import 'package:penmas/components/button.dart';
import 'package:penmas/components/card_login_social.dart';
import 'package:penmas/components/textfield.dart';
import 'package:penmas/pages/home_page.dart';
import 'package:penmas/pages/register.dart';
import 'package:penmas/theme.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final dio = Dio();
  final myStorage = GetStorage();
  final apiUrl = 'https://mobileapis.manpits.xyz/api';

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      checkLoginStatus();
    });
  }

  void checkLoginStatus() {
    final token = myStorage.read('token');
    if (token != null) {
      // Jika pengguna sudah login, arahkan ke halaman login page
      Navigator.push(
        context,
        PageTransition(
          child: HomePage(),
          type: PageTransitionType.fade,
        ),
      );
    }
  }

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
                  Column(
                    children: [
                      // Username
                      MyTextField(
                        hintText: 'Email',
                        title: 'Email',
                        myIcons: 'assets/icons/user.svg',
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
                      onPressButton: () {
                        goLogin(
                          context,
                          emailController,
                          passwordController,
                          dio,
                          myStorage,
                          apiUrl,
                        );
                      }),

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

                          // Fungsi untuk pindah halaman
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.push(
                                context,
                                PageTransition(
                                  child: const RegisterPage(),
                                  type: PageTransitionType.fade,
                                ),
                              );
                            },
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

void goLogin(BuildContext context, emailController, passwordController, dio,
    myStorage, apiUrl) async {
  try {
    final response = await dio.post(
      '$apiUrl/login',
      data: {
        'email': emailController.text,
        'password': passwordController.text,
      },
    );

    print(response.data);
    myStorage.write('token', response.data['data']['token']);
    myStorage.write('user', response.data['data']['user']);

    // Pindah halaman ke home jika berhasil login
    Navigator.push(
      context,
      PageTransition(
        child: const HomePage(),
        type: PageTransitionType.fade,
      ),
    );

    // Jika error
  } on DioException catch (e) {
    print('Error : ${e.response?.statusCode} - ${e.response?.data}');
  }
}
