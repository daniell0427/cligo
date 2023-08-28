import 'package:cligo/constants/images.dart';
import 'package:flutter/material.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  @override
  Widget build(BuildContext context) {
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
                const Text(
                  'Ryan Gosling',
                  style: TextStyle(
                    fontSize: 35,
                    color: Colors.white,
                  ),
                ),
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
                            image: const AssetImage(defaultAvatar),
                          ),
                          iconSize: 70,
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
          )
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
