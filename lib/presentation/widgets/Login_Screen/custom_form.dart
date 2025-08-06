import 'package:chat_app/presentation/screens/sign_up_screen.dart';
import 'package:chat_app/presentation/widgets/Login_Screen/custom_login_button.dart';
import 'package:chat_app/presentation/widgets/Login_Screen/custom_sign_up_link.dart';
import 'package:chat_app/presentation/widgets/Login_Screen/custom_text_form_field.dart';
import 'package:flutter/material.dart';

class CustomForm extends StatelessWidget {
  const CustomForm({
    super.key,
    required this.formKey,
    required this.emailController,
    required this.passwordController,
    this.isVisible,
    this.onEyePressed,
    required this.fadeAnimation,
    required this.slideAnimation,
  });

  final GlobalKey<FormState> formKey;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final bool? isVisible;
  final VoidCallback? onEyePressed;
  final Animation<double> fadeAnimation;
  final Animation<Offset> slideAnimation;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 3,
      child: FadeTransition(
        opacity: fadeAnimation,
        child: SlideTransition(
          position: slideAnimation,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40),
                topRight: Radius.circular(40),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "أهلاً بعودتك!",
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text(
                  "سجل الدخول للمتابعة",
                  style: TextStyle(fontSize: 16, color: Colors.grey.shade600),
                ),
                const SizedBox(height: 24),
                // حقول الإدخال
                Form(
                  key: formKey,
                  child: Column(
                    children: [
                      CustomTextFormField(
                        icon: Icons.email_outlined,
                        hint: "البريد الإلكتروني",
                        controller: emailController,
                        isPassword: false,
                      ),
                      const SizedBox(height: 16),
                      CustomTextFormField(
                        icon: Icons.lock_outline,
                        hint: "كلمة المرور",
                        isPassword: true,
                        isVisible: isVisible,
                        controller: passwordController,
                        onPressed: onEyePressed,
                      ),
                      const SizedBox(height: 24),
                      // زر تسجيل الدخول
                      CustomLoginButton(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {}
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                // رابط إنشاء حساب جديد
                CustomSignUpLink(
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SignUpScreen(),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
