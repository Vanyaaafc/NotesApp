import 'package:flutter/material.dart';

class ContinueButton extends StatelessWidget {
  final void Function() onPressed;
  final String text;

  const ContinueButton(
      {super.key, required this.onPressed, required this.text});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: double.infinity,
      child: ElevatedButton(
          onPressed: onPressed,
          style: ButtonStyle(
            backgroundColor: WidgetStateProperty.all<Color>(Colors.indigo)
          ),
          child: Text(
            text,
            style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 18, color: Colors.white),
          )),
    );
  }
}
