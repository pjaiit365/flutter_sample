import 'package:flutter/material.dart';

import '../../Components/default_back_button.dart';
import '../../constants.dart';
import '../Add New Arrival/Components/body.dart';

class AddNewArrivals extends StatelessWidget {
  const AddNewArrivals({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: white,
        elevation: 0,
        leading: DefaultBackButton(),
        title: Text(
          "Add New Arrival",
          style:
              TextStyle(fontSize: 20, color: blue, fontWeight: FontWeight.w500),
        ),
        centerTitle: true,
      ),
      backgroundColor: white,
      body: Body(),
    );
  }
}
