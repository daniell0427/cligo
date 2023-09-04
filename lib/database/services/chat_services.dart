import 'package:cligo/constants/variables.dart';
import 'package:cligo/model/message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatServices extends ChangeNotifier {
  //SEND MESSAGES
  Future sendMessage(receiverID, message) async {
    //get sender details
    final Timestamp timestamp = Timestamp.now();

    //create message
    Message newMessage = Message(
      senderID: currentUserID,
      receiverID: receiverID,
      timestamp: timestamp,
      message: message,
    );

    //create chat rooom id
    List<String> ids = [currentUserID, receiverID];
    ids.sort();
    final chatRoomID = ids.join('_');

    //send message to database
    firestore
        .collection('chat_rooms')
        .doc(chatRoomID)
        .collection('messages')
        .add(newMessage.toMap());
  }

  //GET MESSAGES
  Stream<QuerySnapshot> getMessages(userID, otherUserID) {
    //get chat room id
    List<String> ids = [userID, otherUserID];
    ids.sort();
    final chatRoomID = ids.join('_');

    //get messages from database
    return firestore
        .collection('chat_rooms')
        .doc(chatRoomID)
        .collection('messages')
        .orderBy('timestamp', descending: false)
        .snapshots();
  }
}
