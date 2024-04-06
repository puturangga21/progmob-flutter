import 'package:flutter/material.dart';
import 'package:penmas/theme.dart';
import 'package:flutter_svg/svg.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({super.key});

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return NavigationBarTheme(
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
            label: 'Favorite',
          ),
          NavigationDestination(
            icon: SvgPicture.asset('assets/icons/search.svg'),
            label: 'Search',
          ),
          NavigationDestination(
            icon: SvgPicture.asset('assets/icons/cog.svg'),
            label: 'Setting',
          ),
        ],
      ),
    );
  }
}
