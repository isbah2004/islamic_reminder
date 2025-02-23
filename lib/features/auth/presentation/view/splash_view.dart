import 'dart:developer';

import 'package:azan_reminder/core/common/cubit/app_user/app_user_cubit.dart';
import 'package:azan_reminder/core/constants/exports.dart';
import 'package:azan_reminder/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocSelector<AuthBloc, AuthState, bool>(
        selector: (state) => state is AppUserLoggedIn,
        builder: (context, isAuthenticated) {
          log(isAuthenticated.toString());
          Timer(
            Duration(seconds: 2),
            // ignore: use_build_context_synchronously
            () {
              if (FirebaseAuth.instance.currentUser != null) { 
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  RoutesName.home,
                  (route) => false,
                );
              } else {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  RoutesName.auth,
                  (route) => false,
                );
              }
            },
          );

          return Image(
            image: AssetImage('assets/logo.png'),
            height: context.height,
            width: context.width,
          );
        },
      ),
    );
  }
}
