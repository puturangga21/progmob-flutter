import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:penmas/theme.dart';

class CardLoginSocial extends StatelessWidget {
  final String logo;
  final String title;

  const CardLoginSocial({
    required this.logo,
    required this.title,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0XFFF8FAFC),
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.symmetric(
          vertical: 10,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 8),
              child: SvgPicture.asset(logo),
            ),
            Text(
              title,
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: secondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
