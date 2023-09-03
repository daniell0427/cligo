import 'package:cligo/constants/colors.dart';
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
        iconTheme: const IconThemeData(
          color: Pallete.colorDim4,
        ),
        backgroundColor: Pallete.colorDim0,
        elevation: 0,
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
      backgroundColor: Pallete.colorDim0,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(30, 100, 30, 0),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Pe adresa de email: $user am trimis un link de verificare',
                style: const TextStyle(color: Pallete.colorDim4, fontSize: 25),
              ),
              Row(
                children: [
                  const Text(
                    'Nu ați primit un cod?',
                    style: TextStyle(
                      color: Pallete.colorDim4,
                      fontSize: 20,
                    ),
                  ),
                  TextButton(
                    onPressed: () async {
                      final user = FirebaseAuth.instance.currentUser;
                      user?.sendEmailVerification();
                    },
                    child: const Text(
                      "Retrimite",
                      style: TextStyle(
                          color: Color.fromARGB(255, 90, 244, 205),
                          fontSize: 20),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
