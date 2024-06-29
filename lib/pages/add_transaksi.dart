import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:page_transition/page_transition.dart';
import 'package:penmas/api_service.dart';
import 'package:penmas/components/button.dart';
import 'package:penmas/components/textfield.dart';
import 'package:penmas/pages/saldo_user.dart';
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
  TextEditingController trxNominalController = TextEditingController();
  // TextEditingController trxIdController = TextEditingController();
  int? selectedTrxId;

  @override
  void initState() {
    super.initState();
    idAnggotaController =
        TextEditingController(text: widget.user['id'].toString());
    // trxIdController = TextEditingController(text: '1');
    selectedTrxId = 1;
  }

  void addTransaction() async {
    final response = await apiService.request(
      endpoint: 'tabungan',
      method: 'POST',
      data: {
        'anggota_id': idAnggotaController.text,
        'trx_id': selectedTrxId.toString(),
        'trx_nominal': trxNominalController.text,
      },
    );

    if (response != null) {
      print(response.data);

      Navigator.pushReplacement(
        context,
        PageTransition(
          child: SaldoUser(user: widget.user),
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MyTextField(
                  hintText: 'TRX Nominal',
                  title: 'TRX Nominal',
                  myIcons: 'assets/icons/user.svg',
                  hideText: false,
                  myController: trxNominalController,
                ),
                const SizedBox(height: 20),

                // Dropdown untuk TRX ID
                Text(
                  'Jenis Transaksi',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
                    color: secondary,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 4),
                DropdownButtonFormField<int>(
                  value: selectedTrxId,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 1.6,
                        color: neutral,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 1.6,
                        color: primary,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    hintStyle: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 14,
                      color: neutral,
                    ),
                    prefixIconColor: neutral,
                    prefixIcon: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      child: SvgPicture.asset(
                        'assets/icons/user.svg',
                      ),
                    ),
                  ),
                  items: const [
                    DropdownMenuItem<int>(
                      value: 1,
                      child: Text('Setoran Awal'),
                    ),
                    DropdownMenuItem<int>(
                      value: 2,
                      child: Text('Tambah Saldo'),
                    ),
                    DropdownMenuItem<int>(
                      value: 3,
                      child: Text('Penarikan Saldo'),
                    ),
                    DropdownMenuItem<int>(
                      value: 5,
                      child: Text('Koreksi Penambahan'),
                    ),
                    DropdownMenuItem<int>(
                      value: 6,
                      child: Text('Koreksi Pengurangan'),
                    ),
                  ],
                  onChanged: (value) {
                    setState(() {
                      selectedTrxId = value!;
                    });
                  },
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
