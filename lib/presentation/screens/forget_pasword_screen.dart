import 'package:chat_app/bussines_logic/cubits/auth/auth_cubit.dart';
import 'package:chat_app/presentation/widgets/Login_Screen/custom_login_button.dart';
import 'package:chat_app/presentation/widgets/Login_Screen/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ForgetPaswordScreen extends StatefulWidget {
  const ForgetPaswordScreen({super.key});

  @override
  State<ForgetPaswordScreen> createState() => _ForgetPaswordScreenState();
}

class _ForgetPaswordScreenState extends State<ForgetPaswordScreen> {
  TextEditingController emailController = TextEditingController();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        surfaceTintColor: Colors.white,
        title: const Text(
          "Forget Password",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthLoading) {
            setState(() => isLoading = true);
          } else if (state is AuthSuccess) {
            setState(() => isLoading = false);
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                backgroundColor: Colors.green,
                margin: EdgeInsets.all(20),
                behavior: SnackBarBehavior.floating,
                content: Text(
                  "Email Sent Successfully!, Check Your Email Box.",
                ),
              ),
            );
            Navigator.pop(context);
          } else if (state is AuthError) {
            setState(() => isLoading = false);
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Please Enter Your Email Address To Receive Link To Reset Your Password",
                style: TextStyle(color: Colors.grey, fontSize: 16),
              ),
              const SizedBox(height: 50),
              CustomTextFormField(
                icon: Icons.email,
                hint: "Email",
                isPassword: false,
                controller: emailController,
              ),
              const SizedBox(height: 50),
              CustomLoginButton(
                onPressed: () {
                  if (emailController.text.isNotEmpty) {
                    BlocProvider.of<AuthCubit>(
                      context,
                    ).resetPassword(emailController.text);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        backgroundColor: Colors.red,
                        margin: EdgeInsets.all(20),
                        behavior: SnackBarBehavior.floating,
                        content: Text("Please Enter Your Email Address"),
                      ),
                    );
                  }
                },
                title: "Send",
                isLoading: isLoading,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
