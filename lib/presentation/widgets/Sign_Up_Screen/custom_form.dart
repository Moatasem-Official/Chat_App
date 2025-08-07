import 'package:chat_app/bussines_logic/cubits/cubit/auth_cubit.dart';
import 'package:chat_app/presentation/widgets/Login_Screen/custom_login_button.dart';
import 'package:chat_app/presentation/widgets/Login_Screen/custom_sign_up_link.dart';
import 'package:chat_app/presentation/widgets/Login_Screen/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomForm extends StatefulWidget {
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
  State<CustomForm> createState() => _CustomFormState();
}

class _CustomFormState extends State<CustomForm> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return AbsorbPointer(
      absorbing: isLoading,
      child: Expanded(
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
                    const SnackBar(
                      content: Text(
                        "تم التسجيل بنجاح , من فضلك افحص بريدك الالكتروني",
                      ),
                    ),
                  );
                } else if (state is AuthError) {
                  setState(() => isLoading = false);
                  if (state.message == 'weak-password') {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          "كلمة المرور يجب ان تكون على الاقل 6 حروف",
                        ),
                      ),
                    );
                  } else if (state.message == 'email-already-in-use') {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("هذا البريد الالكتروني مستخدم بالفعل"),
                      ),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("حدث خطأ غير متوقع، حاول مرة أخرى"),
                      ),
                    );
                  }
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
                        "أنشئ حسابك",
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "انضم إلينا وابدأ المحادثة",
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
                              icon: Icons.person_outline,
                              hint: "الاسم الكامل",
                              isPassword: false,
                              controller: widget.nameController,
                            ),
                            const SizedBox(height: 16),
                            CustomTextFormField(
                              icon: Icons.email_outlined,
                              hint: "البريد الإلكتروني",
                              isPassword: false,
                              controller: widget.emailController,
                            ),
                            const SizedBox(height: 16),
                            CustomTextFormField(
                              icon: Icons.lock_outline,
                              hint: "كلمة المرور",
                              isPassword: true,
                              controller: widget.passwordController,
                              isVisible: widget.isVisible,
                              onPressed: widget.onEyePressed,
                            ),
                            const SizedBox(height: 24),
                            // زر إنشاء الحساب
                            CustomLoginButton(
                              isLoading: isLoading,
                              title: "انشاء حساب",
                              onPressed: () {
                                if (widget.formKey.currentState!.validate()) {
                                  BlocProvider.of<AuthCubit>(context).signUp(
                                    email: widget.emailController.text,
                                    password: widget.passwordController.text,
                                  );
                                }
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
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
