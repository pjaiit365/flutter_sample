// import 'package:flutter/material.dart';
//
// import '../../../../../../constants.dart';
//
// class HistoryItem extends StatelessWidget {
//   final String name;
//   final String jobType;
//   final String picLocation;
//   final String date;
//   final String price;
//   const HistoryItem({
//     Key? key,
//     required this.name,
//     required this.jobType,
//     required this.picLocation,
//     required this.date,
//     required this.price,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.start,
//       crossAxisAlignment: CrossAxisAlignment.center,
//       children: <Widget>[
//         Container(
//           height: 57.73 * screenHeight,
//           width: 55 * screenWidth,
//           decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(16),
//               image: DecorationImage(
//                 image: AssetImage(
//                   picLocation,
//                 ),
//                 fit: BoxFit.fill,
//               )),
//         ),
//         SizedBox(width: 17 * screenWidth),
//         Column(
//           mainAxisAlignment: MainAxisAlignment.start,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: <Widget>[
//             SizedBox(
//               width: 140 * screenWidth,
//               child: Text(
//                 name,
//                 style: TextStyle(
//                   color: black,
//                   fontSize: 18,
//                   fontWeight: FontWeight.w500,
//                 ),
//                 softWrap: false,
//                 overflow: TextOverflow.fade,
//               ),
//             ),
//             SizedBox(
//               width: 120 / screenWidth,
//               child: Text(
//                 jobType,
//                 style: TextStyle(
//                   color: black,
//                   fontSize: 16,
//                   fontWeight: FontWeight.w200,
//                 ),
//                 overflow: TextOverflow.ellipsis,
//               ),
//             ),
//           ],
//         ),
//         Spacer(),
//         Column(
//           mainAxisAlignment: MainAxisAlignment.start,
//           crossAxisAlignment: CrossAxisAlignment.end,
//           children: <Widget>[
//             Text(
//               '\-' + '\$' + price,
//               style: TextStyle(
//                 color: black,
//                 fontSize: 18,
//                 fontWeight: FontWeight.w700,
//               ),
//             ),
//             Text(
//               date,
//               style: TextStyle(
//                 color: black,
//                 fontSize: 12,
//                 fontWeight: FontWeight.w200,
//               ),
//             ),
//           ],
//         ),
//       ],
//     );
//   }
// }
