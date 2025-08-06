import 'package:flutter/material.dart';

class CustomSignUpLink extends StatelessWidget {
  const CustomSignUpLink({
    super.key,
    required this.onPressed,
    required this.title,
    required this.buttonTitle,
  });

  final VoidCallback? onPressed;
  final String title;
  final String buttonTitle;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(title, style: TextStyle(color: Colors.grey)),
        TextButton(
          onPressed: onPressed,
          child: Text(
            buttonTitle,
            style: TextStyle(
              color: Color(0xFF8E9EFE),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
