// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pet_life_gh/screens/Home2/home_screen2.dart';
import 'package:pet_life_gh/screens/wrapper.dart';

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
List addedProductImageUrlList = [];
String addedProductImageFilePath = '';
List<String> addProductImageFilePathList = [];
List descriptionList = [];

class _BodyState extends State<Body> {
  final titleController = TextEditingController();
  final detailController = TextEditingController();
  final priceController = TextEditingController();
  final sizeController = TextEditingController();
  final descriptionController = TextEditingController();

  @override
  void dispose() {
    titleController.dispose();
    detailController.dispose();
    priceController.dispose();
    sizeController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    addedProductImageUrlList.clear();
    addProductImageFilePathList.clear();
    descriptionList.clear();
    addedProductImageUrl = '';
    addedProductImageFilePath = '';
    genderValue = 'Male';

    super.initState();
  }

  Future addProductDetails() async {
    final document =
        await FirebaseFirestore.instance.collection('All Products').add({
      'Title': titleController.text.trim(),
      'Category': categoryValue,
      'Detail': detailController.text.trim(),
      'Description': descriptionList,
      'Size': double.parse(sizeController.text.trim()),
      'Price': int.parse(priceController.text.trim()),
      'User ID': loggedInUserId,
    });

    final docID = document.id;

    await uploadPic(docID);

    print(addedProductImageUrl);

    await FirebaseFirestore.instance
        .collection('All Products')
        .doc(docID)
        .update({
      'Product ID': docID,
      'Image': addedProductImageUrlList,
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
        setState(() {
          addedProductImage = results.files.single.name;
          addedProductImageFilePath = results.files.single.path!;
          if (!addProductImageFilePathList
              .contains(addedProductImageFilePath)) {
            addProductImageFilePathList.add(addedProductImageFilePath);
          }
        });
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future uploadPic(String productID) async {
    for (int i = 0; i < addProductImageFilePathList.length; i++) {
      File file = File(addProductImageFilePathList[i]);
      final querySnapshot = await FirebaseStorage.instance
          .ref('$loggedInUserID/Added Products/$productID/')
          .child('image_$i')
          .putFile(file);

      addedProductImageUrl = await querySnapshot.ref.getDownloadURL();
      if (!addedProductImageUrlList.contains(addedProductImageUrl)) {
        addedProductImageUrlList.add(addedProductImageUrl);
      }
    }
    print(addedProductImageUrlList);
  }

  void addDescription() async {
    List refresh = await showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) => AlertDialog(
            insetPadding: EdgeInsets.symmetric(horizontal: 10),
            title: Center(
              child: Text('Add Description'),
            ),
            content: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 230,
                      child: TextField(
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(75),
                          FilteringTextInputFormatter(
                              RegExp(r'[a-zA-Z0-9.,\s]'),
                              allow: true)
                        ],
                        controller: descriptionController,
                        keyboardType: TextInputType.name,
                        autocorrect: false,
                        autofocus: false,
                        cursorColor: blue,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(7),
                            borderSide: BorderSide(color: grey, width: 1),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(7),
                            borderSide: BorderSide(
                              color: lightBlue,
                              width: 1,
                            ),
                          ),
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 20,
                          ),
                          label: Text("Description"),
                        ),
                      ),
                    ),
                    Spacer(),
                    GestureDetector(
                      onTap: () {
                        if (descriptionController.text.isNotEmpty) {
                          setState(() {
                            descriptionList
                                .add(descriptionController.text.trim());
                            descriptionController.text = '';
                          });
                        }
                      },
                      child: Container(
                        height: 57,
                        width: 50,
                        decoration: BoxDecoration(
                            color: blue,
                            borderRadius: BorderRadius.circular(7)),
                        child: Center(
                          child: Icon(
                            Icons.add_box,
                            color: green,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 24),
                descriptionList.isNotEmpty
                    ? SizedBox(
                        height: 170,
                        width: 290,
                        child: ListView.separated(
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                  height: 7,
                                  width: 7,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: black,
                                  ),
                                ),
                                SizedBox(width: 12),
                                SizedBox(
                                  width: 270,
                                  child: Text(
                                    descriptionList[index],
                                    style: TextStyle(
                                      height: 1.5,
                                      color: black,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w400,
                                    ),
                                    overflow: TextOverflow.visible,
                                    softWrap: true,
                                  ),
                                )
                              ],
                            );
                          },
                          separatorBuilder: (context, index) {
                            return SizedBox(height: 24);
                          },
                          itemCount: descriptionList.length,
                        ),
                      )
                    : SizedBox(),
                SizedBox(height: 24),
                Center(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context, descriptionList);
                    },
                    child: Container(
                      height: 60,
                      width: 290,
                      decoration: BoxDecoration(
                        color: blue,
                        borderRadius: BorderRadius.circular(7),
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
                )
              ],
            ),
          ),
        );
      },
    );
    if (refresh.isNotEmpty) {
      setState(() {});
    }
  }

  bool fieldsCheck() {
    if (titleController.text.isNotEmpty &&
        detailController.text.isNotEmpty &&
        priceController.text.isNotEmpty &&
        sizeController.text.isNotEmpty &&
        descriptionList.isNotEmpty &&
        addProductImageFilePathList.isNotEmpty) {
      return true;
    } else {
      return false;
    }
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: addProductImageFilePathList.length == 3
                              ? () {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      behavior: SnackBarBehavior.floating,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(16)),
                                      content: Center(
                                        child: Text(
                                            'Maximum number of images reached.'),
                                      ),
                                    ),
                                  );
                                }
                              : addImage,
                          child: Container(
                            height: 50,
                            width: 130,
                            decoration: BoxDecoration(
                                color: white,
                                border: Border.all(color: grey, width: 1),
                                borderRadius: BorderRadius.circular(7)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
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
                          ),
                        ),
                        SizedBox(width: 10),
                        Text(
                          'Max No: 3',
                          style: TextStyle(
                            color: green,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    addProductImageFilePathList.isNotEmpty
                        ? Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 19.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Image Count: ${addProductImageFilePathList.length}',
                                  style: TextStyle(
                                    color: blue,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                SizedBox(height: 13),
                                SizedBox(
                                  height: 120,
                                  child: ListView.separated(
                                    physics: BouncingScrollPhysics(),
                                    scrollDirection: Axis.horizontal,
                                    shrinkWrap: true,
                                    itemBuilder: (context, index) {
                                      return Container(
                                        height: 120,
                                        width: 140,
                                        decoration: BoxDecoration(
                                            color: white,
                                            borderRadius:
                                                BorderRadius.circular(7),
                                            border: Border.all(
                                                color: grey, width: 1),
                                            image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: FileImage(
                                                File(
                                                    addProductImageFilePathList[
                                                        index]),
                                              ),
                                            )),
                                      );
                                    },
                                    separatorBuilder: (context, index) {
                                      return SizedBox(width: 20);
                                    },
                                    itemCount:
                                        addProductImageFilePathList.length,
                                  ),
                                ),
                              ],
                            ),
                          )
                        : SizedBox(),
                    addProductImageFilePathList.isNotEmpty
                        ? SizedBox(height: 40)
                        : SizedBox(height: 15),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment.topLeft,
                            child: Padding(
                              padding: EdgeInsets.only(left: 11.0),
                              child: Text(
                                'Category',
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
                                'Category',
                                style: TextStyle(
                                    fontSize: 16,
                                    color: black,
                                    fontWeight: FontWeight.w200),
                              ),
                            ),
                            items:
                                categoryList.map((String serviceCategoryList) {
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
                                categoryValue = newValue!;
                              });
                            },
                            value: categoryValue,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          TextField(
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(30),
                              FilteringTextInputFormatter(RegExp(r'[a-zA-Z\s]'),
                                  allow: true),
                            ],
                            controller: titleController,
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
                              label: Text("Title"),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          TextField(
                            inputFormatters: [
                              FilteringTextInputFormatter(
                                RegExp(r'[a-zA-Z0-9.\s]'),
                                allow: true,
                              )
                            ],
                            controller: detailController,
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
                              label: Text("Detail"),
                            ),
                          ),
                          SizedBox(height: 20),
                          TextField(
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(6),
                              FilteringTextInputFormatter(RegExp(r'[0-9]'),
                                  allow: true)
                            ],
                            controller: priceController,
                            keyboardType: TextInputType.number,
                            autocorrect: false,
                            autofocus: false,
                            cursorColor: blue,
                            decoration: InputDecoration(
                              // prefix: Text('GHS '),
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
                              label: Text("Price (in GHS)"),
                            ),
                          ),
                          SizedBox(height: 20),
                          TextField(
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(10),
                              FilteringTextInputFormatter(RegExp(r'[.0-9]'),
                                  allow: true)
                            ],
                            controller: sizeController,
                            keyboardType: TextInputType.number,
                            autocorrect: false,
                            autofocus: false,
                            cursorColor: blue,
                            decoration: InputDecoration(
                              suffix: Text('kg'),
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
                              label: Text("Size (in kilograms)"),
                            ),
                          ),
                          SizedBox(height: 20),
                          GestureDetector(
                            onTap: addDescription,
                            child: Container(
                              width: double.infinity,
                              height: 60,
                              decoration: BoxDecoration(
                                border: Border.all(color: grey, width: 1),
                                color: white,
                                borderRadius: BorderRadius.circular(9),
                              ),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 17, vertical: 15),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    'Add Description',
                                    style: TextStyle(
                                      color: borderColor,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Spacer(),
                                  Icon(Icons.add, color: green),
                                  SizedBox(width: 5),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 27),
                          ListView.separated(
                            padding: EdgeInsets.only(left: 30),
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Container(
                                    height: 7,
                                    width: 7,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: black,
                                    ),
                                  ),
                                  SizedBox(width: 12),
                                  SizedBox(
                                    width: 318,
                                    child: Text(
                                      descriptionList[index],
                                      style: TextStyle(
                                        height: 1.5,
                                        color: black,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w400,
                                      ),
                                      overflow: TextOverflow.visible,
                                      softWrap: true,
                                    ),
                                  )
                                ],
                              );
                            },
                            separatorBuilder: (context, index) {
                              return SizedBox(height: 24);
                            },
                            itemCount: descriptionList.length,
                          ),
                          SizedBox(height: 20),
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
          onTap: fieldsCheck()
              ? addProductDetails
              : () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      behavior: SnackBarBehavior.floating,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16)),
                      content: Center(
                        child: Text(
                            'All fields are required. Make sure all fields are entered.'),
                      ),
                    ),
                  );
                },
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
