import 'package:flutter/material.dart';
import 'package:pet_life_gh/Components/default_back_button.dart';
import 'package:pet_life_gh/constants.dart';
import 'package:pet_life_gh/screens/Feature%20Product/Component/body.dart';

class FeaturedProductPage extends StatefulWidget {
  const FeaturedProductPage({super.key});

  @override
  State<FeaturedProductPage> createState() => _FeaturedProductPageState();
}

class _FeaturedProductPageState extends State<FeaturedProductPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: DefaultBackButton(),
        elevation: 1,
        backgroundColor: white,
        title: Text(
          "GeoRich Enterprise",
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
