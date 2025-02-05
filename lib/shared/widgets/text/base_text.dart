import 'package:flutter/material.dart';

class BaseText extends StatelessWidget {
  final String title;
  final Color? color;

  const BaseText({super.key, required this.title, this.color = Colors.black});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: color),
    );
  }
}
