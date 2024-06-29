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
  late String noInduk;
  late String alamat;
  late String telepon;
  late String tglLahir;
  String saldo = '0';
  List<Map<String, dynamic>> transaksiHistoy = [];

  @override
  void initState() {
    super.initState();
    nama = widget.user['nama'];
    noInduk = widget.user['nomor_induk'].toString();
    alamat = widget.user['alamat'];
    telepon = widget.user['telepon'];
    tglLahir = widget.user['tgl_lahir'];

    getSaldo();
    getTransaksiHistory();
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

  void getTransaksiHistory() async {
    final response = await apiService.request(
      endpoint: 'tabungan/${widget.user['id']}',
      method: 'GET',
    );

    print(response);

    if (response != null) {
      setState(() {
        transaksiHistoy =
            List<Map<String, dynamic>>.from(response.data['data']['tabungan']);
      });
    }
  }

  String getNominalWithSign(int trxId, int nominal) {
    switch (trxId) {
      case 1:
      case 2:
      case 5:
        return '+ Rp. $nominal';
      case 3:
      case 6:
        return '- Rp. $nominal';
      default:
        return 'Rp. $nominal';
    }
  }

  String getTransaksiDescription(int trxId) {
    switch (trxId) {
      case 1:
        return 'Setoran Awal';
      case 2:
        return 'Tambah Saldo';
      case 3:
        return 'Penarikan';
      case 5:
        return 'Koreksi Penambahan';
      case 6:
        return 'Koreksi Penarikan';
      default:
        return 'Transaksi';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Saldo Anggota'),
      ),
      body: SingleChildScrollView(
        child: Padding(
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
                            'assets/icons/icon_anggota.svg',
                          ),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Text(
                          'Nama user:  $nama',
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
                            'assets/icons/icon_telephone.svg',
                          ),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Text(
                          'Telepon user: $telepon',
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
                            'assets/icons/icon_clip.svg',
                          ),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Text(
                          'Nomor induk: $noInduk',
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
                            'assets/icons/icon_marker.svg',
                          ),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Text(
                          'Alamat: $alamat',
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
                          'Tanggal lahir: $tglLahir',
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
              ),

              const SizedBox(
                height: 12,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Histori Transaksi',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: secondary),
                  ),
                ],
              ),
              const SizedBox(
                height: 12,
              ),

              // Container untuk history
              Column(
                children: transaksiHistoy.map((transaksi) {
                  return Container(
                    width: double.infinity,
                    height: 118,
                    margin: const EdgeInsets.only(bottom: 12),
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(8)),
                      color: primary,
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          transaksi['trx_tanggal'],
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          getTransaksiDescription(transaksi['trx_id']),
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          getNominalWithSign(
                              transaksi['trx_id'], transaksi['trx_nominal']),
                          style: const TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
