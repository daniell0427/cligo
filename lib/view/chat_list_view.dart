import 'package:cligo/constants/colors.dart';
import 'package:cligo/constants/images.dart';
import 'package:cligo/view/chat_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChatListView extends StatefulWidget {
  const ChatListView({super.key});

  @override
  State<ChatListView> createState() => _ChatListViewState();
}

FirebaseFirestore _firestore = FirebaseFirestore.instance;
FirebaseAuth _fireauth = FirebaseAuth.instance;

class _ChatListViewState extends State<ChatListView> {
  @override
  Widget build(BuildContext context) {
    return displayChats();
  }

  Widget displayChats() {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('user').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Text('Eroare, ceva s-a întâmplat!');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text('Se încarcă...');
        }

        return Container(
          color: Pallete.colorDim0,
          child: Padding(
            padding: const EdgeInsets.all(0.0),
            child: ListView(
              padding: const EdgeInsets.all(0),
              children: snapshot.data!.docs
                  .map<Widget>((doc) => createListView(doc))
                  .toList(),
            ),
          ),
        );
      },
    );
  }

  Widget createListView(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data()! as Map<String, dynamic>;

    //display users without current user
    if (_fireauth.currentUser!.email != data['email']) {
      return ListTile(
        title: Container(
          decoration: const BoxDecoration(
              border: Border(
            bottom: BorderSide(
              color: Color.fromARGB(
                  207, 14, 54, 79), // You can change the border color here
              width: 2.0, // You can adjust the border width here
            ),
          )),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(25),
                  child: Container(
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      // border: Border.all(
                      //   color: Pallete.colorDim4, // Border color
                      //   width: 2.0, // Border width
                      // ),
                    ),
                    child: const CircleAvatar(
                      radius: 25,
                      backgroundColor: Color.fromARGB(255, 200, 200, 200),
                      backgroundImage: AssetImage(defaultAvatar),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ), //*for padding
                Text(
                  data['name'],
                  style: const TextStyle(fontSize: 20),
                ),
              ],
            ),
          ),
        ),
        onTap: () => Navigator.of(context).push(
          CupertinoPageRoute(
            builder: (context) => ChatView(
              receiverUserName: data['name'],
              receiverUserID: data['uid'],
            ),
          ),
        ),
      );
    } else {
      return Container();
    }
  }
}
