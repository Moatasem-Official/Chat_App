import 'package:chat_app/presentation/widgets/Login_Screen/custom_login_button.dart';
import 'package:chat_app/presentation/widgets/Login_Screen/custom_sign_up_link.dart';
import 'package:chat_app/presentation/widgets/Login_Screen/custom_text_form_field.dart';
import 'package:flutter/material.dart';

class CustomForm extends StatelessWidget {
  const CustomForm({
    super.key,
    required this.isVisible,
    required this.onEyePressed,
    required this.fadeAnimation,
    required this.slideAnimation,
    required this.formKey,
    required this.nameController,
    required this.emailController,
    required this.passwordController,
  });

  final GlobalKey<FormState> formKey;
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final bool isVisible;
  final VoidCallback onEyePressed;
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
                  "أنشئ حسابك",
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text(
                  "انضم إلينا وابدأ المحادثة",
                  style: TextStyle(fontSize: 16, color: Colors.grey.shade600),
                ),
                const SizedBox(height: 24),
                // حقول الإدخال
                Form(
                  key: formKey,
                  child: Column(
                    children: [
                      CustomTextFormField(
                        icon: Icons.person_outline,
                        hint: "الاسم الكامل",
                        isPassword: false,
                        controller: nameController,
                      ),
                      const SizedBox(height: 16),
                      CustomTextFormField(
                        icon: Icons.email_outlined,
                        hint: "البريد الإلكتروني",
                        isPassword: false,
                        controller: emailController,
                      ),
                      const SizedBox(height: 16),
                      CustomTextFormField(
                        icon: Icons.lock_outline,
                        hint: "كلمة المرور",
                        isPassword: true,
                        controller: passwordController,
                        isVisible: isVisible,
                        onPressed: onEyePressed,
                      ),
                      const SizedBox(height: 24),
                      // زر إنشاء الحساب
                      CustomLoginButton(
                        title: "انشاء حساب",
                        onPressed: () {
                          if (formKey.currentState!.validate()) {}
                        },
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                // رابط الانتقال لصفحة تسجيل الدخول
                CustomSignUpLink(
                  title: "لديك حساب بالفعل ؟ ",
                  buttonTitle: "تسجيل الدخول",
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
