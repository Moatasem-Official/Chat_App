import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    required this.icon,
    required this.hint,
    this.isVisible,
    this.onPressed,
    required this.isPassword,
    required this.controller,
  });

  final IconData icon;
  final String hint;
  final bool isPassword;
  final bool? isVisible;
  final VoidCallback? onPressed;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: isPassword ? isVisible! : false,
      decoration: InputDecoration(
        hintText: hint,
        prefixIcon: Icon(icon, color: Colors.grey.shade500),
        suffixIcon: isPassword
            ? IconButton(
                icon: Icon(
                  isVisible! ? Icons.visibility : Icons.visibility_off,
                  color: Colors.grey.shade500,
                ),
                onPressed: onPressed,
              )
            : null,
        filled: true,
        fillColor: Colors.grey.shade100,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please Enter $hint';
        }
        return null;
      },
    );
  }
}
