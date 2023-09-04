import 'package:cligo/constants/routes.dart';
import 'package:flutter/material.dart';
import 'package:cligo/constants/variables.dart';

class VerifyEmailView extends StatefulWidget {
  const VerifyEmailView({super.key});

  @override
  State<VerifyEmailView> createState() => _VerifyEmailViewState();
}

class _VerifyEmailViewState extends State<VerifyEmailView> {
  @override
  Widget build(BuildContext context) {
    //get variables
    variables();
    
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
              'Pe adresa de email: $currentUserEmail am trimis un link de verificare',
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
                    currentUser?.sendEmailVerification();
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
