import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class GetUserName extends StatelessWidget {
  final String uid;
  const GetUserName({
    super.key,
    required this.uid,
  });

  @override
  Widget build(BuildContext context) {
    CollectionReference data = FirebaseFirestore.instance.collection('user');
    return FutureBuilder(
      future: data.doc(uid).get(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData) {
            Map<String, dynamic> userData =
                snapshot.data!.data() as Map<String, dynamic>;
            return Text(
              userData['name'] ?? '',
              style: const TextStyle(
                fontSize: 35,
                color: Colors.white,
              ),
            );
          }
        }
        return const Text('loading..');
      },
    );
  }
}
