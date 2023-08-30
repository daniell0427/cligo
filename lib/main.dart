import 'package:cligo/constants/routes.dart';
import 'package:cligo/view/chat_list_view.dart';
import 'package:cligo/view/chat_view.dart';
import 'package:cligo/view/greetings_view.dart';
import 'package:cligo/view/home_template.dart';
import 'package:cligo/view/login_view.dart';
import 'package:cligo/view/profile_view.dart';
import 'package:cligo/view/register_view.dart';
import 'package:cligo/view/verify_email_view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'firebase_options.dart';
import 'package:flutter/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  runApp(
    MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          // This is the theme of your application.
          primarySwatch: Colors.blue),
      home: const LayoutPage(),
      routes: {
        loginRoute: (context) => const Login(),
        registerRoute: (context) => const Register(),
        homeRoute: (context) => const HomeView(),
        profileRoute: (context) => const ProfileView(),
        verifyEmailRoute: (context) => const VerifyEmailView(),
        chatListRoute:(context) => const ChatListView(),
      },
    ),
  );
}

class LayoutPage extends StatelessWidget {
  const LayoutPage({super.key});
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
                  return GestureDetector(
                    child: const HomeView(),
                    onTap: () {
                      FocusScope.of(context).unfocus();
                    },
                  );
                } else {
                  return GestureDetector(
                    child: const Register(),
                    onTap: () {
                      FocusScope.of(context).unfocus();
                    },
                  );
                }
              } else {
                return GestureDetector(
                  child: const GreetingView(),
                  onTap: () {
                    FocusScope.of(context).unfocus();
                  },
                );
              }
            }
          default:
            return const CircularProgressIndicator();
        }
      },
    );
  }
}
