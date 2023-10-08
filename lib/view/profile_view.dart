import 'dart:io';
import 'package:cligo/constants/images.dart';
import 'package:cligo/constants/variables.dart';
import 'package:cligo/database/services/route_service.dart';
import 'package:cligo/features/screen_size.dart';
import 'package:cligo/view/account_details.dart';
import 'package:cligo/view/my_routes.dart';
import 'package:cligo/view/settings_view.dart';
import 'package:firebase_storage/firebase_storage.dart';
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
  String imageURL = '';
  final ImagePicker _picker = ImagePicker();
  @override
  Widget build(BuildContext context) {
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
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Stack(
                            children: <Widget>[
                              GestureDetector(
                                child: CircleAvatar(
                                    radius: 40,
                                    backgroundImage: currentPfp != defaultAvatar
                                        ? NetworkImage(currentPfp)
                                        : const AssetImage(defaultAvatar)
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
                                      ?.updatePhotoURL(imageURL);
                                  await firestore
                                      .collection('user')
                                      .doc(currentUserID)
                                      .update({'pfp': imageURL});

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
                                  }
                                },
                              ),
                              const Positioned(
                                bottom: 0,
                                right: 0,
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
                    ),
                  ],
                ),
              ),
            ),

            //the line blow name
            SizedBox(
              height: 2,
              width: ScreenSize(context).width,
              child: Container(color: const Color.fromARGB(182, 4, 34, 53)),
            ),

            //cursele mele
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: SizedBox(
                width: ScreenSize(context).width,
                height: ScreenSize(context).height * 0.08,
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
                width: ScreenSize(context).width,
                height: ScreenSize(context).height * 0.08,
                child: TextButton(
                  style: const ButtonStyle(
                    alignment: Alignment.centerLeft,
                  ),
                  onPressed: () {
                    Navigator.of(context).push(CupertinoPageRoute(
                      builder: (context) => const SettingsView(),
                    ));
                  },
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
              width: ScreenSize(context).width,
              height: ScreenSize(context).height * 0.08,
              child: TextButton(
                style: const ButtonStyle(
                  alignment: Alignment.centerLeft,
                ),
                onPressed: () {
                  Navigator.of(context).push(
                    CupertinoPageRoute(
                      builder: (context) => const AccountDetailsView(),
                    ),
                  );
                },
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
              width: ScreenSize(context).width,
              height: ScreenSize(context).height * 0.08,
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
                          CircleAvatar(
                              radius: 40,
                              backgroundImage: widget.userPfp != defaultAvatar
                                  ? NetworkImage(widget.userPfp!)
                                  : const AssetImage(defaultAvatar)
                                      as ImageProvider),
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
              width: ScreenSize(context).width,
              child: Container(color: const Color.fromARGB(182, 4, 34, 53)),
            ),
          ],
        ),
      );
    }
  }

  Widget bottomSheet() {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20), color: Pallete.colorDim0),
      height: 310,
      width: ScreenSize(context).width,
      child: Container(
        margin: const EdgeInsets.symmetric(
          vertical: 20,
          horizontal: 20,
        ),
        child: Column(
          children: [
            CircleAvatar(
              radius: 60,
              backgroundImage: currentPfp != defaultAvatar
                  ? NetworkImage(currentPfp)
                  : const AssetImage(defaultAvatar) as ImageProvider,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 5),
              child: Container(
                color: Pallete.colorDim4,
                width: ScreenSize(context).width,
                height: 2,
              ),
            ),

            //update photo
            GestureDetector(
              onTap: () async {
                await choosePhoto(ImageSource.gallery);

                //close modal
                Navigator.pop(context);
              },
              child: Container(
                margin: const EdgeInsets.only(top: 10),
                width: ScreenSize(context).width,
                decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 208, 255, 255),
                    border: Border.all(
                      color: Pallete.colorDim4,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(10)),
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Icon(
                        Icons.image_outlined,
                        color: Pallete.colorDim4,
                        size: 35,
                      ),
                      Text(
                        'Actualizează poza',
                        style: TextStyle(
                            color: Pallete.colorDim4,
                            fontSize: 25,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            //remove photo
            GestureDetector(
              onTap: () async {
                //close modal
                Navigator.pop(context);

                await fireauth.currentUser?.updatePhotoURL(defaultAvatar);

                //refresh page
                setState(() {});
              },
              child: Container(
                width: ScreenSize(context).width,
                //height: 40,
                margin: const EdgeInsets.only(top: 10),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(51, 236, 46, 46),
                  border: Border.all(
                    color: const Color.fromARGB(255, 255, 17, 0),
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Padding(
                  padding: EdgeInsets.fromLTRB(8, 8, 8, 8),
                  child: Row(
                    children: [
                      Icon(
                        Icons.delete_outline,
                        color: Color.fromARGB(255, 255, 17, 0),
                        size: 35,
                      ),
                      Text(
                        'Șterge poza',
                        style: TextStyle(
                          color: Color.fromARGB(255, 255, 17, 0),
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future choosePhoto(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);
    final fileImage = File(pickedFile!.path);
    String uniqueName = DateTime.now().microsecondsSinceEpoch.toString();
    final path = 'images/$uniqueName';

    Reference ref = storage.ref().child(path);

    try {
      await ref.putFile(fileImage);
      imageURL = await ref.getDownloadURL();
      setState(() {});
    } catch (error) {
      print(error);
    }
  }
}
