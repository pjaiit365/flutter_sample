// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:pet_life_gh/Components/cart_item.dart';
import 'package:pet_life_gh/Components/pinned_button.dart';

import '../../../Services/read_data.dart';
import '../../../constants.dart';
import '../../Payment/PaymentOptions/payment_options_screen.dart';

class Body extends StatefulWidget {
  const Body({
    Key? key,
  }) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

num totalPrice = 0;

class _BodyState extends State<Body> {
  final locationController = TextEditingController();
  @override
  void dispose() {
    locationController.dispose();
    super.dispose();
  }

  String location = '';
  Future addLocation() async {
    final updatedLocation = await showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) => AlertDialog(
            insetPadding: EdgeInsets.symmetric(horizontal: 10),
            title: Center(
              child: Text('Add Location'),
            ),
            content: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                SizedBox(
                  width: 290,
                  child: TextField(
                    controller: locationController,
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
                      label: Text("Address"),
                    ),
                  ),
                ),
                SizedBox(height: 30),
                Center(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        location = locationController.text.trim();
                      });
                      Navigator.pop(context, location);
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
    if (updatedLocation != null) {
      setState(() {
        location = updatedLocation;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: ReadData().getAllCartItems().then((_) {
          totalPrice = 0;

          for (int i = 0; i < allCart.length; i++) {
            totalPrice = totalPrice + (allCart[i].price * allCart[i].quantity);
          }
        }),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 20),
                          ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                return CartItem(
                                  image: allCart[index].image,
                                  price: allCart[index].price,
                                  size: allCart[index].size,
                                  quantity: allCart[index].quantity,
                                  title: allCart[index].title,
                                );
                              },
                              itemCount: allCart.length),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            height: 1,
                            width: double.infinity,
                            color: grey,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 25.0, vertical: 20),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Amount to pay",
                                      style: TextStyle(
                                          color: green,
                                          fontSize: 17,
                                          fontWeight: FontWeight.w400),
                                    ),
                                    Spacer(),
                                    Text(
                                      "\$ $totalPrice",
                                      style: TextStyle(
                                          color: black,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w700),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 15),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Subscription",
                                      style: TextStyle(
                                          color: green,
                                          fontSize: 17,
                                          fontWeight: FontWeight.w400),
                                    ),
                                    Spacer(),
                                    Text(
                                      "Default",
                                      style: TextStyle(
                                          color: grey,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w700),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 15),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Delivery Fee",
                                      style: TextStyle(
                                          color: green,
                                          fontSize: 17,
                                          fontWeight: FontWeight.w400),
                                    ),
                                    Spacer(),
                                    Text(
                                      "Free",
                                      style: TextStyle(
                                          color: grey,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w700),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Container(
                            height: 1,
                            width: double.infinity,
                            color: grey,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Delivery Address",
                                      style: TextStyle(
                                          color: black,
                                          fontSize: 17,
                                          fontWeight: FontWeight.w400),
                                    ),
                                    Spacer(),
                                    GestureDetector(
                                      onTap: () {
                                        addLocation();
                                      },
                                      child: Text(
                                        location == ''
                                            ? "Add Location"
                                            : "Change Location",
                                        style: TextStyle(
                                          color: green,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 20),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SizedBox(width: 50),
                                    Icon(
                                      Icons.location_on_outlined,
                                      color: green,
                                      size: 40,
                                    ),
                                    SizedBox(width: 20),
                                    Text(
                                      locationController.text == ''
                                          ? 'No address added'
                                          : location,
                                      style: TextStyle(
                                          color: black,
                                          fontSize: 17,
                                          fontWeight: FontWeight.w600),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ],
                      );
                    },
                    itemCount: 1,
                  ),
                ),
                PinnedButton(
                  buttonText: 'Proceed to checkout',
                  icon: Icons.arrow_circle_right_sharp,
                  isIconPresent: true,
                  function: locationController.text.trim() == ''
                      ? () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              behavior: SnackBarBehavior.floating,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16)),
                              content: Center(
                                child: Text('Location field cannot be empty'),
                              ),
                            ),
                          );
                        }
                      : () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PaymentOptionsScreen(),
                            ),
                          );
                        },
                ),
              ],
            );
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          return Center(child: CircularProgressIndicator());
        });
  }
}
