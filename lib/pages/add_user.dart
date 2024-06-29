import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:page_transition/page_transition.dart';
import 'package:penmas/api_service.dart';
import 'package:penmas/components/button.dart';
import 'package:penmas/components/textfield.dart';
import 'package:penmas/pages/home_page.dart';
import 'package:penmas/theme.dart';

class AddUser extends StatefulWidget {
  const AddUser({super.key});

  @override
  State<AddUser> createState() => _AddUserState();
}

class _AddUserState extends State<AddUser> {
  ApiService apiService = ApiService();

  TextEditingController noIndukController = TextEditingController();
  TextEditingController namaController = TextEditingController();
  TextEditingController alamatController = TextEditingController();
  TextEditingController tglLahirController = TextEditingController();
  TextEditingController teleponController = TextEditingController();

  void addUser() async {
    final response = await apiService.request(
      endpoint: 'anggota',
      method: 'POST',
      data: {
        'nomor_induk': noIndukController.text,
        'nama': namaController.text,
        'alamat': alamatController.text,
        'tgl_lahir': tglLahirController.text,
        'telepon': teleponController.text,
      },
    );

    if (response != null) {
      print(response.data);

      // Pindah halaman ke home jika berhasil register
      Navigator.pushReplacement(
        context,
        PageTransition(
          child: const HomePage(),
          type: PageTransitionType.fade,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 70, left: 33, right: 33),
        child: Column(
          children: [
            // Mini icon
            SvgPicture.asset('assets/icons/mini_icons.svg'),

            const SizedBox(height: 36),

            // Heading
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 48),
              child: Text(
                'Silahkan menambah data user',
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
              'Pastikan mengisi data dengan benar',
              style: TextStyle(
                fontFamily: 'Poppins',
                color: neutral,
                fontSize: 12,
              ),
            ),
            const SizedBox(height: 50),

            Column(
              children: [
                MyTextField(
                  hintText: 'Nomor Induk',
                  title: 'Nomor Induk',
                  myIcons: 'assets/icons/user.svg',
                  hideText: false,
                  myController: noIndukController,
                ),
                const SizedBox(height: 20),
                MyTextField(
                  hintText: 'Nama',
                  title: 'Nama',
                  myIcons: 'assets/icons/user.svg',
                  hideText: false,
                  myController: namaController,
                ),
                const SizedBox(height: 20),
                MyTextField(
                  hintText: 'Alamat',
                  title: 'Alamat',
                  myIcons: 'assets/icons/user.svg',
                  hideText: false,
                  myController: alamatController,
                ),
                const SizedBox(height: 20),
                MyTextField(
                  hintText: 'Tanggal Lahir',
                  title: 'Tanggal Lahir',
                  myIcons: 'assets/icons/user.svg',
                  hideText: false,
                  myController: tglLahirController,
                ),
                const SizedBox(height: 20),
                MyTextField(
                  hintText: 'Telepon',
                  title: 'Telepon',
                  myIcons: 'assets/icons/user.svg',
                  hideText: false,
                  myController: teleponController,
                ),
                const SizedBox(height: 20),

                // Button
                MyButton(
                    title: 'Tambah User',
                    color: Colors.green,
                    onPressButton: () {
                      addUser();
                    })
              ],
            )
          ],
        ),
      ),
    );
  }
}
