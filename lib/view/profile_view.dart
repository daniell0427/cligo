import 'package:cligo/constants/images.dart';
import 'package:cligo/database/show_data/get_user_name.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../constants/routes.dart';
import '../features/logout.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  //instance of fireauth
  FirebaseAuth _fireauth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    //get screen size
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    //get user id
    String uid = _fireauth.currentUser!.uid;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text(
          "Profile",
          style: TextStyle(fontSize: 25),
        ),
        backgroundColor: Colors.black,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              top: 20,
              left: 10,
              bottom: 10,
            ),
            child: Row(
              children: [
                //numele utilizatorului + rating
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //numele utilizatorului
                    GetUserName(uid: uid),

                    const Padding(padding: EdgeInsets.only(top: 10)),

                    //rating
                    Container(
                      color: const Color.fromARGB(146, 158, 158, 158),
                      child: const SizedBox(
                        width: 50,
                        child: Row(
                          children: [
                            Icon(Icons.star, color: Colors.white),
                            Text(
                              '5.0',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),

                //profile picture
                Expanded(
                  child: Align(
                    alignment: Alignment.topRight,
                    child: Container(
                      decoration: const BoxDecoration(
                        border: Border(
                          left: BorderSide(
                            color: Colors.white,
                          ),
                        ),
                      ),
                      child: SizedBox(
                        width: 85,
                        child: IconButton(
                          icon: Ink.image(
                            image: const AssetImage(defaultAvatar), //pfp
                          ),
                          iconSize: 70,

                          //pfp options
                          onPressed: () async {
                            return await showPfpOptions(context);
                          },
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          //the line blow name
          Padding(
            padding: const EdgeInsets.only(top: 7.0, bottom: 7.0),
            child: SizedBox(
              height: 10,
              width: screenWidth,
              child: Container(color: const Color.fromARGB(68, 72, 72, 72)),
            ),
          ),

          //settings
          SizedBox(
            width: screenWidth,
            height: screenHeight * 0.08,
            child: TextButton(
              style: const ButtonStyle(
                alignment: Alignment.centerLeft,
              ),
              onPressed: () {},
              child: const Row(
                children: [
                  Icon(
                    Icons.settings,
                    color: Colors.white,
                  ),
                  Padding(padding: EdgeInsets.only(right: 5.0)),
                  Text(
                    'Setări',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ),
          ),

          //account details
          SizedBox(
            width: screenWidth,
            height: screenHeight * 0.08,
            child: TextButton(
              style: const ButtonStyle(
                alignment: Alignment.centerLeft,
              ),
              onPressed: () {},
              child: const Row(
                children: [
                  Icon(
                    Icons.person_outline_sharp,
                    color: Colors.white,
                  ),
                  Padding(padding: EdgeInsets.only(right: 5.0)),
                  Text(
                    'Detalii cont',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ),
          ),

          //logout button
          SizedBox(
            width: screenWidth,
            height: screenHeight * 0.08,
            child: TextButton(
              style: const ButtonStyle(
                alignment: Alignment.centerLeft,
              ),
              onPressed: () async {
                final shouldLogout = await showLogoutDialog(context);
                if (shouldLogout) {
                  FirebaseAuth.instance.signOut();
                  Navigator.of(context)
                      .pushNamedAndRemoveUntil(loginRoute, (_) => false);
                }
              },
              child: const Row(
                children: [
                  Icon(
                    Icons.logout,
                    color: Colors.red,
                  ),
                  Padding(padding: EdgeInsets.only(right: 5.0)),
                  Text(
                    'Ieșire',
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Future showPfpOptions(BuildContext context) {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        actions: [
          TextButton(
            onPressed: () async {
              await makeSelfie();
            },
            child: const Text('Alege din galerie'),
          ),
          TextButton(
            onPressed: () async {
              chooseSelfie();
            },
            child: const Text('Fa o poza'),
          ),
        ],
      );
    },
  );
}

Future makeSelfie() async {
  return '';
}

Future chooseSelfie() async {
  return '';
}
