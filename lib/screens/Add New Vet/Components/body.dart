// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pet_life_gh/screens/Admin/Sub%20Screen/Vets/vet_screen.dart';
import 'package:pet_life_gh/screens/Home2/home_screen2.dart';

import '../../../constants.dart';

class Body extends StatefulWidget {
  bool isAdmin;
  Body({
    this.isAdmin = false,
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
  final _contactNumberController = TextEditingController();
  final _locationController = TextEditingController();

  @override
  void dispose() {
    _ageController.dispose();
    _nameController.dispose();
    _locationController.dispose();
    _contactNumberController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    addedProductImageUrl = '';
    addedProductImageFilePath = '';
    super.initState();
  }

  Future addNewArrivalDetails() async {
    final document =
        await FirebaseFirestore.instance.collection('Veterinarian').add({
      'Name': _nameController.text.trim(),
      'Age': int.parse(_ageController.text.trim()),
      'Gender': genderValue,
      'Location': _locationController.text.trim(),
      'Contact Number': int.parse(_contactNumberController.text.trim()),
      'Region': regionValue,
      'Experience': experienceValue,
      'Stars Rating': 2,
    }).catchError((_) {
      throw 'Error occurred whilst uploading data. \nTry again.';
    });

    final docID = document.id;

    await uploadPic(docID, addedProductImageFilePath);

    await FirebaseFirestore.instance
        .collection('Veterinarian')
        .doc(docID)
        .update({
      'Vet ID': docID,
      'Image': addedProductImageUrl,
    });

    widget.isAdmin
        ? Navigator.push(
            context,
            MaterialPageRoute(
              builder: ((context) => VetScreen()),
            ),
          )
        : Navigator.push(
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
        setState(() {
          addedProductImageFilePath = results.files.single.path!;
        });
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future uploadPic(String id, String filePath) async {
    File file = File(filePath);
    final querySnapshot = await FirebaseStorage.instance
        .ref('Vet/$id')
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
                              FilteringTextInputFormatter.allow(
                                  RegExp(r'[a-zA-Z\s]'))
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
                                  color: green,
                                  width: 1,
                                ),
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 20,
                              ),
                              label: Text(
                                "Name",
                                style: TextStyle(color: borderColor),
                              ),
                              labelStyle: TextStyle(color: green),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 190,
                                child: TextField(
                                  inputFormatters: [
                                    FilteringTextInputFormatter(
                                        RegExp(r'[0-9]'),
                                        allow: true),
                                    LengthLimitingTextInputFormatter(35),
                                  ],
                                  controller: _ageController,
                                  keyboardType: TextInputType.number,
                                  autocorrect: false,
                                  autofocus: false,
                                  cursorColor: blue,
                                  textAlign: TextAlign.center,
                                  decoration: InputDecoration(
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide:
                                          BorderSide(color: grey, width: 1),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                        color: green,
                                        width: 1,
                                      ),
                                    ),
                                    contentPadding: EdgeInsets.symmetric(
                                      horizontal: 20,
                                      vertical: 20,
                                    ),
                                    label: Text(
                                      "Age",
                                      style: TextStyle(color: borderColor),
                                    ),
                                    labelStyle: TextStyle(color: green),
                                  ),
                                ),
                              ),
                              Spacer(),
                              DropdownButton2(
                                buttonStyleData: ButtonStyleData(
                                  elevation: 0,
                                  height: 60,
                                  width: 170,
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
                                items: genderList
                                    .map((String serviceCategoryList) {
                                  return DropdownMenuItem(
                                    child: Text(serviceCategoryList),
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
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          TextField(
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(40),
                              FilteringTextInputFormatter.allow(
                                  RegExp(r'[a-zA-Z\s,0-9]'))
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
                                  color: green,
                                  width: 1,
                                ),
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 20,
                              ),
                              label: Text(
                                "Location",
                                style: TextStyle(color: borderColor),
                              ),
                              labelStyle: TextStyle(color: green),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Align(
                            alignment: Alignment.topLeft,
                            child: Padding(
                              padding: EdgeInsets.only(left: 11.0),
                              child: Text(
                                'Region',
                                style: TextStyle(
                                  color: green,
                                  fontSize: 17,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 6),
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
                                'Region',
                                style: TextStyle(
                                    fontSize: 16,
                                    color: black,
                                    fontWeight: FontWeight.w200),
                              ),
                            ),
                            items: regionList.map((String serviceCategoryList) {
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
                                regionValue = newValue!;
                              });
                            },
                            value: regionValue,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Align(
                            alignment: Alignment.topLeft,
                            child: Padding(
                              padding: EdgeInsets.only(left: 11.0),
                              child: Text(
                                'Experience',
                                style: TextStyle(
                                  color: green,
                                  fontSize: 17,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 6),
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
                            items: experienceList
                                .map((String serviceCategoryList) {
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
                                experienceValue = newValue!;
                              });
                            },
                            value: experienceValue,
                          ),
                          SizedBox(height: 26),
                          TextField(
                            controller: _contactNumberController,
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter(RegExp(r'[0-9]'),
                                  allow: true),
                              LengthLimitingTextInputFormatter(10),
                            ],
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
                              label: Text(
                                "Contact Number",
                                style: TextStyle(color: borderColor),
                              ),
                              labelStyle: TextStyle(color: green),
                            ),
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

class ChargePerItem extends StatefulWidget {
  ChargePerItem({
    Key? key,
  }) : super(key: key);

  @override
  State<ChargePerItem> createState() => _ChargePerItemState();
}

class _ChargePerItemState extends State<ChargePerItem> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        DropdownButton2(
          buttonStyleData: ButtonStyleData(
            elevation: 0,
            height: 49,
            width: 150,
            decoration: BoxDecoration(
              color: white,
              borderRadius: BorderRadius.circular(7),
            ),
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          ),
          underline: Text(''),
          dropdownStyleData: DropdownStyleData(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
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
                  fontSize: 16, color: black, fontWeight: FontWeight.w200),
            ),
          ),
          items: genderList.map((String serviceCategoryList) {
            return DropdownMenuItem(
              child: Text(serviceCategoryList),
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
      ],
    );
  }
}
