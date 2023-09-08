import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../Components/default_back_button.dart';
import '../../../Components/received_message.dart';
import '../../../Components/sent_message.dart';
import '../../../Components/text_field_bar.dart';
import '../../../Services/chat_service.dart';
import '../../../constants.dart';

class ChatPage extends StatefulWidget {
  final String pic;
  final String userName;
  final String receiverUserID;
  const ChatPage({
    Key? key,
    required this.userName,
    required this.receiverUserID,
    required this.pic,
  }) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final messageController = TextEditingController();
  final scrollController = ScrollController();
  ChatService chatService = ChatService();

  @override
  void dispose() {
    scrollController.dispose();
    messageController.dispose();
    super.dispose();
  }

  String loggedInUserId = FirebaseAuth.instance.currentUser!.uid;

  Future sendMessage() async {
    if (messageController.text.isNotEmpty) {
      await chatService.sendMessage(
          widget.receiverUserID, messageController.text);
      messageController.clear();
    }
  }

  @override
  void initState() {
    Future.delayed(Duration(milliseconds: 100), () {
      if (scrollController.hasClients) {
        scrollController.jumpTo(scrollController.position.maxScrollExtent);
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        automaticallyImplyLeading: false,
        leading: DefaultBackButton(),
        backgroundColor: white,
        elevation: 0.0,
        title: SizedBox(
          width: 240,
          child: Text(
            widget.userName,
            style: TextStyle(
              color: black,
              fontSize: 17,
            ),
          ),
        ),
      ),
      backgroundColor: white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: buildMessageList(),
          ),
          buildMessageInput(),
        ],
      ),
    );
  }

  Widget buildMessageInput() {
    return TextfieldBar(controller: messageController, screen: sendMessage);
  }

  Widget buildMessageItem(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data() as Map<String, dynamic>;

    Timestamp timestamp = data['Timestamp'];
    DateTime dateTime = timestamp.toDate();
    int hour = dateTime.hour;
    int minute = dateTime.minute;
    var type = 'AM';
    if (hour > 12) {
      hour = hour - 12;
      type = 'PM';
    } else {
      type = 'AM';
    }

    final time =
        '${hour < 10 ? '0$hour' : hour}:${minute < 10 ? '0$minute' : minute} $type';
    return Container(
      alignment: (data['Sender ID'] == FirebaseAuth.instance.currentUser!.uid)
          ? Alignment.centerLeft
          : Alignment.centerRight,
      child: Padding(
        padding: (data['Sender ID'] == FirebaseAuth.instance.currentUser!.uid)
            ? EdgeInsets.only(right: 10.0)
            : EdgeInsets.only(left: 10.0),
        child: Column(
          crossAxisAlignment:
              (data['Sender ID'] == FirebaseAuth.instance.currentUser!.uid)
                  ? CrossAxisAlignment.end
                  : CrossAxisAlignment.start,
          children: <Widget>[
            (data['Sender ID'] == FirebaseAuth.instance.currentUser!.uid)
                ? SentMessage(
                    message: data['Message'],
                    timeStamp: time,
                  )
                : ReceivedMessage(
                    message: data['Message'],
                    timeStamp: time,
                    pic: widget.pic,
                  ),
          ],
        ),
      ),
    );
  }

  Widget buildMessageList() {
    return StreamBuilder(
      stream: chatService.getMessages(
          FirebaseAuth.instance.currentUser!.uid, widget.receiverUserID),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Error:${snapshot.error}');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: Platform.isIOS
                ? CupertinoActivityIndicator()
                : CircularProgressIndicator(),
          );
        }
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.0),
          child: ListView(
              controller: scrollController,
              physics: BouncingScrollPhysics(),
              children: snapshot.data!.docs
                  .map((document) => buildMessageItem(document))
                  .toList()),
        );
      },
    );
  }
}
