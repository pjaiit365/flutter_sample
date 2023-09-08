// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:pet_life_gh/Components/vet_display_item.dart';
import 'package:pet_life_gh/Services/read_data.dart';
import 'package:pet_life_gh/constants.dart';
import 'package:pet_life_gh/screens/Custom%20Search%20Delegate/vet_search.dart';

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
                padding: const EdgeInsets.all(17.5),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12.0, vertical: 10),
                      child: Text(
                        'Choose a doctor and consult \nyour problem',
                        style: TextStyle(
                          color: black,
                          fontSize: 25,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    SizedBox(height: 15),
                    GestureDetector(
                      onTap: () {
                        showSearch(
                          context: context,
                          delegate: VetSearch(
                            itemsToSearch: vetNames,
                          ),
                        );
                      },
                      child: Container(
                        width: 359,
                        height: 55,
                        decoration: BoxDecoration(
                          color: white,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: grey, width: 1),
                        ),
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.only(left: 18),
                        child: Text(
                          "Search Veterinary's name...",
                          style: TextStyle(
                              color: grey,
                              fontSize: 17,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                    ),
                    SizedBox(height: 35),
                    ListView.separated(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return VetDisplayItem(
                          index: index,
                          name: allVets[index].name,
                          imageLocation: allVets[index].pic,
                          experience: allVets[index].experienceNumber,
                          star: allVets[index].starsRating,
                        );
                      },
                      separatorBuilder: (context, index) {
                        return SizedBox(height: 25);
                      },
                      itemCount: allVets.length,
                    ),
                  ],
                ),
              ),
            );
          }
          if (snapshot.hasError) {
            print(snapshot.error.toString());
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          return Center(child: CircularProgressIndicator());
        });
  }
}
