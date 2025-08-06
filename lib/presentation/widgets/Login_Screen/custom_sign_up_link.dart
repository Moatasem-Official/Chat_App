import 'package:flutter/material.dart';

class CustomSignUpLink extends StatelessWidget {
  const CustomSignUpLink({super.key, required this.onPressed});

  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("ليس لديك حساب ؟", style: TextStyle(color: Colors.grey)),
        TextButton(
          onPressed: onPressed,
          child: const Text(
            "أنشئ حسابًا",
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
