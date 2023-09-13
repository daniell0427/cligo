import 'package:cligo/constants/images.dart';
import 'package:cligo/constants/variables.dart';
import 'package:intl/intl.dart';

Future pushUserData(
  uid,
  name,
  email,
) {
  DateTime now = DateTime.now();
  String formatter = DateFormat('dd/MM/yy').format(now);
  return firestore.collection('user').doc(uid).set({
    'uid': uid,
    'name': name,
    'email': email,
    'pfp': defaultAvatar,
    'date_added': formatter,
    'phone': null,
  });
}
