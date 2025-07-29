import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../auth/signup/bloc/signup_bloc.dart';
import '../widgets/app_text_form_field.dart';

class SignIn extends StatelessWidget {
  const SignIn({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController userNameController = TextEditingController();
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    final TextEditingController confirmPasswordController =
        TextEditingController();

    return Center(
      child: Scaffold(
        body: BlocConsumer<SignupBloc, SignupState>(
          listener: (context, state) {
            if (state is SignupSuccessState) {
              Fluttertoast.showToast(
                msg: "Signup Successful!",
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 4,
              );
              Navigator.pop(context);
            } else if (state is SignupFailureState) {
              Fluttertoast.showToast(
                msg: 'Failed to sign up: ${state.error}',
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.CENTER,
                backgroundColor: Colors.red[400],
                webBgColor: 'linear-gradient(to right, #FF0000, #a03533)',
                timeInSecForIosWeb: 4,
              );
            }
          },
          builder: (context, state) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Stack(
                  children: [
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: SizedBox(
                          width: 300,
                          child: Column(
                            spacing: 15,
                            children: [
                              Text(
                                'Sign Up',
                                style: Theme.of(context).textTheme.displayLarge,
                              ),
                              Text(
                                'Create anaccount',
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                              AppTextField(
                                controller: userNameController,
                                prefixIcon: Icon(Icons.person),
                                textContent: "Username",
                              ),
                              AppTextField(
                                controller: emailController,
                                prefixIcon: Icon(Icons.email),
                                textContent: "Email",
                              ),
                              AppTextField(
                                controller: passwordController,
                                prefixIcon: Icon(Icons.lock),
                                textContent: 'Password',
                                obscureText: true,
                              ),
                              AppTextField(
                                controller: confirmPasswordController,
                                textContent: "Confirm Password",
                                obscureText: true,
                                prefixIcon: Icon(Icons.lock),
                              ),
                              ElevatedButton(
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
                              Text('or'),
                              ElevatedButton(
                                onPressed: () {
                                  BlocProvider.of<SignupBloc>(
                                    context,
                                  ).add(SignupSuccessEvent());
                                },
                                child: const Text("SignIn with google"),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text("Already have an account?"),
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
                      ),
                    ),
                    // if (state is SignupLoadingState)
                    //   const Column(
                    //     crossAxisAlignment: CrossAxisAlignment.center,
                    //     mainAxisAlignment: MainAxisAlignment.center,
                    //     children: [CircularProgressIndicator()],
                    //   ),
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
