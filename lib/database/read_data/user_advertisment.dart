import 'package:cloud_firestore/cloud_firestore.dart';

//gets data inputs from add_view
Future pushUserAdData(
    String location, String destination, String date, int availableSeats) async {
  return FirebaseFirestore.instance.collection('routes').add({
    'location': location,
    'destination': destination,
    'date': date,
    'available_seats': availableSeats,
  });
}
