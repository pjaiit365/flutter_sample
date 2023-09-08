import 'package:flutter/material.dart';
import 'package:pet_life_gh/screens/Forgot%20Password/component/body.dart';

import '../../constants.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            color: white,
            icon: Icon(Icons.arrow_back_ios_new_rounded),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          backgroundColor: blue,
          elevation: 0,
          title: Text('Forogt Password'),
          centerTitle: true,
          actions: [Icon(Icons.ac_unit), Icon(Icons.access_alarm)],
        ),
        body: Body());
  }
}
