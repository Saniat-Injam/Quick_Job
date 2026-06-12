import 'package:flutter/material.dart';

class SocialButton extends StatelessWidget {
  final String logoPath;
  final VoidCallback onTap;

  const SocialButton({super.key, required this.logoPath, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 56,
        height: 48,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: const Color(0xFFE0E0E0)),
          color: Colors.white,
        ),
        child: Center(child: Image.asset(logoPath)),
      ),
    );
  }
}
