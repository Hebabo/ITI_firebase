import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

import 'auth/login/bloc/login_bloc.dart';
import 'utils/app_themes.dart';
import 'views/main_navigation.dart';
import 'auth/bloc_screens/counter_bloc/counter_bloc.dart';
import 'auth/signup/bloc/signup_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  ).then((_)=>runApp(const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => CounterBloc()),
        BlocProvider(create: (context) => SignupBloc()), // <-- Add this
        BlocProvider(create: (context) => LoginBloc()), // <-- Add this
      ],
      child: MaterialApp(
        theme: AppTheme.lightTheme,
        debugShowCheckedModeBanner: false,
        home: MainNavigation(), 
      ),
    );
  }
}


