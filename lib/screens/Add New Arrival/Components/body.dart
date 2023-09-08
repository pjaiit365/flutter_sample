// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pet_life_gh/screens/Home2/home_screen2.dart';

import '../../../constants.dart';

class Body extends StatefulWidget {
  const Body({
    super.key,
  });

  @override
  State<Body> createState() => _BodyState();
}

String addedProductImage = '';
String addedProductImageUrl = '';
String addedProductImageFilePath = '';

class _BodyState extends State<Body> {
  final _nameController = TextEditingController();
  final _ageController = TextEditingController();
  final _priceController = TextEditingController();
  final _locationController = TextEditingController();

  @override
  void dispose() {
    _ageController.dispose();
    _nameController.dispose();
    _locationController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    addedProductImageUrl = '';
    addedProductImageFilePath = '';
    genderValue = 'Male';

    super.initState();
  }

  Future addNewArrivalDetails() async {
    final document = await FirebaseFirestore.instance
        .collection('New Arrival Products')
        .add({
      'Name': _nameController.text.trim(),
      'Age': int.parse(_ageController.text.trim()),
      'Gender': genderValue,
      'Location': _locationController.text.trim(),
      'Price': int.parse(_priceController.text.trim()),
    });

    final docID = document.id;

    uploadPic(docID, addedProductImageFilePath);

    await FirebaseFirestore.instance
        .collection('New Arrival Products')
        .doc(docID)
        .update({
      'Product ID': docID,
      'Image': addedProductImageUrl,
    });

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: ((context) => HomeSreen2()),
      ),
    );
  }

  void addImage() async {
    try {
      final results = await FilePicker.platform.pickFiles(
        allowMultiple: false,
        allowedExtensions: ['jpg', 'jpeg', 'png'],
        type: FileType.custom,
      );

      if (results != null) {
        addedProductImage = results.files.single.name;
        addedProductImageFilePath = results.files.single.path!;
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future uploadPic(String productID, String filePath) async {
    File file = File(filePath);
    final querySnapshot = await FirebaseStorage.instance
        .ref('$loggedInUserID/Added Products/$productID')
        .child('image.jpeg')
        .putFile(file);

    addedProductImageUrl = await querySnapshot.ref.getDownloadURL();
    print(addedProductImageUrl);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: ListView.builder(
            physics: BouncingScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          height: 120,
                          width: 120,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: addedProductImageFilePath == ''
                                ? Border.all(color: grey, width: 1)
                                : null,
                            image: addedProductImageFilePath == ''
                                ? null
                                : DecorationImage(
                                    fit: BoxFit.cover,
                                    image: FileImage(
                                      File(addedProductImageFilePath),
                                    ),
                                  ),
                          ),
                          child: addedProductImageFilePath == ''
                              ? Center(
                                  child: Icon(
                                    Icons.pets,
                                    color: grey,
                                    size: 42,
                                  ),
                                )
                              : SizedBox(),
                        ),
                        SizedBox(width: 10),
                        GestureDetector(
                          onTap: addImage,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'Add image ',
                                style: TextStyle(
                                  color: green,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Icon(Icons.add_a_photo, color: green),
                            ],
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        children: [
                          TextField(
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(30),
                              FilteringTextInputFormatter(RegExp(r'[a-zA-Z\s]'),
                                  allow: true)
                            ],
                            controller: _nameController,
                            keyboardType: TextInputType.name,
                            autocorrect: false,
                            autofocus: false,
                            cursorColor: blue,
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(color: grey, width: 1),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                  color: lightBlue,
                                  width: 1,
                                ),
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 20,
                              ),
                              label: Text("Name"),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          TextField(
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(3),
                              FilteringTextInputFormatter(RegExp(r'[0-9]'),
                                  allow: true)
                            ],
                            controller: _ageController,
                            keyboardType: TextInputType.number,
                            autocorrect: false,
                            autofocus: false,
                            cursorColor: blue,
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(color: grey, width: 1),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                  color: lightBlue,
                                  width: 1,
                                ),
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 20,
                              ),
                              label: Text("Age"),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          DropdownButton2(
                            buttonStyleData: ButtonStyleData(
                              elevation: 0,
                              height: 60,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                border: Border.all(color: grey, width: 1),
                                color: white,
                                borderRadius: BorderRadius.circular(9),
                              ),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 15),
                            ),
                            underline: Text(''),
                            dropdownStyleData: DropdownStyleData(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            iconStyleData: IconStyleData(
                              icon: Icon(Icons.keyboard_arrow_down_rounded),
                              iconDisabledColor: black,
                              iconEnabledColor: green,
                            ),
                            isExpanded: true,
                            hint: Center(
                              child: Text(
                                'Gender',
                                style: TextStyle(
                                    fontSize: 16,
                                    color: black,
                                    fontWeight: FontWeight.w200),
                              ),
                            ),
                            items: genderList.map((String serviceCategoryList) {
                              return DropdownMenuItem(
                                child: Text(
                                  serviceCategoryList,
                                  overflow: TextOverflow.ellipsis,
                                  softWrap: true,
                                ),
                                value: serviceCategoryList,
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              setState(() {
                                genderValue = newValue!;
                              });
                            },
                            value: genderValue,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          TextField(
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(75),
                              FilteringTextInputFormatter(
                                  RegExp(r'[a-zA-Z0-9\s,]'),
                                  allow: true)
                            ],
                            controller: _locationController,
                            keyboardType: TextInputType.multiline,
                            autocorrect: false,
                            autofocus: false,
                            cursorColor: blue,
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(color: grey, width: 1),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                  color: lightBlue,
                                  width: 1,
                                ),
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 20,
                              ),
                              label: Text("Location"),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          TextField(
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(6),
                              FilteringTextInputFormatter(RegExp(r'[0-9]'),
                                  allow: true)
                            ],
                            controller: _priceController,
                            keyboardType: TextInputType.number,
                            autocorrect: false,
                            autofocus: false,
                            cursorColor: blue,
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(color: grey, width: 1),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                  color: lightBlue,
                                  width: 1,
                                ),
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 20,
                              ),
                              label: Text("Price"),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
            itemCount: 1,
          ),
        ),
        GestureDetector(
          onTap: addNewArrivalDetails,
          child: Container(
            height: 58,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(2), topRight: Radius.circular(2)),
              color: blue,
            ),
            child: Center(
              child: Text(
                'Save',
                style: TextStyle(
                  color: white,
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
