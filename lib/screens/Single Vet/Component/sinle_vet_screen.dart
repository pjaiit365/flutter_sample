// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:pet_life_gh/Components/default_back_button.dart';
import 'package:pet_life_gh/Components/vet_display_item.dart';
import 'package:pet_life_gh/Services/read_data.dart';
import 'package:pet_life_gh/constants.dart';
import 'package:pet_life_gh/screens/Chat/Sub%20Screen/chat_page.dart';

class SingleVetScreenPage extends StatefulWidget {
  const SingleVetScreenPage({super.key});

  @override
  State<SingleVetScreenPage> createState() => _SingleVetScreenPageState();
}

class _SingleVetScreenPageState extends State<SingleVetScreenPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: white,
          elevation: 0,
          title: Text(
            'Veterinary Details',
            style: TextStyle(
              color: blue,
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          leading: DefaultBackButton(),
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 20),
              Container(
                height: 250,
                width: 250,
                decoration: BoxDecoration(
                    color: white,
                    borderRadius: BorderRadius.circular(11),
                    image: DecorationImage(
                      image: NetworkImage(allVets[vetSelectedIndex].pic),
                      fit: BoxFit.cover,
                    )),
                child: allVets[vetSelectedIndex].pic == ''
                    ? Center(
                        child: Icon(
                          Icons.person,
                          color: grey,
                          size: 50,
                        ),
                      )
                    : null,
              ),
              SizedBox(
                height: 30,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Name: ${allVets[vetSelectedIndex].name}",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    "Location: ${allVets[vetSelectedIndex].location}",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    "Region: ${allVets[vetSelectedIndex].region}",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    "Experience: ${allVets[vetSelectedIndex].experienceNumber} Years",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    "Contact: 0${allVets[vetSelectedIndex].number}",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return ChatPage(
                                      userName: allVets[vetSelectedIndex].name,
                                      receiverUserID:
                                          allVets[vetSelectedIndex].vetID,
                                      pic: allVets[vetSelectedIndex].pic);
                                },
                              ),
                            );
                          },
                          child: Container(
                            height: 60,
                            width: 165,
                            decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.lightBlue,
                                ),
                                borderRadius: BorderRadius.circular(6)),
                            child: Center(
                              child: Text(
                                "Message Vet",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                  color: blue,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 25),
                        Container(
                          height: 60,
                          width: 165,
                          decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.lightBlue,
                              ),
                              borderRadius: BorderRadius.circular(6)),
                          child: Center(
                            child: Text(
                              "BOOK NOW",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                color: blue,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}
