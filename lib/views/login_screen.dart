import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebaseiti/utils/my_flutter_app_icons.dart';
import 'package:firebaseiti/views/main_navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../auth/login/bloc/login_bloc.dart';
import '../auth/signup/bloc/signup_bloc.dart';
import '../utils/app_colors.dart';
import '../widgets/app_text_form_field.dart';
import 'signup_screen.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalObjectKey<FormState> formKey = GlobalObjectKey<FormState>(
      'loginForm',
    );
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();

    return Center(
      child: Scaffold(
        body: BlocConsumer<LoginBloc, LoginState>(
          listener: (context, state) {
            if (state is LoginSuccessState) {
              if (FirebaseAuth.instance.currentUser!.emailVerified) {
                Fluttertoast.showToast(
                  msg: "LogIn Successful!",
                  toastLength: Toast.LENGTH_LONG,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 4,
                );

                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MainNavigation()),
                );
              } else {
                Fluttertoast.showToast(
                  msg: "Please verify your email address.",
                  toastLength: Toast.LENGTH_LONG,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 4,
                );
              }
            } else if (state is LoginFailureState) {
              Fluttertoast.showToast(
                msg: 'Failed to LogIn: ${state.error}',
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
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                        ],
                      ),

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          spacing: 15,
                          children: [
                            Form(
                              key: formKey,
                              child: Column(
                                children: [
                                  AppTextField(
                                    controller: emailController,
                                    prefixIcon: Icon(Icons.mail),
                                    textContent: 'Email',
                                  ),

                                  AppTextField(
                                    controller: passwordController,
                                    prefixIcon: Icon(Icons.lock),
                                    textContent: 'Password',
                                    obscureText: true,
                                  ),

                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: TextButton(
                                      onPressed: () {
                                        // Navigate to Forgot Password Screen
                                        Navigator.pushNamed(
                                          context,
                                          '/forgot-password',
                                        );
                                      },
                                      child: Text(
                                        'Forgot Password?',
                                        style: TextStyle(
                                          color: AppColors.mainColor,
                                        ),
                                      ),
                                    ),
                                  ),

                                  SizedBox(
                                    width: double.infinity,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        BlocProvider.of<LoginBloc>(context).add(
                                          LoginInitialEvent(
                                            email: emailController.text.trim(),
                                            password: passwordController.text
                                                .trim(),
                                          ),
                                        );
                                      },
                                      child: (state is LoginLoadingState)
                                          ? SizedBox(
                                              height: 20,
                                              width: 20,
                                              child:
                                                  CircularProgressIndicator(),
                                            )
                                          : Text(
                                              'LOGIN',
                                              style: Theme.of(
                                                context,
                                              ).textTheme.bodyMedium,
                                            ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Text(
                              'or',
                              style: Theme.of(context).textTheme.titleSmall,
                            ),
                            SizedBox(
                              height: 50,
                              child: ElevatedButton(
                                onPressed: () {
                                  // BlocProvider.of<SignupBloc>(context).add(
                                  //   SignupGoogleEvent(),
                                  // );
                                },
                                style: Theme.of(context)
                                    .elevatedButtonTheme
                                    .style!
                                    .copyWith(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                            Colors.grey[200],
                                          ),
                                    ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  spacing: 10,

                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'login with Google',
                                      style: Theme.of(
                                        context,
                                      ).textTheme.bodyMedium,
                                    ),
                                    Icon(
                                      MyFlutterAppIcons.google,
                                      color: AppColors.googleButtonColor,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Don\'t have an account?',
                            style: Theme.of(context).textTheme.labelMedium,
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SignupScreen(),
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
                // if (state is LoginLoadingState)
                //   Center(child: CircularProgressIndicator()),
              ],
            );
          },
        ),
      ),
    );
  }
}
