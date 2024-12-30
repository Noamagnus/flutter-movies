import 'package:flutter/material.dart';

class IconWithText extends StatelessWidget {
  const IconWithText({
    super.key,
    required this.icon,
    required this.text,
  });

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon),
        const SizedBox(width: 10),
        Text(text),
      ],
    );
  }
}