import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:penmas/screens/dashboard.dart';
import 'package:penmas/screens/setting.dart';
import 'package:penmas/screens/transaction.dart';
import 'package:penmas/theme.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int index = 0;

  final screens = [
    const MyDashboard(),
    const MyTransaction(),
    const MySetting(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(
          backgroundColor: Colors.white,
          indicatorColor: primal,
          labelTextStyle: MaterialStateProperty.all(
            const TextStyle(
              fontSize: 14,
              fontFamily: 'Poppins',
            ),
          ),
        ),
        child: NavigationBar(
          backgroundColor: Colors.white,
          selectedIndex: index,
          onDestinationSelected: (index) => setState(() {
            this.index = index;
          }),
          destinations: [
            NavigationDestination(
              icon: SvgPicture.asset('assets/icons/home.svg'),
              label: 'Home',
            ),
            NavigationDestination(
              icon: SvgPicture.asset('assets/icons/heart.svg'),
              label: 'Transaction',
            ),
            NavigationDestination(
              icon: SvgPicture.asset('assets/icons/cog.svg'),
              label: 'Setting',
            ),
          ],
        ),
      ),
      body: screens[index],
    );
  }
}
