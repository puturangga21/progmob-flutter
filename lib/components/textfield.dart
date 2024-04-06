import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:penmas/theme.dart';

class MyTextField extends StatelessWidget {
  final String hintText;
  final String title;
  final String myIcons;

  const MyTextField({
    super.key,
    required this.hintText,
    required this.title,
    required this.myIcons,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w600,
            color: secondary,
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 4),
        // text field
        TextField(
          style: const TextStyle(
            fontFamily: 'Poppins',
          ),
          decoration: InputDecoration(
            hintText: hintText,
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                width: 1.6,
                color: neutral,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                width: 1.6,
                color: neutral,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            hintStyle: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 14,
              color: neutral,
            ),
            prefixIconColor: neutral,
            prefixIcon: Padding(
              padding: const EdgeInsets.all(8),
              child: SvgPicture.asset(
                myIcons,
              ),
            ),
          ),
        )
      ],
    );
  }
}
