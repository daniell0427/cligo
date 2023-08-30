import 'package:cligo/constants/routes.dart';
import 'package:cligo/database/read_data/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  //controllers
  late final TextEditingController _email;
  late final TextEditingController _password;
  late final TextEditingController _confirmPassword;
  late final TextEditingController _name;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    _name = TextEditingController();
    _confirmPassword = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    _name.dispose();
    _confirmPassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Padding(
          padding: const EdgeInsets.all(50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //Title
              const Padding(
                padding: EdgeInsets.only(
                  bottom: 15.0,
                ),
                child: Text(
                  'Înregistrare',
                  style: TextStyle(
                    fontSize: 45,
                    color: Colors.white,
                  ),
                ),
              ),

              //Name textfield
              TextField(
                style: const TextStyle(color: Colors.white),
                controller: _name,
                autocorrect: false,
                enableSuggestions: true,
                decoration: const InputDecoration(
                  hintText: 'ex: Artene Alex',
                  hintStyle: TextStyle(color: Colors.grey),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white)),
                  labelText: 'Nume',
                  labelStyle: TextStyle(fontSize: 20, color: Colors.white),
                ),
              ),

              //Email Textfield
              Padding(
                padding: const EdgeInsets.only(top: 15),
                child: TextField(
                  style: const TextStyle(color: Colors.white),
                  controller: _email,
                  autocorrect: false,
                  enableSuggestions: false,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    hintText: 'example@gmail.com',
                    hintStyle: TextStyle(color: Colors.grey),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white)),
                    labelText: 'Email',
                    labelStyle: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                ),
              ),

              //password textfield
              Padding(
                padding: const EdgeInsets.only(top: 15),
                child: TextField(
                  style: const TextStyle(color: Colors.white),
                  controller: _password,
                  obscureText: true,
                  autocorrect: false,
                  enableSuggestions: false,
                  decoration: const InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white)),
                    labelText: 'Parola',
                    labelStyle: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                ),
              ),

              //confirm password textfield
              Padding(
                padding: const EdgeInsets.only(top: 15),
                child: TextField(
                  style: const TextStyle(color: Colors.white),
                  controller: _confirmPassword,
                  obscureText: true,
                  autocorrect: false,
                  enableSuggestions: false,
                  decoration: const InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white)),
                    labelText: 'Confirmă Parola',
                    labelStyle: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                ),
              ),

              //Button && createuser
              TextButton(
                onPressed: () async {
                  final name = _name.text;
                  final email = _email.text;
                  final password = _password.text;
                  final confirmPassword = _confirmPassword.text;

                  //confirm pass verification => create user
                  if (password == confirmPassword) {
                    UserCredential userCredentials = await FirebaseAuth.instance
                        .createUserWithEmailAndPassword(
                      email: email,
                      password: password,
                    );
                    //get uid
                    final uid = userCredentials.user!.uid;

                    //push user credentials to database
                    pushUserData(uid, name, email);

                    //send email verification and navigate to verify_email_view
                    final currentUser = FirebaseAuth.instance.currentUser;
                    currentUser?.sendEmailVerification();
                    Navigator.of(context).pushNamedAndRemoveUntil(
                      verifyEmailRoute,
                      (route) => false,
                    );
                  }

                  //if incorect password
                  else {
                    print('Parola incorecta');
                    _password.clear();
                    _confirmPassword.clear();
                  }
                },
                child: const Text('Înregistrează-te'),
              ),

              //already registered text
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Ești deja înregistrat?',
                    style: TextStyle(color: Colors.white),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        loginRoute,
                        (route) => false,
                      );
                    },
                    child: const Text('Autentifică-te'),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
