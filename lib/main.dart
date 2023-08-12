import 'package:cligo/view/login_view.dart';
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
      "/register/": (context) => const Register()
    },
  ));
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      body: FutureBuilder(
        future: Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform,
        ),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              {
                final user = FirebaseAuth.instance.currentUser;
                print(user);
                if (user != null) {
                  if (user.emailVerified) {
                    print('Email verified');
                  } else {
                    return const VerifyEmailView();
                  }
                } else {
                  return const Login();
                }
                return const Text("Done");
              }
            default:
              return const Text('Loading..');
          }
        },
      ),
    );
  }
}
