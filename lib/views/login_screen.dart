import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../auth/login/bloc/login_bloc.dart';
import '../auth/signup/bloc/signup_bloc.dart';
import '../utils/app_colors.dart';
import '../widgets/app_text_form_field.dart';
import 'signin_screen.dart';

class LogIn extends StatelessWidget {
  const LogIn({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();

    return Center(
      child: Scaffold(
        body: BlocConsumer<LoginBloc, LoginState>(
          listener: (context, state) {
            if (state is LoginSuccessState) {
              Fluttertoast.showToast(
                msg: "LogIn Successful!",
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 4,
              );
            } else if (state is LoginFailureState) {
              Fluttertoast.showToast(
                msg: 'Failed to LogIn: ${state.error}',
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.CENTER,
                backgroundColor: Colors.red[400],
                webBgColor: 'linear-gradient(to right, #FF0000, #a03533)',
                timeInSecForIosWeb: 4,
              );
            }
          },
          builder: (context, state) {
            return Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          Text(
                            'Welcome Back',
                            style: Theme.of(context).textTheme.displayLarge,
                          ),
                          Text(
                            'Login',
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                        ],
                      ),

                      SizedBox(
                        width: 300,

                        child: Column(
                          spacing: 15,
                          children: [
                            AppTextField(
                              controller: emailController,
                              prefixIcon: Icon(Icons.mail),
                              textContent: 'email',
                            ),

                            AppTextField(
                              controller: passwordController,
                              prefixIcon: Icon(Icons.lock),
                              textContent: 'Password',
                              obscureText: true,
                            ),

                            ElevatedButton(
                              onPressed: () {
                                BlocProvider.of<LoginBloc>(context).add(
                                  LoginInitialEvent(
                                    email: emailController.text.trim(),
                                    password: passwordController.text.trim(),
                                  ),
                                );
                              },
                              child: Text('LOGIN'),
                            ),
                          ],
                        ),
                      ),

                      Text(
                        'Forgot Password?',
                        style: TextStyle(color: AppColors.mainColor),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Don\'t have an account?'),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SignIn(),
                                ),
                              );
                            },
                            child: Text('Sign Up'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                if (state is SignupLoadingState)
                  const Center(child: CircularProgressIndicator()),
              ],
            );
          },
        ),
      ),
    );
  }
}
