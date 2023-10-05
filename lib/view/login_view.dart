import 'package:cligo/constants/images.dart';
import 'package:cligo/constants/routes.dart';
import 'package:cligo/constants/variables.dart';
import 'package:cligo/features/create_snackbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cligo/constants/colors.dart';
import 'dart:developer' as devtools show log;

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  late final TextEditingController _email;
  late final TextEditingController _password;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        backgroundColor: Pallete.colorDim0,
        body: Center(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(40, 0, 40, 0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //!Logo
                 CircleAvatar(
                  radius: 60,
                  backgroundColor: Colors.transparent,
                  backgroundImage: AssetImage(placeHolderLogo) as ImageProvider,
                ),
                //!title
                const Text(
                  'Conectează-te',
                  style: TextStyle(
                    fontSize: 40,
                    color: Pallete.colorDim4,
                  ),
                ),

                //!email
                Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: TextField(
                    style:
                        const TextStyle(color: Pallete.colorDim4, fontSize: 20),
                    controller: _email,
                    autocorrect: false,
                    enableSuggestions: false,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      prefixIcon: Padding(
                        padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                        child: Icon(
                          Icons.email,
                          color: Pallete.colorDim4,
                          size: 25,
                        ),
                      ),
                      hintText: 'exemplu@gmail.com',
                      hintStyle: TextStyle(color: Pallete.colorGray),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        borderSide:
                            BorderSide(color: Pallete.colorDim4, width: 2),
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide:
                              BorderSide(color: Pallete.colorDim4, width: 2)),
                      labelText: 'Email',
                      labelStyle: TextStyle(
                        fontSize: 20,
                        color: Pallete.colorDim4,
                      ),
                    ),
                  ),
                ),

                //!password
                Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: TextField(
                    style:
                        const TextStyle(color: Pallete.colorDim4, fontSize: 20),
                    controller: _password,
                    obscureText: true,
                    autocorrect: false,
                    enableSuggestions: false,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      prefixIcon: Padding(
                        padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                        child: Icon(
                          Icons.lock,
                          color: Pallete.colorDim4,
                          size: 30,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        borderSide:
                            BorderSide(color: Pallete.colorDim4, width: 2),
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide:
                              BorderSide(color: Pallete.colorDim4, width: 2)),
                      labelText: 'Parola',
                      labelStyle:
                          TextStyle(fontSize: 20, color: Pallete.colorDim4),
                    ),
                  ),
                ),
                //!button
                Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: SizedBox(
                    height: 55,
                    width: double.infinity,
                    child: TextButton(
                      style: ButtonStyle(
                        foregroundColor:
                            MaterialStateProperty.all(Pallete.colorDim0),
                        backgroundColor:
                            MaterialStateProperty.all(Pallete.colorDim4),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          // side:
                          //     const BorderSide(color: Pallete.colorDim0, width: 2),
                        )),
                      ),
                      onPressed: () async {
                        //controllers
                        final email = _email.text;
                        final password = _password.text;

                        SnackBar? message;

                        //sign in method
                        try {
                          await fireauth.signInWithEmailAndPassword(
                            email: email,
                            password: password,
                          );

                          variables();

                          //email verified => homeView
                          if (currentUser?.emailVerified ?? false) {
                            Navigator.pushNamedAndRemoveUntil(
                              context,
                              homeRoute,
                              (_) => false,
                            );
                          }

                          //email not verified => verifyEmailView
                          else {
                            Navigator.pushNamedAndRemoveUntil(
                              context,
                              verifyEmailRoute,
                              (_) => false,
                            );

                            message = const SnackBar(
                              content: Text(
                                'Verifică email!',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            );
                          }
                        } on FirebaseAuthException catch (e) {
                          _password.clear(); //clear password field

                          //user not found
                          if (e.code == 'user-not-found') {
                            message = const SnackBar(
                              content: Text(
                                'Cont inexistent!',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            );
                          }

                          //wrong password
                          else if (e.code == 'wrong-password') {
                            message = const SnackBar(
                              content: Text(
                                'Parolă incorectă!',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            );
                          }

                          //invalid email
                          else if (e.code == 'invalid-email') {
                            message = const SnackBar(
                              content: Text(
                                'Email invalid!',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            );
                          }

                          //other errors
                          else {
                            _password.clear(); //clear password field

                            message = const SnackBar(
                              content: Text(
                                'Ceva neașteptat s-a întâmplat!',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            );
                            devtools.log(
                                'Something unexpected happened: Error: ${e.code}');
                          }
                        }

                        //catch other errors
                        catch (e) {
                          message = const SnackBar(
                            content: Text(
                              'Ceva neașteptat s-a întâmplat!',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          );
                          devtools
                              .log('Something unexpected happened: Error: $e');
                        }

                        if (message != null) {
                          createSnackbar(context, message);
                        }
                      },
                      child: const Text(
                        'Conectare',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                  ),
                ),

                //!are you new here
                Padding(
                  padding: const EdgeInsets.only(top: 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Ești nou aici??',
                        style:
                            TextStyle(color: Pallete.colorDim4, fontSize: 15),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamedAndRemoveUntil(
                            context,
                            registerRoute,
                            (route) => false,
                          );
                        },
                        child: const Text(
                          'Înregistrează-te',
                          style:
                              TextStyle(fontSize: 15, color: Pallete.colorDim2),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
