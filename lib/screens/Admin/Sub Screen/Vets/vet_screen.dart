import 'package:flutter/material.dart';
import 'package:pet_life_gh/screens/Add%20New%20Vet/add_vet_screen.dart';

import '../../../../Components/default_back_button.dart';
import '../../../../constants.dart';
import '../../../Admin/Sub Screen/Vets/Components/body.dart';

class VetScreen extends StatelessWidget {
  const VetScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: white,
        elevation: 0,
        leading: DefaultBackButton(),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddVetScreen(
                      isAdmin: true,
                    ),
                  ));
            },
            icon: Icon(Icons.add),
          )
        ],
        title: Text(
          "Veterinarians",
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
