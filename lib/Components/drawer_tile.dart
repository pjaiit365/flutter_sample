import 'package:flutter/material.dart';

import '../constants.dart';

class DrawerTile extends StatelessWidget {
  final Widget screen;
  final String title;
  final IconData icon;
  const DrawerTile({
    super.key,
    required this.screen,
    required this.title,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => screen),
        );
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: blue,
            size: 24,
          ),
          SizedBox(width: 10),
          Text(
            title,
            style: TextStyle(
              color: blue,
              fontSize: 17,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
