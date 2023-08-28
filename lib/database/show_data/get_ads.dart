import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ShowRoutes extends StatelessWidget {
  final String docId;

  ShowRoutes({required this.docId});

  @override
  Widget build(BuildContext context) {
    CollectionReference data = FirebaseFirestore.instance.collection('routes');

    return FutureBuilder(
      future: data.doc(docId).get(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> boxInfo =
              snapshot.data!.data() as Map<String, dynamic>;
          return Text('Data: ${boxInfo['destination']}');
        }
        return const Text('Loading..');
      },
    );
  }
}
