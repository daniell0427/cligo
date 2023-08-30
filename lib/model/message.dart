import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  final String senderID;
  final String receiverID;
  final Timestamp timestamp;
  final String message;

  Message({
    required this.senderID,
    required this.receiverID,
    required this.timestamp,
    required this.message,
  });

  Map<String, dynamic> toMap() {
    return {
      'senderID': senderID,
      'receiverID': receiverID,
      'timestamp': timestamp,
      'message': message,
    };
  }
}
