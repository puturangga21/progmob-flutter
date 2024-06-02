import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:page_transition/page_transition.dart';
import 'package:penmas/api_service.dart';
import 'package:penmas/components/button.dart';
import 'package:penmas/components/textfield.dart';
import 'package:penmas/pages/list_transaksi.dart';
import 'package:penmas/theme.dart';

class AddTransaksi extends StatefulWidget {
  final Map<String, dynamic> user;

  const AddTransaksi({
    super.key,
    required this.user,
  });

  @override
  State<AddTransaksi> createState() => _AddTransaksiState();
}

class _AddTransaksiState extends State<AddTransaksi> {
  final ApiService apiService = ApiService();
  TextEditingController idAnggotaController = TextEditingController();
  TextEditingController trxIdController = TextEditingController();
  TextEditingController trxNominalController = TextEditingController();

  @override
  void initState() {
    super.initState();
    idAnggotaController =
        TextEditingController(text: widget.user['id'].toString());
    trxIdController = TextEditingController(text: '1');
  }

  void addTransaction() async {
    final response = await apiService.request(
      endpoint: 'tabungan',
      method: 'POST',
      data: {
        'anggota_id': idAnggotaController.text,
        'trx_id': trxIdController.text,
        'trx_nominal': trxNominalController.text,
      },
    );

    if (response != null) {
      print(response.data);

      Navigator.push(
        context,
        PageTransition(
          child: const ListTransaksi(),
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
                'Silahkan menambah data transaksi',
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
                  hintText: 'ID Anggota',
                  title: 'ID Anggota',
                  myIcons: 'assets/icons/user.svg',
                  hideText: false,
                  myController: idAnggotaController,
                ),
                const SizedBox(height: 20),
                MyTextField(
                  hintText: 'TRX ID',
                  title: 'TRX ID',
                  myIcons: 'assets/icons/user.svg',
                  hideText: false,
                  myController: trxIdController,
                ),
                const SizedBox(height: 20),
                MyTextField(
                  hintText: 'TRX Nominal',
                  title: 'TRX Nominal',
                  myIcons: 'assets/icons/user.svg',
                  hideText: false,
                  myController: trxNominalController,
                ),
                const SizedBox(height: 20),

                // Button
                MyButton(
                    title: 'Tambah Transaksi',
                    color: Colors.green,
                    onPressButton: () {
                      addTransaction();
                    })
              ],
            )
          ],
        ),
      ),
    );
  }
}
