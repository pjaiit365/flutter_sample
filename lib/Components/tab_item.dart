// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../Services/read_data.dart';
import '../constants.dart';

class TabItem extends StatelessWidget {
  final String idType;
  final String catID;
  final String email;
  final String name;
  final int index;
  const TabItem({
    super.key,
    required this.index,
    required this.catID,
    required this.email,
    required this.name,
    required this.idType,
  });

  @override
  Widget build(BuildContext context) {
    ReadData readData = ReadData();
    void deleteUser(BuildContext context) {
      showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(
            builder: (context, setState) => AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(9),
              ),
              title: Center(
                child: Text(
                  'Delete Category',
                  style: TextStyle(
                    color: green,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              content: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Are you sure you want to delete this category? ',
                    style: TextStyle(
                      height: 1.4,
                      color: black,
                      fontSize: 17,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(height: 18),
                  Text(
                    'User: nn',
                    style: TextStyle(
                      height: 1.4,
                      color: blue,
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 50),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InkWell(
                        highlightColor: grey.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(5),
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Ink(
                          height: 39,
                          width: 129,
                          decoration: BoxDecoration(
                            color: white,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Padding(
                            padding: EdgeInsets.only(left: 12.0),
                            child: Center(
                              child: Text(
                                'Cancel',
                                style: TextStyle(
                                  color: borderColor,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      VerticalDivider(
                        color: chatGrey,
                        width: 10,
                        thickness: 10,
                      ),
                      InkWell(
                        highlightColor: Colors.red.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(5),
                        onTap: () {
                          setState(() {
                            Navigator.pop(
                              context,
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                duration: Duration(seconds: 2),
                                backgroundColor: Colors.black45,
                                behavior: SnackBarBehavior.floating,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                content: const Center(
                                  child: Text(
                                    'Category successfully deleted!',
                                  ),
                                ),
                              )),
                            );
                          });
                        },
                        child: Ink(
                          height: 39,
                          width: 129,
                          decoration: BoxDecoration(
                            color: white,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Center(
                            child: Text('Yes, Delete',
                                style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                )),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      );
    }

    return Slidable(
      endActionPane: ActionPane(motion: StretchMotion(), children: <Widget>[
        // SlidableAction(
        //   borderRadius: BorderRadius.only(
        //     topLeft: Radius.circular(2),
        //     bottomLeft: Radius.circular(2),
        //   ),
        //   onPressed: (context) {},
        //   backgroundColor: Colors.blue,
        //   foregroundColor: white,
        //   icon: Icons.edit_note_rounded,
        // ),
        SlidableAction(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(9),
            bottomRight: Radius.circular(9),
          ),
          onPressed: deleteUser,
          backgroundColor: Colors.red,
          foregroundColor: white,
          icon: Icons.delete_rounded,
        ),
      ]),
      child: GestureDetector(
        onTap: () {},
        child: Container(
          height: 115,
          width: 360,
          decoration: BoxDecoration(
            color: white,
            borderRadius: BorderRadius.circular(9),
            boxShadow: [
              BoxShadow(
                  color: black.withOpacity(0.04),
                  spreadRadius: 5,
                  blurRadius: 5,
                  offset: Offset(0, 1)),
            ],
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '$idType ID: $catID',
                  style: TextStyle(
                    color: borderColor,
                    fontSize: 14,
                  ),
                ),
                SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(
                          width: 260,
                          child: Text(
                            email,
                            style: TextStyle(
                                color: green,
                                fontSize: 20,
                                fontWeight: FontWeight.w700),
                            overflow: TextOverflow.ellipsis,
                            softWrap: true,
                          ),
                        ),
                        SizedBox(height: 10),
                        SizedBox(
                          width: 300,
                          child: Text(
                            name,
                            style: TextStyle(
                                color: borderColor,
                                fontSize: 17,
                                fontWeight: FontWeight.w400),
                            overflow: TextOverflow.ellipsis,
                            softWrap: true,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
