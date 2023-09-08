import 'package:cligo/constants/variables.dart';
import 'package:flutter/material.dart';

import '../constants/colors.dart';
import '../constants/routes.dart';
import '../features/logout.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  @override
  Widget build(BuildContext context) {
    //get screen size
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    //get variables
    variables();

    return Scaffold(
      backgroundColor: Pallete.colorDim4,
      appBar: AppBar(
        title: const Text(
          "Profil",
          style: TextStyle(fontSize: 25),
        ),
        centerTitle: true,
        backgroundColor: Pallete.colorDim4,
      ),
      body: Column(
        children: [
          Container(
            color: Colors.transparent,
            child: Padding(
              padding: const EdgeInsets.only(
                top: 15,
                left: 10,
                bottom: 5,
              ),
              child: Row(
                children: [
                  //numele utilizatorului + rating
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //numele utilizatorului
                      Container(
                        constraints: BoxConstraints(maxWidth: 280),
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          alignment: Alignment.center,
                          child: Text(
                            currentUserName,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 35,
                            ),
                          ),
                        ),
                      ),

                      const Padding(padding: EdgeInsets.only(top: 5)),

                      //rating
                      Container(
                        color: Colors.transparent,
                        child: const Row(
                          children: [
                            Icon(Icons.star, color: Pallete.colorDim0),
                            Padding(
                              padding: EdgeInsets.only(left: 5),
                              child: Text(
                                '5.0',
                                style: TextStyle(
                                  color: Pallete.colorDim0,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),

                  //profile picture
                  Expanded(
                    child: Align(
                      alignment: Alignment.topRight,
                      child: Stack(
                        children: <Widget>[
                          SizedBox(
                              width: 100,
                              child: IconButton(
                                icon: Ink.image(
                                  image: AssetImage(currentPfp), //pfp
                                ),
                                iconSize: 70,

                                //pfp options
                                onPressed: () async {
                                  return await showPfpOptions(context);
                                },
                              )),
                          const Positioned(
                            bottom: 0,
                            right: 10,
                            child: Icon(
                              Icons.add_circle_outline_rounded,
                              color: Pallete.colorDim0,
                              size: 30,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          //the line blow name
          SizedBox(
            height: 2,
            width: screenWidth,
            child: Container(color: const Color.fromARGB(182, 4, 34, 53)),
          ),

          //cursele mele
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: SizedBox(
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
                      Icons.directions_car_outlined,
                      color: Pallete.colorDim0,
                    ),
                    Padding(padding: EdgeInsets.only(right: 5.0)),
                    Text(
                      'Cursele mele',
                      style: TextStyle(
                        color: Pallete.colorDim0,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          //settings
          Padding(
            padding: const EdgeInsets.only(top: 0),
            child: SizedBox(
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
                      color: Pallete.colorDim0,
                    ),
                    Padding(padding: EdgeInsets.only(right: 5.0)),
                    Text(
                      'Setări',
                      style: TextStyle(
                        color: Pallete.colorDim0,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
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
                    color: Pallete.colorDim0,
                  ),
                  Padding(padding: EdgeInsets.only(right: 5.0)),
                  Text(
                    'Detalii cont',
                    style: TextStyle(
                      color: Pallete.colorDim0,
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
                  fireauth.signOut();
                  Navigator.of(context)
                      .pushNamedAndRemoveUntil(loginRoute, (_) => false);
                }
              },
              child: const Row(
                children: [
                  Icon(
                    Icons.logout,
                    color: Color.fromARGB(255, 255, 18, 1),
                  ),
                  Padding(padding: EdgeInsets.only(right: 5.0)),
                  Text(
                    'Ieșire',
                    style: TextStyle(
                      color: Color.fromARGB(255, 255, 18, 1),
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
            child: const Text(
              'Alege din galerie',
              style: TextStyle(fontSize: 16),
            ),
          ),
          TextButton(
            onPressed: () async {
              chooseSelfie();
            },
            child: const Text(
              'Fa o poza',
              style: TextStyle(fontSize: 16),
            ),
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
