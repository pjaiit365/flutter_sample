import 'package:flutter/material.dart';

import '../../Components/default_back_button.dart';
import '../../constants.dart';
import '../New Arrival/Components/body.dart';

class NewArrivalPage extends StatelessWidget {
  const NewArrivalPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: DefaultBackButton(),
        elevation: 1,
        backgroundColor: white,
        title: Text(
          "RaiSun Enterprise",
          style: TextStyle(
            color: blue,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      backgroundColor: white,
      body: Body(),
    );
  }
}
