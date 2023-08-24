import 'package:cloud_firestore/cloud_firestore.dart';

List ids = [];

//get ids from firebase
Future getIDs() async {
  await FirebaseFirestore.instance.collection('routes').get().then(
        (snapshots) => snapshots.docs.forEach(
          (element) {
            ids.add(element.reference.id);
          },
        ),
      );
}
