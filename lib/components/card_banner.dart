import 'package:flutter/material.dart';

class CardBanner extends StatelessWidget {
  final String title;
  final String image;
  final VoidCallback onPressButton;

  const CardBanner({
    required this.title,
    required this.image,
    required this.onPressButton,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 134,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(8)),
        gradient: LinearGradient(
          colors: [
            Color(0xFF0EA5E9),
            Color(0xFF2563EB),
          ],
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: TextButton(
                onPressed: onPressButton,
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Image(
              image: AssetImage(image),
            )
          ],
        ),
      ),
    );
  }
}
