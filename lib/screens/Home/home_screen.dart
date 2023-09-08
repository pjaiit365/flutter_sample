import 'package:flutter/material.dart';
import 'package:pet_life_gh/constants.dart';
import 'package:pet_life_gh/screens/Home/Components/body.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: blue,
        title: const Text(
          'Welcome to PetLifeGh',
          style: TextStyle(
            color: white,
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
      ),
      backgroundColor: white,
      body: Body(),
    );
  }
}

