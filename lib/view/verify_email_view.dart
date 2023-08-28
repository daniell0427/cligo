import 'package:cligo/constants/routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class VerifyEmailView extends StatefulWidget {
  const VerifyEmailView({super.key});

  @override
  State<VerifyEmailView> createState() => _VerifyEmailViewState();
}

class _VerifyEmailViewState extends State<VerifyEmailView> {
  final user = FirebaseAuth.instance.currentUser?.email;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: IconButton(
          onPressed: () {
            Navigator.of(context).pushNamedAndRemoveUntil(
              loginRoute,
              (_) => false,
            );
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
      ),
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          children: [
            Text(
              'Pe adresa de email: $user am trimis un link de verificare',
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
            Row(
              children: [
                const Text(
                  'Nu ați primit un cod?',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                TextButton(
                  onPressed: () async {
                    final user = FirebaseAuth.instance.currentUser;
                    user?.sendEmailVerification();
                  },
                  child: const Text("Retrimite"),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
