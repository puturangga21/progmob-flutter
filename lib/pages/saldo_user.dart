import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:penmas/api_service.dart';
import 'package:penmas/theme.dart';

class SaldoUser extends StatefulWidget {
  final Map<String, dynamic> user;

  const SaldoUser({
    super.key,
    required this.user,
  });

  @override
  State<SaldoUser> createState() => _SaldoUserState();
}

class _SaldoUserState extends State<SaldoUser> {
  ApiService apiService = ApiService();
  late String nama;
  late String alamat;
  late String telepon;
  late String tglLahir;
  String saldo = '0';

  @override
  void initState() {
    super.initState();
    nama = widget.user['nama'];
    alamat = widget.user['alamat'];
    telepon = widget.user['telepon'];
    tglLahir = widget.user['tgl_lahir'];

    getSaldo();
  }

  void getSaldo() async {
    final response = await apiService.request(
      endpoint: 'saldo/${widget.user['id']}',
      method: 'GET',
    );

    if (response != null) {
      print(response.data);
      setState(() {
        saldo = response.data['data']['saldo'].toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Saldo Anggota'),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 70, left: 33, right: 33),
        child: Column(
          children: [
            Column(
              children: [
                const Image(
                  image: AssetImage('assets/images/anggota.png'),
                ),
                const SizedBox(
                  height: 16,
                ),
                Text(
                  nama,
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      color: secondary),
                ),
                Text(
                  telepon,
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: secondary),
                ),
              ],
            ),
            const SizedBox(
              height: 40,
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.only(top: 12),
              decoration: const BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: Color(0XFFE2E8F0),
                  ),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Informasi Pengguna',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: secondary),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 26,
                        child: SvgPicture.asset(
                          'assets/icons/icon_marker.svg',
                        ),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Text(
                        alamat,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: secondary,
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 26,
                        child: SvgPicture.asset(
                          'assets/icons/icon_calendar.svg',
                        ),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Text(
                        tglLahir,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: secondary,
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 32,
            ),
            Container(
              width: double.infinity,
              height: 118,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(8)),
                color: primary,
              ),
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'JUMLAH SALDO',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    'Rp. $saldo',
                    style: const TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
