import 'package:flutter/material.dart';

class ContinueButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String? text;
  final bool isLoading;

  const ContinueButton({
    super.key,
    required this.onPressed,
    this.text,
    this.isLoading = false,
  });

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
        child: isLoading
            ? const SizedBox(
          height: 20,
          width: 20,
          child: CircularProgressIndicator(
            strokeWidth: 2,
            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
          ),
        )
            : Text(
          text ?? '',
          style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 18, color: Colors.white),
        ),
      ),
    );
  }
}