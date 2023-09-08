import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

import 'package:pet_life_gh/Services/read_data.dart';

import '../screens/wrapper.dart';

class ChatService extends ChangeNotifier {
  final FirebaseAuth auth = FirebaseAuth.instance;

  Future sendMessage(String receiverID, String message) async {
    await ReadData().getUser();
    // get current user info
    final currentUserName = allUsers[0].name;
    final Timestamp timestamp = Timestamp.now();

    // construct chatroom id
    List<String> ids = [loggedInUserId, receiverID];
    ids.sort();
    String chatRoomID = ids.join('_');

    // add new message
    await FirebaseFirestore.instance
        .collection('Chat Room')
        .doc(chatRoomID)
        .collection('Messages')
        .add({
      'Sender ID': loggedInUserId,
      'Receiver ID': receiverID,
      'Sender Name': currentUserName,
      'Message': message,
      'Timestamp': timestamp,
    });
  }

  Stream<QuerySnapshot> getMessages(String userId, String otherUserID) {
    //construct chat room id from userIds
    List<String> ids = [loggedInUserId, otherUserID];
    ids.sort();
    String chatRoomID = ids.join('_');

    return FirebaseFirestore.instance
        .collection('Chat Room')
        .doc(chatRoomID)
        .collection('Messages')
        .orderBy('Timestamp', descending: false)
        .snapshots();
  }
}
