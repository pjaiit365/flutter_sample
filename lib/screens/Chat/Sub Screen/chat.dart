// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../Components/default_back_button.dart';
import '../../../constants.dart';
import 'chat_page.dart';

class ChatMessaging extends StatefulWidget {
  const ChatMessaging({Key? key}) : super(key: key);

  @override
  State<ChatMessaging> createState() => _ChatMessagingState();
}

class _ChatMessagingState extends State<ChatMessaging> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: DefaultBackButton(),
        title: Text(
          'Chats',
          style: TextStyle(
            color: black,
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
        backgroundColor: white,
        elevation: 0.0,
      ),
      body: buildUserList(),
      backgroundColor: white,
    );
  }

  Widget buildUserList() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('users').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Error');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: Platform.isIOS
                ? CupertinoActivityIndicator()
                : CircularProgressIndicator(),
          );
        }
        return ListView(
          physics: BouncingScrollPhysics(),
          children: snapshot.data!.docs
              .map<Widget>((doc) => buildUserListItem(doc))
              .toList(),
        );
      },
    );
  }

  Widget buildUserListItem(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data()! as Map<String, dynamic>;

    if (FirebaseAuth.instance.currentUser!.email != data['Email Address'] &&
        'admin@admin.com' != data['Email Address']) {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
        child: GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ChatPage(
                    pic: data['Pic'],
                    receiverUserID: data['User ID'],
                    userName: data['Name'],
                  ),
                ));
          },
          child: Container(
            height: 90,
            width: 345,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(9),
              border: Border.all(color: borderColor.withOpacity(0.7), width: 1),
            ),
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  height: 55,
                  width: 55,
                  decoration: BoxDecoration(
                    border: Border.all(color: sectionColor),
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        fit: BoxFit.cover, image: NetworkImage(data['Pic'])),
                  ),
                  child: data['Pic'] == ''
                      ? Center(
                          child: Icon(
                            Icons.person,
                            color: grey,
                          ),
                        )
                      : null,
                ),
                SizedBox(
                  width: 12,
                ),
                Text(
                  data['Name'],
                  style: TextStyle(
                    color: black,
                    fontSize: 17,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Spacer(),
                SizedBox(width: 10),
              ],
            ),
          ),
        ),
      );
    } else {
      return Container();
    }
  }
}
