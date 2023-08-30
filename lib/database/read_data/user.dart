import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

Future pushUserData(
  uid,
  name,
  email,
) {
  DateTime now = DateTime.now();
  String formatter = DateFormat('dd/MM/yy').format(now);
  return FirebaseFirestore.instance.collection('user').doc(uid).set({
    'uid': uid,
    'name': name,
    'email': email,
    'date_added': formatter,
    'phone': null,
  });
}
