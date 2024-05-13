import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:page_transition/page_transition.dart';
import 'package:penmas/components/bottom_navigation.dart';
import 'package:penmas/components/button.dart';
import 'package:penmas/pages/list_user.dart';
import 'package:penmas/pages/add_user.dart';
import 'package:penmas/pages/login.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int index = 0;

  final dio = Dio();
  final myStorage = GetStorage();
  final apiUrl = 'https://mobileapis.manpits.xyz/api';

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      checkTokenValidity();
    });
  }

  // void checkLoginStatus() {
  //   final token = myStorage.read('token');
  //   if (token == null) {
  //     // Jika pengguna sudah login, arahkan ke halaman login page
  //     Navigator.push(
  //       context,
  //       PageTransition(
  //         child: LoginPage(),
  //         type: PageTransitionType.fade,
  //       ),
  //     );
  //   }
  // }

  void checkTokenValidity() async {
    final token = myStorage.read('token');
    if (token == null) {
      // Jika token tidak tersedia, arahkan kembali ke halaman login
      Navigator.push(
        context,
        PageTransition(
          child: const LoginPage(),
          type: PageTransitionType.fade,
        ),
      );
    } else {
      // Jika token tersedia, lakukan pemeriksaan ke server apakah token masih valid
      try {
        final response = await dio.get(
          '$apiUrl/validateToken',
          options: Options(
            headers: {'Authorization': 'Bearer $token'},
          ),
        );
        // Jika token valid, tidak perlu tindakan tambahan
      } on DioException catch (e) {
        // Jika terjadi error saat validasi token (termasuk token expired),
        // arahkan kembali ke halaman login
        if (e.response?.statusCode == 401) {
          myStorage.remove('token');

          Navigator.push(
            context,
            PageTransition(
              child: const LoginPage(),
              type: PageTransitionType.fade,
            ),
          );
        } else {
          // Tangani jenis error lain jika diperlukan
          print('Error: ${e.response?.statusCode} - ${e.response?.data}');
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const BottomNavigation(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 33),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MyButton(
              title: 'Cek Detail User',
              color: Colors.blue,
              onPressButton: () {
                goUser(dio, myStorage, apiUrl);
              },
            ),
            const SizedBox(
              height: 10,
            ),
            MyButton(
              title: 'Tambah User',
              color: Colors.green,
              onPressButton: () {
                Navigator.push(
                  context,
                  PageTransition(
                    child: AddUser(),
                    type: PageTransitionType.fade,
                  ),
                );
              },
            ),
            const SizedBox(
              height: 10,
            ),
            MyButton(
              title: 'Lihat Daftar User',
              color: Colors.orange,
              onPressButton: () {
                Navigator.push(
                  context,
                  PageTransition(
                    child: ListUser(),
                    type: PageTransitionType.fade,
                  ),
                );
              },
            ),
            const SizedBox(
              height: 10,
            ),
            MyButton(
              title: 'Logout',
              color: Colors.red,
              onPressButton: () {
                goLogout(context, dio, myStorage, apiUrl);
              },
            ),
          ],
        ),
      ),
    );
  }
}

void goUser(dio, myStorage, apiUrl) async {
  try {
    final response = await dio.get(
      '$apiUrl/user',
      options: Options(
        headers: {'Authorization': 'Bearer ${myStorage.read('token')}'},
      ),
    );
    print(response.data);
  } on DioException catch (e) {
    print('${e.response} - ${e.response?.statusCode}');
  }
}

void goLogout(BuildContext context, dio, myStorage, apiUrl) async {
  try {
    final response = await dio.get(
      '$apiUrl/logout',
      options: Options(
        headers: {'Authorization': 'Bearer ${myStorage.read('token')}'},
      ),
    );
    print(response.data);

    // Balik ke halaman login
    Navigator.push(
      context,
      PageTransition(child: const LoginPage(), type: PageTransitionType.fade),
    );
  } on DioException catch (e) {
    print('${e.response} - ${e.response?.statusCode}');
  }
}
