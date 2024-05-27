import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:page_transition/page_transition.dart';
import 'package:penmas/pages/edit_user.dart';
import 'package:penmas/theme.dart';

class ListUser extends StatefulWidget {
  const ListUser({super.key});

  @override
  State<ListUser> createState() => _ListUserState();
}

class _ListUserState extends State<ListUser> {
  final dio = Dio();
  final myStorage = GetStorage();
  final apiUrl = 'https://mobileapis.manpits.xyz/api';

  // Buat variabel untuk simpan data anggota yang diambil dari API
  List<dynamic> users = [];

  @override
  void initState() {
    super.initState();
    getUser();
  }

  void getUser() async {
    try {
      final response = await dio.get(
        '$apiUrl/anggota',
        options: Options(
          headers: {'Authorization': 'Bearer ${myStorage.read('token')}'},
        ),
      );

      // Setelah data berhasil diambil, data disimpan ke variabel users
      setState(() {
        users = response.data['data']['anggotas'];
      });
    } on DioException catch (e) {
      print('${e.response} - ${e.response?.statusCode}');
    }
  }

  void editUser(Map<String, dynamic> user) {
    Navigator.push(
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
    try {
      final response = await dio.delete(
        '$apiUrl/anggota/$id',
        options: Options(
          headers: {'Authorization': 'Bearer ${myStorage.read('token')}'},
        ),
      );

      print(response.data);

      getUser();
    } on DioException catch (e) {
      print('${e.response} - ${e.response?.statusCode}');
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
                      subtitle: Text(user['alamat']),
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
