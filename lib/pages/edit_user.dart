import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get_storage/get_storage.dart';
import 'package:page_transition/page_transition.dart';
import 'package:penmas/components/button.dart';
import 'package:penmas/components/textfield.dart';
import 'package:penmas/pages/list_user.dart';
import 'package:penmas/theme.dart';

class EditUser extends StatefulWidget {
  final Map<String, dynamic> user;

  const EditUser({
    super.key,
    required this.user,
  });

  @override
  State<EditUser> createState() => _EditUserState();
}

class _EditUserState extends State<EditUser> {
  final dio = Dio();
  final myStorage = GetStorage();
  final apiUrl = 'https://mobileapis.manpits.xyz/api';

  late TextEditingController noIndukController;
  late TextEditingController namaController;
  late TextEditingController alamatController;
  late TextEditingController tglLahirController;
  late TextEditingController teleponController;

  @override
  void initState() {
    super.initState();
    noIndukController =
        TextEditingController(text: widget.user['nomor_induk'].toString());
    namaController = TextEditingController(text: widget.user['nama']);
    alamatController = TextEditingController(text: widget.user['alamat']);
    tglLahirController = TextEditingController(text: widget.user['tgl_lahir']);
    teleponController = TextEditingController(text: widget.user['telepon']);
  }

  void updateUser() async {
    try {
      final response = await dio.put(
        '$apiUrl/anggota/${widget.user['id']}',
        options: Options(
          headers: {'Authorization': 'Bearer ${myStorage.read('token')}'},
        ),
        data: {
          'nomor_induk': noIndukController.text,
          'nama': namaController.text,
          'alamat': alamatController.text,
          'tgl_lahir': tglLahirController.text,
          'telepon': teleponController.text,
        },
      );

      print(response.data);

      // Kembali ke halaman ListUser setelah berhasil mengupdate data
      Navigator.push(
        context,
        PageTransition(
          child: ListUser(),
          type: PageTransitionType.fade,
        ),
      );
    } on DioException catch (e) {
      print('${e.response} - ${e.response?.statusCode}');
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
                'Silahkan mengedit data user',
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
                  title: 'Edit User',
                  color: Colors.green,
                  onPressButton: () {
                    updateUser();
                  },
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
