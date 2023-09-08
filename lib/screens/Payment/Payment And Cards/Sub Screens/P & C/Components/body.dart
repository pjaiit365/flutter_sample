import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../../../Components/profile_item.dart';
import '../../../../../../constants.dart';
import 'card_container.dart';

// class Body extends StatelessWidget {
//   const Body({Key? key}) : super(key: key);

// @override
// Widget build(BuildContext context) {
//   final cardNumberController = TextEditingController();
//   final expiryDateController = TextEditingController();
//   final cardNameController = TextEditingController();
//
//   // void AddCard() {
//   //   showDialog(
//   //     context: context,
//   //     builder: (context) {
//   //       // var cardNumberMask = MaskTextInputFormatter(
//   //       //     mask: '#### #### #### ####',
//   //       //     filter: {"#": RegExp(r'[0-9]')},
//   //       //     type: MaskAutoCompletionType.lazy);
//   //       // var expiryDatemask = MaskTextInputFormatter(
//   //       //     mask: '##/##',
//   //       //     filter: {"#": RegExp(r'[0-9]')},
//   //       //     type: MaskAutoCompletionType.lazy);
//   //
//   //       return Column(
//   //         mainAxisAlignment: MainAxisAlignment.center,
//   //         crossAxisAlignment: CrossAxisAlignment.center,
//   //         children: <Widget>[
//   //           AlertDialog(
//   //             insetPadding: EdgeInsets.all(10),
//   //             backgroundColor: Colors.transparent,
//   //             content: Container(
//   //               height: 357 ,
//   //               width: double.infinity,
//   //               decoration: BoxDecoration(
//   //                   color: white, borderRadius: BorderRadius.circular(24)),
//   //               padding: EdgeInsets.symmetric(
//   //                 vertical: 22 ,
//   //                 horizontal: 20.5 ,
//   //               ),
//   //               child: Column(
//   //                 mainAxisAlignment: MainAxisAlignment.start,
//   //                 crossAxisAlignment: CrossAxisAlignment.start,
//   //                 children: <Widget>[
//   //                   Center(
//   //                     child: Text('Add Card',
//   //                         style: TextStyle(
//   //                           color: black,
//   //                           fontSize: 18,
//   //                           fontWeight: FontWeight.w600,
//   //                         )),
//   //                   ),
//   //                   SizedBox(height: 10 ),
//   //                   ProfileAddressItem(
//   //                       inputFormatter: [
//   //                         FilteringTextInputFormatter.digitsOnly,
//   //                         LengthLimitingTextInputFormatter(16),
//   //                         // cardNumberMask,
//   //                       ],
//   //                       textEditingController: cardNumberController,
//   //                       title: 'Card number',
//   //                       hintText: 'Enter card number...',
//   //                       keyboardType: TextInputType.number),
//   //                   SizedBox(height: 20 ),
//   //                   ProfileAddressItem(
//   //                       inputFormatter: [
//   //                         FilteringTextInputFormatter.digitsOnly,
//   //                         LengthLimitingTextInputFormatter(4),
//   //                         // expiryDatemask,
//   //                       ],
//   //                       textEditingController: expiryDateController,
//   //                       title: 'Expiry Date',
//   //                       hintText: 'MM/YY',
//   //                       keyboardType: TextInputType.datetime),
//   //                   SizedBox(height: 20 ),
//   //                   ProfileAddressItem(
//   //                       inputFormatter: [
//   //                         FilteringTextInputFormatter.allow(RegExp(
//   //                             "[a-zA-Z\\s]")), // Only allow letters and spaces
//   //                         LengthLimitingTextInputFormatter(30),
//   //                       ],
//   //                       textEditingController: cardNameController,
//   //                       title: 'Card Name',
//   //                       hintText: 'Enter card name...',
//   //                       keyboardType: TextInputType.datetime),
//   //                 ],
//   //               ),
//   //             ),
//   //           ),
//   //           GestureDetector(
//   //             onTap: () {
//   //               // cardNumber.add(cardNumberController.text.trim());
//   //               // cardName.add(cardNameController.text.trim());
//   //               // cardExpiryDate.add(expiryDateController.text.trim());
//   //               // Navigator.pop(context);
//   //             },
//   //             child: Container(
//   //               height: 49 ,
//   //               width: 312 ,
//   //               decoration: BoxDecoration(
//   //                   color: green,
//   //                   borderRadius: BorderRadius.circular(5),
//   //                   border: Border.all(color: sectionColor, width: 3)),
//   //               child: Center(
//   //                 child: Text(
//   //                   'Save Card',
//   //                   style: TextStyle(
//   //                     color: white,
//   //                     fontWeight: FontWeight.w500,
//   //                     fontSize: 15,
//   //                   ),
//   //                 ),
//   //               ),
//   //             ),
//   //           ),
//   //         ],
//   //       );
//   //     },
//   //   );
//   // }
//
//   // return SingleChildScrollView(
//   //   child: Padding(
//   //     padding: EdgeInsets.only(
//   //       left:  20.0,
//   //       top: 20 ,
//   //       bottom: 20 ,
//   //     ),
//   //     child: Column(
//   //       mainAxisAlignment: MainAxisAlignment.start,
//   //       crossAxisAlignment: CrossAxisAlignment.start,
//   //       children: <Widget>[
//   //         // Center(
//   //         //   child: CredentialsButton(
//   //         //     screen: NotificationScreen(),
//   //         //     buttonText: 'In-app Funds',
//   //         //   ),
//   //         // ),
//   //         SizedBox(height: 27 ),
//   //         Padding(
//   //           padding: EdgeInsets.only(
//   //             left: 6 ,
//   //           ),
//   //           child: Text(
//   //             'My Cards',
//   //             style: TextStyle(
//   //               color: black,
//   //               fontSize: 17,
//   //               fontWeight: FontWeight.w600,
//   //             ),
//   //           ),
//   //         ),
//   //         SizedBox(height: 17 ),
//   //         SizedBox(
//   //           height: 267 ,
//   //           child: ListView.separated(
//   //               physics: BouncingScrollPhysics(),
//   //               shrinkWrap: true,
//   //               scrollDirection: Axis.horizontal,
//   //               itemBuilder: (context, index) {
//   //                 return Row(
//   //                   mainAxisAlignment: MainAxisAlignment.start,
//   //                   crossAxisAlignment: CrossAxisAlignment.center,
//   //                   children: <Widget>[
//   //                     // CardContainer(
//   //                     //     press: () {
//   //                           // cardLogo.removeAt(index);
//   //                           // cardExpiryDate.removeAt(index);
//   //                           // cardNumber.removeAt(index);
//   //                           // cardName.removeAt(index);
//   //                     //     },
//   //                     //     name: cardName[index],
//   //                     //     number: cardNumber[index],
//   //                     //     expiryDate: cardExpiryDate[index],
//   //                     //     cardLogo: cardLogo[index]),
//   //                     (cardNumber.length - 1) == index
//   //                         ? Padding(
//   //                             padding: EdgeInsets.symmetric(
//   //                                 horizontal: screenWidth * 30.0),
//   //                             child: GestureDetector(
//   //                               onTap: AddCard,
//   //                               child: Container(
//   //                                 height: 80 * screenHeight,
//   //                                 width: 80 * screenWidth,
//   //                                 decoration: BoxDecoration(
//   //                                   color: sectionColor,
//   //                                   shape: BoxShape.circle,
//   //                                 ),
//   //                                 child: Icon(Icons.add, color: chatBlue),
//   //                               ),
//   //                             ),
//   //                           )
//   //                         : SizedBox(),
//   //                   ],
//   //                 );
//   //               },
//   //               separatorBuilder: (context, index) {
//   //                 return SizedBox(width: 27 * screenWidth);
//   //               },
//   //               itemCount: cardNumber.length),
//   //         ),
//   //         SizedBox(height: 31 * screenHeight),
//   //         Padding(
//   //           padding: EdgeInsets.only(right: screenWidth * 20.0),
//   //           child: Row(
//   //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//   //             crossAxisAlignment: CrossAxisAlignment.center,
//   //             children: <Widget>[
//   //               Padding(
//   //                 padding: EdgeInsets.only(left: screenWidth * 6.0),
//   //                 child: Text(
//   //                   'History' + '(' + '4' + ')',
//   //                   style: TextStyle(
//   //                     color: black,
//   //                     fontSize: 17,
//   //                     fontWeight: FontWeight.w600,
//   //                   ),
//   //                 ),
//   //               ),
//   //               GestureDetector(
//   //                 onTap: () {
//   //                   Navigator.push(
//   //                       context,
//   //                       MaterialPageRoute(
//   //                         builder: (context) => NotificationScreen(),
//   //                       ));
//   //                 },
//   //                 child: Padding(
//   //                   padding: EdgeInsets.only(right: screenWidth * 10.0),
//   //                   child: Text(
//   //                     'See all',
//   //                     style: TextStyle(
//   //                       color: primary,
//   //                       fontSize: 16,
//   //                       fontWeight: FontWeight.w600,
//   //                     ),
//   //                   ),
//   //                 ),
//   //               ),
//   //             ],
//   //           ),
//   //         ),
//   //         SizedBox(height: 15 * screenHeight),
//   //         Center(
//   //           child: Container(
//   //             height: 1 * screenHeight,
//   //             width: 350 * screenWidth,
//   //             color: grey,
//   //           ),
//   //         ),
//   //         SizedBox(height: 16 * screenHeight),
//   //         Padding(
//   //           padding: EdgeInsets.only(right: screenWidth * 20.0),
//   //           child: ListView.separated(
//   //             shrinkWrap: true,
//   //             physics: NeverScrollableScrollPhysics(),
//   //             itemBuilder: (context, index) {
//   //               return HistoryItem(
//   //                   name: historyNameList[index],
//   //                   jobType: historyJobTypeList[index],
//   //                   picLocation: historyPicList[index],
//   //                   date: historyDateList[index],
//   //                   price: historyPriceList[index]);
//   //             },
//   //             separatorBuilder: (context, index) {
//   //               return SettingsDivider(isSettings: false);
//   //             },
//   //             itemCount: 4,
//   //           ),
//   //         )
//   //       ],
//   //     ),
//   //   ),
//   // );
// }
// }
