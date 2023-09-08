import 'package:flutter/material.dart';

import '../../Components/default_back_button.dart';
import '../../constants.dart';
import '../Add New Vet/Components/body.dart';

class AddVetScreen extends StatelessWidget {
  bool isAdmin;
  AddVetScreen({Key? key, this.isAdmin = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: white,
        elevation: 0,
        leading: DefaultBackButton(),
        title: Text(
          "Add New Veterinarian",
          style:
              TextStyle(fontSize: 20, color: blue, fontWeight: FontWeight.w500),
        ),
        centerTitle: true,
      ),
      backgroundColor: white,
      body: Body(
        isAdmin: isAdmin,
      ),
    );
  }
}
