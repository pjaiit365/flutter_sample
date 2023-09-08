import 'package:flutter/material.dart';

import '../../../../Components/default_back_button.dart';
import '../../../../constants.dart';
import '../../../Admin/Sub Screen/All Products/Components/body.dart';

class AllProductScreen extends StatelessWidget {
  const AllProductScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: white,
        elevation: 0,
        leading: DefaultBackButton(),
        title: Text(
          "All Products",
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
