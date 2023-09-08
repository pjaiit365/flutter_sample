// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pet_life_gh/screens/Home2/home_screen2.dart';
import 'package:pet_life_gh/screens/Log%20In/log_in_screen.dart';

import '../../../constants.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  bool isPasswordVisible = false;
  bool isPasswordSeeable = false;

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPassword = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPassword.dispose();
    super.dispose();
  }

  Future signUp() async {
    try {
      if (confirmPasword()) {
        final document = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        )
            .catchError((err) {
          throw Exception(
              'An error occurred whilst creating the user. \n Try again later');
        });

        final userID = document.user!.uid;

        addUserDetails(
          _nameController.text.trim(),
          _emailController.text.trim(),
          userID,
        );
      }

      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => HomeSreen2()),
          (route) => false);
    } catch (e) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Center(child: Text('Error')),
              content: Text(e.toString()),
            );
          });
    }
  }

  bool confirmPasword() {
    if (_passwordController.text.trim() == _confirmPassword.text.trim()) {
      return true;
    } else {
      //TODO: Change to AlertDialog to display message
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Center(
        child: Text('Passwords do not match try again.'),
      )));
      return false;
    }
  }

  Future addUserDetails(String name, String email, String id) async {
    await FirebaseFirestore.instance.collection('users').add({
      'Name': name,
      'Email': email,
      'User ID': id,
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 230,
            width: double.infinity,
            decoration: BoxDecoration(color: blue),
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 30,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 130,
                  ),
                  Text(
                    "Register",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 35,
                      color: white,
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    "Create an account",
                    style: TextStyle(
                      fontWeight: FontWeight.w300,
                      fontSize: 15,
                      color: grey,
                    ),
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 45),
                TextField(
                  controller: _nameController,
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
                      borderSide: BorderSide(color: blue, width: 1),
                    ),
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                    label: Text('Full Name'),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                TextField(
                  controller: _emailController,
                  autocorrect: false,
                  autofocus: false,
                  cursorColor: blue,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: grey, width: 1),
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                      label: Text("Email Address")),
                ),
                SizedBox(height: 30),
                TextField(
                  controller: _passwordController,
                  obscureText: isPasswordVisible ? false : true,
                  autocorrect: false,
                  autofocus: false,
                  cursorColor: blue,
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                      splashColor: Colors.transparent,
                      onPressed: () {
                        setState(() {
                          isPasswordVisible = !isPasswordVisible;
                        });
                      },
                      icon: isPasswordVisible
                          ? Icon(Icons.visibility_off)
                          : Icon(Icons.visibility),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: grey, width: 1),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: blue, width: 1),
                    ),
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                    label: Text('Password'),
                  ),
                ),
                SizedBox(height: 30),
                TextField(
                  controller: _confirmPassword,
                  autocorrect: false,
                  autofocus: false,
                  cursorColor: blue,
                  obscureText: isPasswordSeeable ? false : true,
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: blue, width: 1),
                    ),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: grey, width: 1)),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 30,
                      vertical: 20,
                    ),
                    label: Text("Confirm Password"),
                    suffixIcon: IconButton(
                      splashColor: Colors.transparent,
                      onPressed: () {
                        setState(() {
                          isPasswordSeeable = !isPasswordSeeable;
                        });
                      },
                      icon: isPasswordSeeable
                          ? Icon(Icons.visibility_off)
                          : Icon(Icons.visibility),
                    ),
                  ),
                ),
                SizedBox(
                  height: 45,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: signUp,
                      child: Container(
                        height: 50,
                        width: 400,
                        decoration: BoxDecoration(
                          color: green,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Center(
                          child: Text(
                            "Sign Up",
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 60,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Already have an account?",
                          style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 15,
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return LogInScreen();
                                },
                              ),
                            );
                          },
                          child: Text(
                            "Sign in",
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.normal,
                                color: green),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 30,
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
