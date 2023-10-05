import 'package:cligo/constants/images.dart';
import 'package:cligo/constants/variables.dart';
import 'package:cligo/view/chat_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants/colors.dart';

class ChatListView extends StatefulWidget {
  const ChatListView({super.key});

  @override
  State<ChatListView> createState() => _ChatListViewState();
}

class _ChatListViewState extends State<ChatListView> {
  @override
  Widget build(BuildContext context) {
    return displayChats();
  }

  Widget displayChats() {
    //get variables
    variables();

    return StreamBuilder(
      stream: firestore.collection('user').snapshots(),
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
    var pfp = data['pfp'];
    print(pfp);
    //display users without current user
    if (currentUserEmail != data['email']) {
      return ListTile(
        contentPadding: const EdgeInsets.all(0),
        title: Container(
          decoration: const BoxDecoration(
              border: Border(
            bottom: BorderSide(
              color: Pallete.colorDim4,
              width: 2.0,
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
                    child: CircleAvatar(
                      radius: 25,
                      backgroundColor: const Color.fromARGB(255, 200, 200, 200),
                      backgroundImage: pfp != defaultAvatar
                          ? NetworkImage(pfp)
                          : AssetImage(defaultAvatar) as ImageProvider,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ), //*for padding
                Text(
                  data['name'],
                  style: const TextStyle(fontSize: 23),
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
