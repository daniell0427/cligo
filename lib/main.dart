import 'package:cligo/view/home_view.dart';
import 'package:cligo/view/login_view.dart';
import 'package:cligo/view/profile_view.dart';
import 'package:cligo/view/register_view.dart';
import 'package:cligo/view/verify_email_view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'firebase_options.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MaterialApp(
    title: 'Flutter Demo',
    theme: ThemeData(
        // This is the theme of your application.
        primarySwatch: Colors.blue),
    home: const HomePage(),
    routes: {
      "/login/": (context) => const Login(),
      "/register/": (context) => const Register(),
      "/home/": (context) => const HomeView(),
      "/profile/": (context) => const ProfileView()
    },
  ));
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      ),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.done:
            {
              final user = FirebaseAuth.instance.currentUser;
              if (user != null) {
                if (user.emailVerified) {
                  return const HomeView();
                } else {
                  return const VerifyEmailView();
                }
              } else {
                return const Login();
              }
            }
          default:
            return const CircularProgressIndicator();
        }
      },
    );
  }
}
