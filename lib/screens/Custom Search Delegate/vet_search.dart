// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:pet_life_gh/Services/read_data.dart';

import '../../Components/vet_display_item.dart';
import '../../constants.dart';

class VetSearch extends SearchDelegate<void> {
  final List itemsToSearch;

  VetSearch({required this.itemsToSearch});

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(
          Icons.clear,
          color: green,
        ),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(
        Icons.arrow_back_ios_rounded,
        color: black,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final List filteredItems = itemsToSearch
        .where((item) => item.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return filteredItems.isNotEmpty
        ? ListView.separated(
            padding: EdgeInsets.symmetric(vertical: 35 * screenHeight),
            physics: BouncingScrollPhysics(),
            itemCount: filteredItems.length,
            itemBuilder: (context, index) {
              late int itemIndex;
              if (allVets[index].name.contains(filteredItems[index])) {
                itemIndex = allVets[index].name.indexOf(filteredItems[index]);
              }
              return VetDisplayItem(
                index: index,
                name: allVets[itemIndex].name,
                imageLocation: allVets[itemIndex].pic,
                experience: allVets[itemIndex].experienceNumber,
                star: allVets[itemIndex].starsRating,
              );
            },
            separatorBuilder: (context, index) {
              return SizedBox(height: screenHeight * 20);
            },
          )
        : Center(
            child: Text('Vet not found'),
          );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final List filteredItems = itemsToSearch
        .where((item) => item.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return filteredItems.isNotEmpty
        ? ListView.separated(
            padding: EdgeInsets.symmetric(vertical: 35 * screenHeight),
            physics: BouncingScrollPhysics(),
            itemCount: filteredItems.length,
            itemBuilder: (context, index) {
              late int itemIndex;
              if (allVets[index].name.contains(filteredItems[index])) {
                itemIndex = allVets[index].name.indexOf(filteredItems[index]);
              }
              return VetDisplayItem(
                index: index,
                name: allVets[itemIndex].name,
                imageLocation: allVets[itemIndex].pic,
                experience: allVets[itemIndex].experienceNumber,
                star: allVets[itemIndex].starsRating,
              );
            },
            separatorBuilder: (context, index) {
              return SizedBox(height: screenHeight * 20);
            },
          )
        : Center(
            child: Text('Vet not found'),
          );
  }
}
