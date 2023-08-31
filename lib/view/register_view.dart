import 'package:cligo/constants/routes.dart';
import 'package:cligo/database/read_data/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cligo/constants/colors.dart';
import 'package:cligo/constants/images.dart';

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
        backgroundColor: Pallete.colorDim0,
        body: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(40, 0, 40, 0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CircleAvatar(
                    radius: 60,
                    backgroundColor: Colors.transparent,
                    backgroundImage: AssetImage(placeHolderLogo),
                  ),

                  //!Title
                  const Padding(
                    padding: EdgeInsets.only(
                      bottom: 15.0,
                    ),
                    child: Text(
                      'Înregistrare',
                      style: TextStyle(
                        fontSize: 40,
                        color: Pallete.colorDim4,
                      ),
                    ),
                  ),

                  //!Name textfield
                  TextField(
                    style:
                        const TextStyle(color: Pallete.colorDim4, fontSize: 20),
                    controller: _name,
                    autocorrect: false,
                    enableSuggestions: true,
                    decoration: const InputDecoration(
                      prefixIcon: Padding(
                        padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                        child: Icon(
                          Icons.person,
                          color: Pallete.colorDim4,
                          size: 30,
                        ),
                      ),
                      hintText: 'ex: Artene Alex',
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
                      labelText: 'Nume',
                      labelStyle:
                          TextStyle(fontSize: 20, color: Pallete.colorDim4),
                    ),
                  ),

                  //!Email Textfield
                  Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: TextField(
                      style: const TextStyle(
                          color: Pallete.colorDim4, fontSize: 20),
                      controller: _email,
                      autocorrect: false,
                      enableSuggestions: true,
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
                        labelStyle:
                            TextStyle(fontSize: 20, color: Pallete.colorDim4),
                      ),
                    ),
                  ),

                  //!password textfield
                  Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: TextField(
                      style: const TextStyle(
                          color: Pallete.colorDim4, fontSize: 20),
                      controller: _password,
                      obscureText: true,
                      autocorrect: false,
                      enableSuggestions: false,
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

                  //!confirm password textfield
                  Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: TextField(
                      style: const TextStyle(
                          color: Pallete.colorDim4, fontSize: 20),
                      controller: _confirmPassword,
                      obscureText: true,
                      autocorrect: false,
                      enableSuggestions: false,
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
                        labelText: 'Confirmă Parola',
                        labelStyle:
                            TextStyle(fontSize: 20, color: Pallete.colorDim4),
                      ),
                    ),
                  ),

                  //!Button
                  Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: SizedBox(
                      width: double.infinity,
                      height: 55,
                      child: TextButton(
                        onPressed: () async {
                          final name = _name.text;
                          final email = _email.text;
                          final password = _password.text;
                          final confirmPassword = _confirmPassword.text;

                          //confirm pass verification => create user
                          if (password == confirmPassword) {
                            UserCredential userCredentials = await FirebaseAuth
                                .instance
                                .createUserWithEmailAndPassword(
                              email: email,
                              password: password,
                            );
                            //get uid
                            final uid = userCredentials.user!.uid;

                            //push user credentials to database
                            pushUserData(uid, name, email);

                            //send email verification and navigate to verify_email_view
                            final currentUser =
                                FirebaseAuth.instance.currentUser;
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
                            ),
                          ),
                        ),
                        child: const Text(
                          'Înregistrează-te',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.normal),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Ești deja înregistrat?',
                          style:
                              TextStyle(color: Pallete.colorDim4, fontSize: 15),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pushNamedAndRemoveUntil(
                              context,
                              loginRoute,
                              (route) => false,
                            );
                          },
                          child: const Text(
                            'Conectează-te',
                            style: TextStyle(
                                fontSize: 15, color: Pallete.colorDim2),
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
      ),
    );
  }
}
