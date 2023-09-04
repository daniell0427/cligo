import 'package:cligo/constants/variables.dart';

//gets data inputs from add_view
Future pushUserAdData(
  String senderID,
  String senderName,
  String location,
  String destination,
  String date,
  int availableSeats,
  String pfp,
) async {
  return firestore.collection('routes').add({
    'sender_ID': senderID,
    'sender_name': senderName,
    'sender_pfp': pfp,
    'location': location,
    'destination': destination,
    'date': date,
    'available_seats': availableSeats,
  });
}
