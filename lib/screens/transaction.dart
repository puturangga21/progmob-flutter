import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:penmas/components/card_banner.dart';
import 'package:penmas/pages/list_transaksi.dart';
import 'package:penmas/theme.dart';

class MyTransaction extends StatefulWidget {
  const MyTransaction({super.key});

  @override
  State<MyTransaction> createState() => _MyTransactionState();
}

class _MyTransactionState extends State<MyTransaction> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 33),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Teks heading
            Container(
              margin: const EdgeInsets.only(top: 60),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Halaman Transaksi',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w600,
                      color: secondary,
                    ),
                  ),
                  Text(
                    'Selamat datang di halaman transaksi',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: secondary,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(
              height: 24,
            ),

            CardBanner(
              title: 'Transaksi',
              image: 'assets/images/card1.png',
              onPressButton: () {
                Navigator.push(
                  context,
                  PageTransition(
                    child: const ListTransaksi(),
                    type: PageTransitionType.fade,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
