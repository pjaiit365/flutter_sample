import 'package:flutter/material.dart';
import 'package:pet_life_gh/Components/tab_item.dart';
import 'package:pet_life_gh/Services/read_data.dart';

import '../../../../../constants.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: ReadData().getAllProducts(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(height: 24),
                    allProducts.isNotEmpty
                        ? ListView.separated(
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return Center(
                                  child: TabItem(
                                idType: 'Product',
                                name: allProducts[index].details,
                                index: index,
                                catID: allProducts[index].id,
                                email: allProducts[index].description,
                              ));
                            },
                            separatorBuilder: (context, index) {
                              return SizedBox(height: 24);
                            },
                            itemCount: allProducts.length)
                        : Center(
                            child: Text(
                              'No products available',
                              style: TextStyle(color: green),
                            ),
                          ),
                  ],
                ),
              ),
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        });
  }
}
