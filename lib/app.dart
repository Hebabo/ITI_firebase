// import 'package:firebaseiti/auth/bloc_screens/counter_bloc/counter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebaseiti/auth/login/bloc/login_bloc.dart';
import 'package:firebaseiti/auth/profile/bloc/profile_bloc.dart';
import 'package:firebaseiti/auth/signup/bloc/signup_bloc.dart';
import 'package:firebaseiti/utils/app_themes.dart';
import 'package:firebaseiti/views/home_page_screen.dart';
import 'package:firebaseiti/views/login_screen.dart';
import 'package:firebaseiti/views/main_navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ArtGallery extends StatelessWidget {
  const ArtGallery({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => SignupBloc()),
        BlocProvider(create: (context) => LoginBloc()),
        BlocProvider(create: (context) => ProfileBloc()),
      ],
      child: MaterialApp(
        theme: AppTheme.lightTheme,
        debugShowCheckedModeBanner: false,
        
        home: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),

          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return const Center(child: Text('Error occurred'));
            } else if (snapshot.hasData &&
                FirebaseAuth.instance.currentUser!.emailVerified) {
              return const MainNavigation();
            } else {
              return const LoginPage();
            }
          },
        ),
      ),
    );
  }
}
