// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pet_life_gh/screens/Dashboard/dashboard_screen.dart';
import 'package:pet_life_gh/screens/Forgot%20Password/forgot_passwor_screen.dart';
import 'package:pet_life_gh/screens/Home2/home_screen2.dart';
import 'package:pet_life_gh/screens/Sign%20Up/sign_up_screen.dart';
import 'package:pet_life_gh/screens/wrapper.dart';

import '../../../constants.dart';
import '../../Admin/admin_screen.dart';

class Body extends StatefulWidget {
  const Body({
    Key? key,
  }) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  bool isPasswordVisible = false;

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future signIn() async {
    try {
      if (_emailController.text.trim() != 'admin@admin.com') {
        await FirebaseAuth.instance
            .signInWithEmailAndPassword(
                email: _emailController.text.trim(),
                password: _passwordController.text.trim())
            .catchError((err) {
          throw Exception('An error occurred. \n Try again later');
        });

        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => Wrapper()),
            (route) => false);
      } else {
        if (_passwordController.text.trim() == 'password') {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => AdminScreen()),
              (route) => false);
        } else {
          throw Exception('No record of this user.');
        }
      }
    } catch (e) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Error'),
              content: Text(e.toString()),
            );
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 240,
            width: double.infinity,
            decoration: BoxDecoration(
              color: blue,
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Spacer(),
                  Text(
                    "Sign in to your \n Account",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 30,
                      color: white,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Sign in to your account",
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 15,
                      color: white,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: (30),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 45,
                ),
                TextField(
                  controller: _emailController,
                  autocorrect: false,
                  autofocus: false,
                  cursorColor: blue,
                  decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: grey,
                          width: 1,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: blue,
                          width: 1,
                        ),
                      ),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10,
                      ),
                      label: Text("Email")),
                  keyboardType: TextInputType.emailAddress,
                ),
                SizedBox(
                  height: 30,
                ),
                TextField(
                  controller: _passwordController,
                  autocorrect: false,
                  autofocus: false,
                  cursorColor: blue,
                  obscureText: isPasswordVisible ? false : true,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: grey,
                        width: 1,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: blue,
                        width: 1,
                      ),
                    ),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
                    label: Text("password"),
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          isPasswordVisible = !isPasswordVisible;
                        });
                      },
                      icon: isPasswordVisible
                          ? Icon(Icons.visibility_off)
                          : Icon(Icons.visibility),
                      splashColor: Colors.transparent,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ForgotPasswordScreen()));
                      },
                      child: Text(
                        "Forgot password?",
                        style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 15,
                          color: green,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                GestureDetector(
                  onTap: signIn,
                  child: Container(
                    height: 50,
                    width: 350,
                    decoration: BoxDecoration(
                      color: green,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Center(
                      child: Text(
                        "Login",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: borderColor),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: 1,
                      width: 120,
                      color: grey,
                    ),
                    Text(
                      "Log in with",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    Container(
                      height: 1,
                      width: 120,
                      color: grey,
                    ),
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 50,
                      width: 164,
                      decoration: BoxDecoration(
                        color: grey,
                        borderRadius: BorderRadius.circular(
                          4,
                        ),
                      ),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset(
                              'asset/icon/apple.png',
                              height: 16,
                              width: 18,
                            ),
                            SizedBox(width: 6),
                            Text(
                              "Apple",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      height: 50,
                      width: 164,
                      decoration: BoxDecoration(
                        color: grey,
                        borderRadius: BorderRadius.circular(
                          4,
                        ),
                      ),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset(
                              'asset/icon/google.png',
                              height: 16,
                              width: 18,
                            ),
                            SizedBox(width: 6),
                            Text(
                              "Google",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 60,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Don't have an account?",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SignUpScreen(),
                          ),
                        );
                      },
                      child: Text(
                        "Sign Up",
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.normal,
                            color: green),
                      ),
                    ),
                    SizedBox(
                      height: 45,
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
