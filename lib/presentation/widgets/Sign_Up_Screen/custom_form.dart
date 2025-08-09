import 'package:chat_app/bussines_logic/cubits/auth/auth_cubit.dart';
import 'package:chat_app/helpers/error_handler.dart';
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
    return Expanded(
      flex: 4,
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
                      "Account Created Successfully, Please Check Your Email Box For Verification.",
                    ),
                  ),
                );
              } else if (state is AuthError) {
                setState(() => isLoading = false);
                String errorMessage = ErrorHandler.firebaseHandler(
                  state.message,
                )!;
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
                      "Create Account",
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "Join Us And Start Chatting With Your Friends.",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey.shade600,
                      ),
                    ),
                    const SizedBox(height: 24),
                    Form(
                      key: widget.formKey,
                      child: Column(
                        children: [
                          CustomTextFormField(
                            icon: Icons.person_outline,
                            hint: "Full Name",
                            isPassword: false,
                            controller: widget.nameController,
                          ),
                          const SizedBox(height: 16),
                          CustomTextFormField(
                            icon: Icons.email_outlined,
                            hint: "Email",
                            isPassword: false,
                            controller: widget.emailController,
                          ),
                          const SizedBox(height: 16),
                          CustomTextFormField(
                            icon: Icons.lock_outline,
                            hint: "Password",
                            isPassword: true,
                            controller: widget.passwordController,
                            isVisible: widget.isVisible,
                            onPressed: widget.onEyePressed,
                          ),
                          const SizedBox(height: 24),
                          CustomLoginButton(
                            isLoading: isLoading,
                            title: "SIGN UP",
                            onPressed: () {
                              if (widget.formKey.currentState!.validate()) {
                                BlocProvider.of<AuthCubit>(context).signUp(
                                  email: widget.emailController.text,
                                  name: widget.nameController.text,
                                  password: widget.passwordController.text,
                                );
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    CustomSignUpLink(
                      title: "Already have an account ?",
                      buttonTitle: "LOG IN",
                      onPressed: () => Navigator.of(context).pop(),
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
