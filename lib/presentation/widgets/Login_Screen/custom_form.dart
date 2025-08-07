import 'package:chat_app/bussines_logic/cubits/cubit/auth_cubit.dart';
import 'package:chat_app/presentation/screens/home_screen.dart';
import 'package:chat_app/presentation/screens/sign_up_screen.dart';
import 'package:chat_app/presentation/widgets/Login_Screen/custom_login_button.dart';
import 'package:chat_app/presentation/widgets/Login_Screen/custom_sign_up_link.dart';
import 'package:chat_app/presentation/widgets/Login_Screen/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomForm extends StatefulWidget {
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
  State<CustomForm> createState() => _CustomFormState();
}

class _CustomFormState extends State<CustomForm> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 3,
      child: FadeTransition(
        opacity: widget.fadeAnimation,
        child: SlideTransition(
          position: widget.slideAnimation,
          child: BlocConsumer<AuthCubit, AuthState>(
            listener: (context, state) {
              if (state is AuthLoading) {
                setState(() => isLoading = true);
              } else if (state is AuthSuccess) {
                setState(() => isLoading = false);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("تم تسجيل الدخول بنجاح")),
                );
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ChatHomeScreen(),
                  ),
                );
              }
              if (state is AuthError) {
                setState(() => isLoading = false);
                String errorMessage;

                switch (state.message) {
                  case 'user-not-found':
                    errorMessage = "البريد الإلكتروني غير مسجل";
                    break;
                  case 'wrong-password':
                    errorMessage = "كلمة المرور غير صحيحة";
                    break;
                  case 'invalid-credentials':
                    errorMessage = "البريد الإلكتروني أو كلمة المرور غير صحيحة";
                    break;
                  case 'too-many-requests':
                    errorMessage = "لقد حاولت كثيرًا. حاول لاحقًا.";
                    break;
                  case 'unknown-error':
                    errorMessage = "حدث خطأ غير متوقع، حاول مرة أخرى";
                    break;
                  default:
                    errorMessage = "حدث خطأ: ${state.message}";
                }

                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text(errorMessage)));
              }
            },
            builder: (context, state) {
              return Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 24,
                ),
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
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "سجل الدخول للمتابعة",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey.shade600,
                      ),
                    ),
                    const SizedBox(height: 24),
                    // حقول الإدخال
                    Form(
                      key: widget.formKey,
                      child: Column(
                        children: [
                          CustomTextFormField(
                            icon: Icons.email_outlined,
                            hint: "البريد الإلكتروني",
                            controller: widget.emailController,
                            isPassword: false,
                          ),
                          const SizedBox(height: 16),
                          CustomTextFormField(
                            icon: Icons.lock_outline,
                            hint: "كلمة المرور",
                            isPassword: true,
                            isVisible: widget.isVisible,
                            controller: widget.passwordController,
                            onPressed: widget.onEyePressed,
                          ),
                          const SizedBox(height: 24),
                          // زر تسجيل الدخول
                          CustomLoginButton(
                            isLoading: isLoading,
                            title: "تسجيل الدخول",
                            onPressed: () {
                              if (widget.formKey.currentState!.validate()) {
                                context.read<AuthCubit>().signIn(
                                  email: widget.emailController.text,
                                  password: widget.passwordController.text,
                                );
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    // رابط إنشاء حساب جديد
                    CustomSignUpLink(
                      title: "ليس لديك حساب ؟ ",
                      buttonTitle: "انشاء حساب",
                      onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SignUpScreen(),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
