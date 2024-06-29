import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:penmas/api_service.dart';
import 'package:penmas/pages/edit_user.dart';
import 'package:penmas/theme.dart';

class ListUser extends StatefulWidget {
  const ListUser({super.key});

  @override
  State<ListUser> createState() => _ListUserState();
}

class _ListUserState extends State<ListUser> {
  // Buat variabel untuk simpan data anggota yang diambil dari API
  List<dynamic> users = [];
  final ApiService apiService = ApiService();

  @override
  void initState() {
    super.initState();
    getUser();
  }

  void getUser() async {
    final response = await apiService.request(
      endpoint: 'anggota',
      method: 'GET',
    );

    // Setelah data berhasil diambil, data disimpan ke variabel users
    if (response != null) {
      setState(() {
        users = response.data['data']['anggotas'];
      });
    }
  }

  void editUser(Map<String, dynamic> user) {
    Navigator.pushReplacement(
      context,
      PageTransition(
        child: EditUser(user: user),
        type: PageTransitionType.fade,
      ),
    ).then((value) {
      if (value == true) {
        getUser();
      }
    });
  }

  void deleteUser(int id) async {
    final response = await apiService.request(
      endpoint: 'anggota/$id',
      method: 'DELETE',
    );

    // Setelah data berhasil diambil, data disimpan ke variabel users
    if (response != null) {
      print(response.data);
      getUser();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('List User'),
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
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 4),
                          Text(user['alamat']),
                          Text(user['id'].toString()),
                        ],
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            onPressed: () {
                              editUser(user);
                            },
                            icon: Icon(
                              Icons.edit,
                              color: primary,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              deleteUser(user['id']);
                            },
                            icon: Icon(
                              Icons.delete,
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
