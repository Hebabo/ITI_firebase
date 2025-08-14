import 'package:firebaseiti/auth/login/bloc/login_bloc.dart';
import 'package:firebaseiti/auth/profile/bloc/profile_bloc.dart';
import 'package:firebaseiti/views/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is LogoutState) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => LoginPage()),
            (route) => false,
          );
        }
      },
      builder: (context, state) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: CircleAvatar(
                backgroundImage: NetworkImage(
                  'https://www.themealdb.com/images/category/beef.png',
                ),
                radius: 24,
              ),
            ),
            Text(
              'profile screen',
              style: Theme.of(context).textTheme.labelMedium,
            ),
            ElevatedButton(
              onPressed: () {
                context.read<LoginBloc>().add(LoginLogoutEvent());
              },
              child: Text('Logout'),
            ),
          ],
        );
      },
    );
  }
}
