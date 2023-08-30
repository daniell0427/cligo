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
          return const Text('Se încarcă..');
        }

        return ListView(
          children: snapshot.data!.docs
              .map<Widget>((doc) => createListView(doc))
              .toList(),
        );
      },
    );
  }

  Widget createListView(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data()! as Map<String, dynamic>;

    //display users without current user
    if (_fireauth.currentUser!.email != data['email']) {
      return ListTile(
        title: Text(data['name']),
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
