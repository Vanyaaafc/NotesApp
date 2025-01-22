import 'package:flutter/material.dart';

class MainTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final bool isPassword;
  final void Function(String)? onChanged;

  const MainTextField({
    super.key,
    required this.hint,
    required this.controller,
    required this.isPassword,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      maxLines: 1,
      obscureText: isPassword,
      onChanged: onChanged,
      decoration: InputDecoration(
        hintStyle: const TextStyle(fontSize: 18, color: Colors.black54),
        hintText: hint,
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
      ),
    );
  }
}