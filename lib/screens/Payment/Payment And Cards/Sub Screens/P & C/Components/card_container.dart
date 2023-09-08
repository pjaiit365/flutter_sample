// import 'package:flutter/material.dart';
//
// import '../../../../../../constants.dart';
// import 'card_tile.dart';
//
// class CardContainer extends StatelessWidget {
//   final String name;
//   final String number;
//   final String expiryDate;
//   final String cardLogo;
//   final VoidCallback press;
//   Color textColor;
//   Color cardColor;
//   CardContainer({
//     Key? key,
//     required this.name,
//     required this.number,
//     required this.expiryDate,
//     required this.cardLogo,
//     this.textColor = const Color(0xffffffff),
//     this.cardColor = const Color(0xff0076F7),
//     required this.press,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 267 * screenHeight,
//       width: 256 * screenWidth,
//       decoration: BoxDecoration(
//           color: chatBlue,
//           borderRadius: BorderRadius.circular(20),
//           border: Border.all(color: appointmentTimeColor, width: 1)),
//       padding: EdgeInsets.only(
//         top: 26 * screenHeight,
//         bottom: 0 * screenHeight,
//         right: 22.5 * screenWidth,
//         left: 25 * screenWidth,
//       ),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.start,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: <Widget>[
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: <Widget>[
//               Image.asset(
//                 cardLogo,
//                 color: textColor,
//               ),
//               GestureDetector(
//                 onTap: press,
//                 child: Icon(
//                   Icons.delete,
//                   color: textColor,
//                 ),
//               )
//             ],
//           ),
//           SizedBox(height: 15 * screenHeight),
//           CardTile(
//             subtitle: '**** **** **** 4765',
//             title: 'Card Number',
//             color: textColor,
//           ),
//           SizedBox(height: 15 * screenHeight),
//           CardTile(
//             subtitle: '**/**',
//             title: 'Expiry Date',
//             color: textColor,
//           ),
//           SizedBox(height: 15 * screenHeight),
//           CardTile(
//             subtitle: 'PJ Agrolics',
//             title: 'Card Name',
//             color: textColor,
//           ),
//         ],
//       ),
//     );
//   }
// }
