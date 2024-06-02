import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:penmas/api_service.dart';
import 'package:penmas/pages/add_transaksi.dart';
import 'package:penmas/pages/saldo_user.dart';
import 'package:penmas/theme.dart';

class ListTransaksi extends StatefulWidget {
  const ListTransaksi({super.key});

  @override
  State<ListTransaksi> createState() => _ListTransaksiState();
}

class _ListTransaksiState extends State<ListTransaksi> {
  // Buat variabel untuk simpan data anggota yang diambil dari API
  List<dynamic> users = [];
  ApiService apiService = ApiService();

  @override
  void initState() {
    super.initState();
    getAnggota();
  }

  void getAnggota() async {
    final response = await apiService.request(
      endpoint: 'anggota',
      method: 'GET',
    );

    if (response != null) {
      setState(() {
        users = response.data['data']['anggotas'];
      });
    }
  }

  void addTransaction(Map<String, dynamic> user) {
    Navigator.push(
      context,
      PageTransition(
        child: AddTransaksi(user: user),
        type: PageTransitionType.fade,
      ),
    ).then((value) {
      if (value == true) {
        getAnggota();
      }
    });
  }

  void saldoUser(Map<String, dynamic> user) {
    Navigator.push(
      context,
      PageTransition(
        child: SaldoUser(user: user),
        type: PageTransitionType.fade,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('List Transaksi User'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: users.isEmpty
            ? const Center(child: CircularProgressIndicator())
            : ListView.builder(
                itemCount: users.length,
                itemBuilder: (BuildContext context, int index) {
                  final user = users[index];

                  return Card(
                    child: ListTile(
                      title: Text(user['nama']),
                      subtitle: Text(user['alamat']),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            onPressed: () {
                              addTransaction(user);
                            },
                            icon: Icon(
                              Icons.add,
                              color: primary,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              saldoUser(user);
                            },
                            icon: Icon(
                              Icons.money,
                              color: primary,
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
