import 'package:flutter/material.dart';
import 'package:notes_app/shared/styles/colors.dart';

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
      height: 54,
      width: double.infinity,
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(32),
          gradient: const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppColors.lightPurple,
              AppColors.darkPurple,
            ],
          ),
        ),
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(32),
            ),
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
              : Row(
                children: [
                  const Spacer(),
                  Text(
                              text ?? '',
                              style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 18,
                  color: Colors.white,
                              ),
                            ),
                  const Spacer(),
                  const Icon(Icons.arrow_forward, color: Colors.white),
                ],
              ),
        ),
      ),
    );
  }
}