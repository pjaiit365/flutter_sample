// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import '../../../constants.dart';

class DashboardTabs extends StatelessWidget {
  final int index;
  final int selectedTabIndex;
  final String title;
  final Function onTabSelected;
  const DashboardTabs({
    Key? key,
    required this.title,
    required this.selectedTabIndex,
    required this.index, required this.onTabSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isTabSelected = index == selectedTabIndex;
    return GestureDetector(
      onTap: () {
        if (!isTabSelected) {
          onTabSelected(index);
        }
      },
      child: Container(
        height: 47,
        constraints: BoxConstraints(
          minWidth: 144,
        ),
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 13),
        decoration: BoxDecoration(
          color: isTabSelected ? green : white,
          borderRadius: BorderRadius.circular(50),
          border: Border.all(color: grey, width: 1),
        ),
        child: Center(
          child: Text(title,
              style: isTabSelected
                  ? TextStyle(
                      color: black,
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                    )
                  : TextStyle(
                      color: grey,
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    )),
        ),
      ),
    );
  }
}
