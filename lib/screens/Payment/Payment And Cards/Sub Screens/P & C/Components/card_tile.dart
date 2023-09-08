// import 'package:flutter/material.dart';
//
// import '../../../../../../constants.dart';
//
// class CardTile extends StatelessWidget {
//   final String title;
//   final String subtitle;
//   final Color color;
//   const CardTile({
//     Key? key,
//     required this.title,
//     required this.subtitle,
//     required this.color,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.start,
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: <Widget>[
//         Text(
//           title,
//           style: TextStyle(
//             color: color,
//             fontSize: 16,
//             fontWeight: FontWeight.w600,
//           ),
//         ),
//         SizedBox(height: 10 * screenHeight),
//         SizedBox(
//           width: 180 * screenWidth,
//           child: Text(
//             subtitle,
//             style: TextStyle(
//               color: color,
//               fontSize: 16,
//               fontWeight: FontWeight.w600,
//             ),
//             overflow: TextOverflow.ellipsis,
//           ),
//         ),
//       ],
//     );
//   }
// }
