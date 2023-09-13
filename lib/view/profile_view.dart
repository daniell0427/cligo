import 'dart:io';

import 'package:cligo/constants/images.dart';
import 'package:cligo/constants/variables.dart';
import 'package:cligo/database/services/route_service.dart';
import 'package:cligo/features/screen_size.dart';
import 'package:cligo/view/my_routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../constants/colors.dart';
import '../constants/routes.dart';
import '../features/logout.dart';

class ProfileView extends StatefulWidget {
  final bool urProfile;
  final String? userName;
  final String? userPfp;

  const ProfileView({
    super.key,
    required this.urProfile,
    this.userName,
    this.userPfp,
  });

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  late PickedFile _imageFile;
  final ImagePicker _picker = ImagePicker();
  @override
  Widget build(BuildContext context) {
    //get screen size
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    //get variables
    variables();

    //UR PROFILE
    if (widget.urProfile == true) {
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
                          constraints: const BoxConstraints(maxWidth: 280),
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
                            GestureDetector(
                              child: CircleAvatar(
                                  radius: 50,
                                  backgroundImage: defaultAvatar == currentPfp
                                      ? AssetImage(currentPfp)
                                      : FileImage(File(currentPfp))
                                          as ImageProvider),
                              onTap: () async {
                                //show bottomsheet
                                await showModalBottomSheet(
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(15),
                                        topRight: Radius.circular(15)),
                                  ),
                                  context: context,
                                  builder: (context) => bottomSheet(),
                                );

                                //update photo
                                await fireauth.currentUser
                                    ?.updatePhotoURL(_imageFile.path);
                                await firestore
                                    .collection('user')
                                    .doc(currentUserID)
                                    .update({'pfp': _imageFile.path});

                                //refresh page
                                setState(() {});

                                //reset var
                                variables();

                                //get ids
                                await RouteService().getMyRoutesID();

                                for (var id in myRouteIDs) {
                                  firestore
                                      .collection('routes')
                                      .doc(id)
                                      .update({'sender_pfp': currentPfp});
                                  print(currentPfp);
                                }
                              },
                            ),
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
                  onPressed: () async {
                    //clean list
                    variables();

                    //get ids
                    await RouteService().getMyRoutesID();

                    //show routes
                    Navigator.of(context).push(
                      CupertinoPageRoute(
                        builder: (context) => const MyRoutesView(),
                      ),
                    );
                  },
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

    //NOT UR PROFILE
    else {
      return Scaffold(
        backgroundColor: Pallete.colorDim4,
        appBar: AppBar(
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
                          constraints: const BoxConstraints(maxWidth: 280),
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            alignment: Alignment.center,
                            child: Text(
                              widget.userName ?? '',
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
                        child: Stack(children: <Widget>[
                          SizedBox(
                            width: 100,
                            child: Ink.image(
                              image: AssetImage(
                                  widget.userPfp ?? defaultAvatar), //pfp
                              height: 70,
                              width: 70,
                            ),
                          ),
                        ]),
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
          ],
        ),
      );
    }
  }

  Widget bottomSheet() {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
      height: 250,
      width: ScreenSize(context).width,
      margin: const EdgeInsets.symmetric(
        vertical: 20,
        horizontal: 20,
      ),
      child: Column(
        children: [
          CircleAvatar(
            radius: 50,
            backgroundImage: currentPfp != defaultAvatar
                ? FileImage(File(currentPfp))
                : AssetImage(currentPfp) as ImageProvider,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Container(
              color: Colors.black,
              width: ScreenSize(context).width,
              height: 1,
            ),
          ),

          //update photo
          Container(
            margin: const EdgeInsets.only(top: 10),
            width: ScreenSize(context).width,
            height: 40,
            decoration: BoxDecoration(
              color: const Color.fromARGB(120, 158, 158, 158),
              border: Border.all(
                color: Colors.black,
                width: 1,
              ),
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.image_outlined,
                  color: Colors.black,
                  size: 30,
                ),
                TextButton(
                  onPressed: () async {
                    await choosePhoto(ImageSource.gallery);

                    //close modal
                    Navigator.pop(context);
                  },
                  child: const Text(
                    'Actualizează poza',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                    ),
                  ),
                ),
              ],
            ),
          ),

          //remove photo
          Container(
            width: ScreenSize(context).width,
            height: 40,
            margin: const EdgeInsets.only(top: 10),
            decoration: BoxDecoration(
              color: const Color.fromARGB(120, 158, 158, 158),
              border: Border.all(
                color: Colors.black,
                width: 1,
              ),
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.delete_outline,
                  color: Colors.red,
                  size: 30,
                ),
                TextButton(
                  onPressed: () async {
                    //close modal
                    Navigator.pop(context);

                    await fireauth.currentUser?.updatePhotoURL(defaultAvatar);

                    //refresh page
                    setState(() {});
                  },
                  child: const Text(
                    'Șterge poza',
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 20,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future choosePhoto(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);

    setState(() {
      _imageFile = PickedFile(pickedFile!.path);
    });
  }
}
