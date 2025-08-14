import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../auth/signup/bloc/signup_bloc.dart';
import '../widgets/app_text_form_field.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController userNameController = TextEditingController();
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    final TextEditingController confirmPasswordController =
        TextEditingController();

    return Scaffold(
      body: BlocConsumer<SignupBloc, SignupState>(
        listener: (context, state) {
          if (state is SignupSuccessState) {
            Fluttertoast.showToast(
              msg: "Signup Successful!",
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 4,
            );
            Navigator.pop(context);
          } else if (state is SignupFailureState) {
            Fluttertoast.showToast(
              msg: 'Failed to sign up: ${state.error}',
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              backgroundColor: Colors.red[400],
              webBgColor: 'linear-gradient(to right, #FF0000, #a03533)',
              timeInSecForIosWeb: 4,
            );
          }
        },
        builder: (context, state) {
          return Stack(
            children: [
              // Main form
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        Text(
                          'Sign Up',
                          style: Theme.of(context).textTheme.displayLarge,
                        ),
                        Text(
                          'Create an account',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        spacing: 15,
                        children: [
                          AppTextField(
                            controller: userNameController,
                            prefixIcon: const Icon(Icons.person),
                            textContent: "Username",
                          ),
                          AppTextField(
                            controller: emailController,
                            prefixIcon: const Icon(Icons.email),
                            textContent: "Email",
                          ),
                          AppTextField(
                            controller: passwordController,
                            prefixIcon: const Icon(Icons.lock),
                            textContent: 'Password',
                            obscureText: true,
                          ),
                          AppTextField(
                            controller: confirmPasswordController,
                            textContent: "Confirm Password",
                            obscureText: true,
                            prefixIcon: const Icon(Icons.lock),
                          ),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {
                                BlocProvider.of<SignupBloc>(context).add(
                                  SignupInitialEvent(
                                    username: userNameController.text.trim(),
                                    email: emailController.text.trim(),
                                    password: passwordController.text.trim(),
                                    confirmPassword: confirmPasswordController
                                        .text
                                        .trim(),
                                  ),
                                );
                              },
                              child: const Text("Sign Up"),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Already have an account?",
                          style: Theme.of(context).textTheme.labelMedium,
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text("Login"),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Loading overlay
              if (state is SignupLoadingState)
                const Center(child: CircularProgressIndicator(strokeWidth: 6)),
            ],
          );
        },
      ),
    );
  }
}
