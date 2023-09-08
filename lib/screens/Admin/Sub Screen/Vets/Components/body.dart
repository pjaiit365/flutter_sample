import 'package:flutter/material.dart';
import 'package:pet_life_gh/Components/tab_item.dart';
import 'package:pet_life_gh/Services/read_data.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: ReadData().getAllVets(),
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
                    allVets.isNotEmpty
                        ? ListView.separated(
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return Center(
                                  child: TabItem(
                                idType: 'Vet',
                                name: allVets[index].experience,
                                index: index,
                                catID: allVets[index].vetID,
                                email: allVets[index].name,
                              ));
                            },
                            separatorBuilder: (context, index) {
                              return SizedBox(height: 24);
                            },
                            itemCount: allVets.length)
                        : Text('No vets available'),
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
