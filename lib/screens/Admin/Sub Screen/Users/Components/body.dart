import 'package:flutter/material.dart';
import 'package:pet_life_gh/Components/tab_item.dart';
import 'package:pet_life_gh/Services/read_data.dart';

import '../../../../../constants.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: ReadData().allUsersAdmin(),
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
                    allUsersAdmini.isNotEmpty
                        ? ListView.separated(
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return Center(
                                  child: TabItem(
                                idType: 'User',
                                name: allUsersAdmini[index].name,
                                index: index,
                                catID: allUsersAdmini[index].userID,
                                email: allUsersAdmini[index].email,
                              ));
                            },
                            separatorBuilder: (context, index) {
                              return SizedBox(height: 24);
                            },
                            itemCount: allUsersAdmini.length)
                        : Center(
                            child: Text(
                              'No Users available',
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
