import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import '../constants.dart';

var chargeRateHintText = '';
var expertiseHintText = '';

class ChargePerItem extends StatefulWidget {
  final String title;
  String hintText;
  double width;
  List<String> listName;
  bool isReadOnly;
  bool isChargeRate;

  ChargePerItem({
    super.key,
    required this.title,
    this.width = 117.0,
    required this.listName,
    this.hintText = 'N/A',
    this.isReadOnly = false,
    this.isChargeRate = false,
  });
  @override
  State<ChargePerItem> createState() => _ChargePerItemState();
}

class _ChargePerItemState extends State<ChargePerItem> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(left: 11.0),
          child: Text(
            widget.title,
            style: TextStyle(
              color: black,
              fontSize: 17,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        SizedBox(height: 6),
        DropdownButton2(
          buttonStyleData: ButtonStyleData(
            elevation: 0,
            height: 49,
            width: widget.width,
            decoration: BoxDecoration(
              color: white,
              borderRadius: BorderRadius.circular(7),
            ),
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          ),
          underline: Text(''),
          dropdownStyleData: DropdownStyleData(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          iconStyleData: IconStyleData(
            icon: Icon(Icons.keyboard_arrow_down_rounded),
            iconDisabledColor: black,
          ),
          isExpanded: true,
          hint: Center(
            child: Text(
              widget.hintText,
              style: TextStyle(
                  fontSize: 16, color: black, fontWeight: FontWeight.w200),
            ),
          ),
          items: widget.listName.map((String serviceCategoryList) {
            return DropdownMenuItem(
              child: Text(serviceCategoryList),
              value: serviceCategoryList,
            );
          }).toList(),
          onChanged: widget.isReadOnly
              ? null
              : (String? newValue) {
                  setState(() {
                    widget.isChargeRate
                        ? chargeRateHintText = newValue!
                        : expertiseHintText = newValue!;
                  });
                },
          value:
              widget.isChargeRate ? chargeRateHintText = '' : expertiseHintText,
        ),
      ],
    );
  }
}

// class ProfileItemAddFile extends StatefulWidget {
//   final String title;
//   final String hintText;
//   List<String> listName;
//   List selectedOptions;
//   bool isWidthMax;
//   bool isChargeRate;
//   bool isMomoOptions;
//   bool isReadOnly;
//   ProfileItemAddFile({
//     Key? key,
//     required this.title,
//     required this.hintText,
//     required this.listName,
//     required this.selectedOptions,
//     this.isWidthMax = true,
//     this.isChargeRate = false,
//     this.isMomoOptions = false,
//     this.isReadOnly = true,
//   }) : super(key: key);
//
//   @override
//   State<ProfileItemAddFile> createState() => _ProfileItemAddFileState();
// }
//
// class _ProfileItemAddFileState extends State<ProfileItemAddFile> {
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.start,
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: <Widget>[
//         Padding(
//           padding: EdgeInsets.only(left: screenWidth * 11.0),
//           child: Text(
//             widget.title,
//             style: TextStyle(
//               color: black,
//               fontSize: 17,
//               fontWeight: FontWeight.w500,
//             ),
//           ),
//         ),
//         SizedBox(height: 6 * screenHeight),
//         DropdownButton2(
//           buttonStyleData: ButtonStyleData(
//             elevation: 0,
//             height: 49 * screenHeight,
//             width: widget.isWidthMax ? 310 * screenWidth : 117 * screenWidth,
//             decoration: BoxDecoration(
//               color: white,
//               borderRadius: BorderRadius.circular(7),
//             ),
//             padding: EdgeInsets.symmetric(
//                 horizontal: 15 * screenWidth, vertical: 15 * screenHeight),
//           ),
//           underline: Text(''),
//           dropdownStyleData: DropdownStyleData(
//             padding: EdgeInsets.symmetric(
//                 horizontal: 10 * screenWidth, vertical: 10 * screenHeight),
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(10),
//             ),
//           ),
//           iconStyleData: IconStyleData(
//             icon: Icon(Icons.add),
//             iconDisabledColor: black,
//             iconEnabledColor: primary,
//           ),
//           isExpanded: true,
//           hint: Text(
//             widget.hintText,
//             style: TextStyle(
//                 fontSize: 16, fontWeight: FontWeight.w200, color: black),
//           ),
//           items: widget.listName.map((String serviceCategoryList) {
//             return DropdownMenuItem(
//               child: Text(serviceCategoryList),
//               value: serviceCategoryList,
//             );
//           }).toList(),
//           onChanged: widget.isReadOnly
//               ? null
//               : (String? newValue) {
//                   if (!widget.selectedOptions.contains(newValue)) {
//                     setState(() {
//                       dropdownvalue = newValue!;
//                       widget.selectedOptions.add(dropdownvalue);
//                       if (dropdownvalue == 'MTN Mobile Money') {
//                         selectedMomoOptionsIcons
//                             .add('assets/icons/mtn_momo.png');
//                       } else if (dropdownvalue == 'Vodafone Cash') {
//                         selectedMomoOptionsIcons
//                             .add('assets/icons/vodafone_cash.png');
//                       } else if (dropdownvalue == 'Airtel/Tigo Money') {
//                         selectedMomoOptionsIcons
//                             .add('assets/icons/airtel_tigo.png');
//                       } else {}
//                       print(widget.selectedOptions);
//                     });
//                   }
//                 },
//           value: widget.isChargeRate ? dropdownvalue : null,
//         ),
//         widget.selectedOptions.isEmpty
//             ? SizedBox(height: 0, width: 0)
//             : SizedBox(height: 16 * screenHeight),
//         widget.selectedOptions.isEmpty
//             ? SizedBox(height: 0, width: 0)
//             : ListView.separated(
//                 shrinkWrap: true,
//                 physics: NeverScrollableScrollPhysics(),
//                 itemBuilder: (context, index) {
//                   return AddedFileContainer(
//                     fileName: '',
//                     isMomoOptions: widget.isMomoOptions,
//                     index: index,
//                     child: GestureDetector(
//                       onTap: widget.isReadOnly
//                           ? null
//                           : () {
//                               setState(() {
//                                 widget.selectedOptions.removeAt(index);
//                               });
//                             },
//                       child: Icon(Icons.remove, color: primary, size: 30),
//                     ),
//                   );
//                 },
//                 separatorBuilder: (context, index) {
//                   return SizedBox(
//                     height: 8 * screenHeight,
//                   );
//                 },
//                 itemCount: widget.selectedOptions.length),
//       ],
//     );
//   }
// }

// class ProfileItemAddAddress extends StatefulWidget {
//   final VoidCallback screen;
//   final TextEditingController streetNameController;
//   final TextEditingController townController;
//   final TextEditingController houseNumController;
//   final String title;
//   final String hintText;
//   final bool isReadOnly;
//
//   ProfileItemAddAddress({
//     Key? key,
//     required this.title,
//     required this.hintText,
//     required this.streetNameController,
//     required this.townController,
//     required this.houseNumController,
//     required this.screen,
//     required this.isReadOnly,
//   }) : super(key: key);
//   @override
//   State<ProfileItemAddAddress> createState() => _ProfileItemAddAddressState();
// }
//
// class _ProfileItemAddAddressState extends State<ProfileItemAddAddress> {
//   @override
//   Widget build(BuildContext context) {
//     void _AddressDialogBox() {
//       setState(() {});
//       showDialog(
//         context: context,
//         builder: (context) {
//           return Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: <Widget>[
//               AlertDialog(
//                 insetPadding: EdgeInsets.all(10),
//                 backgroundColor: Colors.transparent,
//                 content: Container(
//                   height: 357 * screenHeight,
//                   width: double.infinity,
//                   decoration: BoxDecoration(
//                       color: white, borderRadius: BorderRadius.circular(24)),
//                   padding: EdgeInsets.symmetric(
//                     vertical: 22 * screenWidth,
//                     horizontal: 20.5 * screenWidth,
//                   ),
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: <Widget>[
//                       Center(
//                         child: Text('Address Information',
//                             style: TextStyle(
//                               color: black,
//                               fontSize: 18,
//                               fontWeight: FontWeight.w600,
//                             )),
//                       ),
//                       SizedBox(height: 10 * screenHeight),
//                       ProfileAddressItem(
//                           inputFormatter: [
//                             FilteringTextInputFormatter.allow(RegExp(
//                                 r'[a-zA-Z0-9\s]')), // Only allow letters and spaces
//                             LengthLimitingTextInputFormatter(18),
//                           ],
//                           textEditingController: widget.streetNameController,
//                           title: 'Street name',
//                           hintText: 'Enter street name...',
//                           keyboardType: TextInputType.streetAddress),
//                       SizedBox(height: 20 * screenHeight),
//                       ProfileAddressItem(
//                           inputFormatter: [
//                             FilteringTextInputFormatter.allow(RegExp(
//                                 r'[a-zA-Z\\s]')), // Only allow letters and spaces
//                             LengthLimitingTextInputFormatter(18),
//                           ],
//                           textEditingController: widget.townController,
//                           title: 'Town',
//                           hintText: 'Enter town name...',
//                           keyboardType: TextInputType.name),
//                       SizedBox(height: 20 * screenHeight),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: <Widget>[
//                           RegionSelect(dropdownList: regionsList),
//                           Spacer(),
//                           ProfileAddressItem(
//                               inputFormatter: [
//                                 FilteringTextInputFormatter.allow(RegExp(
//                                     r'[a-zA-Z0-9\s]')), // Only allow letters and spaces
//                                 LengthLimitingTextInputFormatter(10),
//                               ],
//                               textEditingController: widget.houseNumController,
//                               isWidthMax: false,
//                               width: 118,
//                               title: 'House Number',
//                               hintText: 'House No.',
//                               keyboardType: TextInputType.name),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               GestureDetector(
//                 onTap: widget.screen,
//                 child: Container(
//                   height: 49 * screenHeight,
//                   width: 310 * screenWidth,
//                   decoration: BoxDecoration(
//                       color: primary,
//                       borderRadius: BorderRadius.circular(5),
//                       border: Border.all(color: sectionColor, width: 3)),
//                   child: Center(
//                     child: Text(
//                       'Save Address',
//                       style: TextStyle(
//                         color: white,
//                         fontWeight: FontWeight.w500,
//                         fontSize: 15,
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           );
//         },
//       );
//     }
//
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.start,
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: <Widget>[
//         Padding(
//           padding: EdgeInsets.only(left: screenWidth * 11.0),
//           child: Text(
//             widget.title,
//             style: TextStyle(
//               color: black,
//               fontSize: 17,
//               fontWeight: FontWeight.w500,
//             ),
//           ),
//         ),
//         GestureDetector(
//           onTap: widget.isReadOnly ? () {} : _AddressDialogBox,
//           child: Container(
//             height: 49 * screenHeight,
//             width: 310 * screenWidth,
//             decoration: BoxDecoration(
//               color: white,
//               borderRadius: BorderRadius.circular(7),
//             ),
//             padding: EdgeInsets.symmetric(
//                 horizontal: 15 * screenWidth, vertical: 15 * screenHeight),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.start,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: <Widget>[
//                 Text(
//                   widget.hintText,
//                   style: TextStyle(
//                     fontSize: 16,
//                     fontWeight: FontWeight.w100,
//                     color: black,
//                   ),
//                 ),
//                 Spacer(),
//                 Icon(Icons.add),
//               ],
//             ),
//           ),
//         ),
//         SizedBox(height: 6 * screenHeight),
//       ],
//     );
//   }
// }

// class RegionSelect extends StatefulWidget {
//   bool isJobUpload;
//   num width;
//   final List<String> dropdownList;
//   RegionSelect({
//     Key? key,
//     this.width = 151,
//     this.isJobUpload = false,
//     required this.dropdownList,
//   }) : super(key: key);
//
//   @override
//   State<RegionSelect> createState() => _RegionSelectState();
// }
//
// class _RegionSelectState extends State<RegionSelect> {
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.start,
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: <Widget>[
//         widget.isJobUpload
//             ? SizedBox()
//             : Padding(
//                 padding: EdgeInsets.only(left: screenWidth * 1.5),
//                 child: Text(
//                   'Region',
//                   style: TextStyle(
//                     color: primary,
//                     fontSize: 16,
//                   ),
//                 ),
//               ),
//         SizedBox(height: 7 * screenHeight),
//         DropdownButton2(
//           buttonStyleData: ButtonStyleData(
//             elevation: 0,
//             height: 49 * screenHeight,
//             width: widget.width * screenWidth,
//             decoration: BoxDecoration(
//               color: white,
//               borderRadius: BorderRadius.circular(7),
//               border: Border.all(color: appointmentTimeColor, width: 1),
//             ),
//             padding: EdgeInsets.symmetric(
//                 horizontal: 15 * screenWidth, vertical: 12 * screenHeight),
//           ),
//           underline: Text(''),
//           dropdownStyleData: DropdownStyleData(
//             width: 275 * screenWidth,
//             maxHeight: 210 * screenHeight,
//             padding: EdgeInsets.symmetric(
//                 horizontal: 10 * screenWidth, vertical: 10 * screenHeight),
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(10),
//             ),
//           ),
//           iconStyleData: IconStyleData(
//             icon: Icon(Icons.keyboard_arrow_down_rounded),
//             iconEnabledColor: black,
//           ),
//           isExpanded: true,
//           hint: Center(
//             child: Text(
//               'Choose one',
//               style: TextStyle(
//                   fontSize: 16, color: black, fontWeight: FontWeight.w200),
//             ),
//           ),
//           items: widget.dropdownList.map((String serviceCategoryList) {
//             return DropdownMenuItem(
//               child: Text(
//                 serviceCategoryList,
//                 overflow: TextOverflow.ellipsis,
//                 softWrap: true,
//               ),
//               value: serviceCategoryList,
//             );
//           }).toList(),
//           onChanged: (String? newValue) {
//             setState(() {
//               dropdownvalue = newValue!;
//               regionValue = dropdownvalue;
//               apppointmentRegion = regionValue;
//             });
//           },
//           value: dropdownvalue,
//         ),
//       ],
//     );
//   }
// }

// class ChargeRateSelect extends StatefulWidget {
//   const ChargeRateSelect({
//     Key? key,
//   }) : super(key: key);
//
//   @override
//   State<ChargeRateSelect> createState() => _ChargeRateSelectState();
// }
//
// class _ChargeRateSelectState extends State<ChargeRateSelect> {
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.start,
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: <Widget>[
//         Padding(
//           padding: EdgeInsets.only(left: screenWidth * 11.0),
//           child: Text(
//             'Charge per',
//             style: TextStyle(
//               color: black,
//               fontSize: 17,
//               fontWeight: FontWeight.w500,
//             ),
//           ),
//         ),
//         SizedBox(height: 6 * screenHeight),
//         DropdownButton2(
//           buttonStyleData: ButtonStyleData(
//             elevation: 0,
//             height: 49 * screenHeight,
//             width: 117 * screenWidth,
//             decoration: BoxDecoration(
//               color: white,
//               borderRadius: BorderRadius.circular(7),
//             ),
//             padding: EdgeInsets.symmetric(
//                 horizontal: 15 * screenWidth, vertical: 12 * screenHeight),
//           ),
//           underline: Text(''),
//           dropdownStyleData: DropdownStyleData(
//             width: 140 * screenWidth,
//             padding: EdgeInsets.symmetric(
//                 horizontal: 10 * screenWidth, vertical: 10 * screenHeight),
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(10),
//             ),
//           ),
//           iconStyleData: IconStyleData(
//             icon: Icon(Icons.keyboard_arrow_down_rounded),
//             iconDisabledColor: black,
//             iconEnabledColor: primary,
//           ),
//           isExpanded: true,
//           hint: Center(
//             child: Text(
//               'Choose one',
//               style: TextStyle(
//                   fontSize: 16, color: black, fontWeight: FontWeight.w200),
//             ),
//           ),
//           items: chargePerList.map((String serviceCategoryList) {
//             return DropdownMenuItem(
//               child: Text(
//                 serviceCategoryList,
//                 overflow: TextOverflow.ellipsis,
//                 softWrap: true,
//               ),
//               value: serviceCategoryList,
//             );
//           }).toList(),
//           onChanged: isServiceInfoReadOnly
//               ? null
//               : (String? newValue) {
//                   setState(() {
//                     chargeRateHintText = newValue!;
//                   });
//                 },
//           value: chargeRateHintText.toString(),
//         ),
//       ],
//     );
//   }
// }

// class ExpertiseSelect extends StatefulWidget {
//   const ExpertiseSelect({
//     Key? key,
//   }) : super(key: key);
//
//   @override
//   State<ExpertiseSelect> createState() => _ExpertiseSelectState();
// }
//
// class _ExpertiseSelectState extends State<ExpertiseSelect> {
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.start,
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: <Widget>[
//         Padding(
//           padding: EdgeInsets.only(left: screenWidth * 11.0),
//           child: Text(
//             'Level of Expertise',
//             style: TextStyle(
//               color: black,
//               fontSize: 17,
//               fontWeight: FontWeight.w500,
//             ),
//           ),
//         ),
//         SizedBox(height: 6 * screenHeight),
//         DropdownButton2(
//           buttonStyleData: ButtonStyleData(
//             elevation: 0,
//             height: 49 * screenHeight,
//             width: 310 * screenWidth,
//             decoration: BoxDecoration(
//               color: white,
//               borderRadius: BorderRadius.circular(7),
//             ),
//             padding: EdgeInsets.symmetric(
//                 horizontal: 15 * screenWidth, vertical: 12 * screenHeight),
//           ),
//           underline: Text(''),
//           dropdownStyleData: DropdownStyleData(
//             padding: EdgeInsets.symmetric(
//                 horizontal: 10 * screenWidth, vertical: 10 * screenHeight),
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(10),
//             ),
//           ),
//           iconStyleData: IconStyleData(
//             icon: Icon(Icons.keyboard_arrow_down_rounded),
//             iconDisabledColor: black,
//             iconEnabledColor: primary,
//           ),
//           isExpanded: true,
//           hint: Center(
//             child: Text(
//               'Choose one',
//               style: TextStyle(
//                   fontSize: 16, color: black, fontWeight: FontWeight.w200),
//             ),
//           ),
//           items: expertiseList.map((String serviceCategoryList) {
//             return DropdownMenuItem(
//               child: Text(
//                 serviceCategoryList,
//                 overflow: TextOverflow.ellipsis,
//                 softWrap: true,
//               ),
//               value: serviceCategoryList,
//             );
//           }).toList(),
//           onChanged: isServiceInfoReadOnly
//               ? null
//               : (String? newValue) {
//                   setState(() {
//                     expertiseHintText = newValue!;
//                   });
//                 },
//           value: expertiseHintText.toString(),
//         ),
//       ],
//     );
//   }
// }

//--------------------------------------------------------------

// class ServiceCategorySelect extends StatefulWidget {
//   bool isReadOnly;
//   String hintText;
//   final String title;
//   final List<String> dropdownList;
//   num width;
//   final ValueChanged<String> onChanged;
//   ServiceCategorySelect({
//     Key? key,
//     this.hintText = 'N/A',
//     this.isReadOnly = false,
//     this.width = 310,
//     required this.dropdownList,
//     required this.title,
//     required this.onChanged,
//   }) : super(key: key);
//
//   @override
//   State<ServiceCategorySelect> createState() => _ServiceCategorySelect();
// }
//
// class _ServiceCategorySelect extends State<ServiceCategorySelect> {
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.start,
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: <Widget>[
//         Padding(
//           padding: EdgeInsets.only(left: screenWidth * 11.0),
//           child: Text(
//             widget.title,
//             style: TextStyle(
//               color: black,
//               fontSize: 17,
//               fontWeight: FontWeight.w500,
//             ),
//           ),
//         ),
//         SizedBox(height: 6 * screenHeight),
//         DropdownButton2(
//           buttonStyleData: ButtonStyleData(
//             elevation: 0,
//             height: 49 * screenHeight,
//             width: widget.width * screenWidth,
//             decoration: BoxDecoration(
//               color: white,
//               borderRadius: BorderRadius.circular(7),
//             ),
//             padding: EdgeInsets.symmetric(
//                 horizontal: 15 * screenWidth, vertical: 12 * screenHeight),
//           ),
//           underline: Text(''),
//           dropdownStyleData: DropdownStyleData(
//             padding: EdgeInsets.symmetric(
//                 horizontal: 10 * screenWidth, vertical: 10 * screenHeight),
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(10),
//             ),
//           ),
//           iconStyleData: IconStyleData(
//             icon: Icon(Icons.keyboard_arrow_down_rounded),
//             iconDisabledColor: black,
//             iconEnabledColor: primary,
//           ),
//           isExpanded: true,
//           hint: Center(
//             child: Text(
//               'Select only one',
//               style: TextStyle(
//                   fontSize: 16, color: black, fontWeight: FontWeight.w200),
//             ),
//           ),
//           items: widget.dropdownList.map((String serviceCategoryList) {
//             return DropdownMenuItem(
//               child: Text(
//                 serviceCategoryList,
//                 overflow: TextOverflow.ellipsis,
//                 softWrap: true,
//               ),
//               value: serviceCategoryList,
//             );
//           }).toList(),
//           onChanged: widget.isReadOnly
//               ? null
//               : (String? newValue) {
//                   setState(() {
//                     widget.onChanged(newValue!);
//                   });
//                 },
//           value: widget.hintText,
//         ),
//       ],
//     );
//   }
// }

// class SeenBySelect extends StatefulWidget {
//   bool isReadOnly;
//   SeenBySelect({
//     Key? key,
//     this.isReadOnly = false,
//   }) : super(key: key);
//
//   @override
//   State<SeenBySelect> createState() => _SeenBySelectState();
// }
//
// class _SeenBySelectState extends State<SeenBySelect> {
//   @override
//   Widget build(BuildContext context) {
//     return DropdownButton2(
//       buttonStyleData: ButtonStyleData(
//         elevation: 0,
//         height: 49 * screenHeight,
//         width: 290 * screenWidth,
//         decoration: BoxDecoration(
//             color: white,
//             borderRadius: BorderRadius.circular(7),
//             border: Border.all(color: appointmentTimeColor, width: 1)),
//         padding: EdgeInsets.symmetric(
//             horizontal: 15 * screenWidth, vertical: 12 * screenHeight),
//       ),
//       underline: Text(''),
//       dropdownStyleData: DropdownStyleData(
//         padding: EdgeInsets.symmetric(
//             horizontal: 10 * screenWidth, vertical: 10 * screenHeight),
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(10),
//         ),
//       ),
//       iconStyleData: IconStyleData(
//         icon: Icon(Icons.keyboard_arrow_down_rounded),
//         iconDisabledColor: black,
//         iconEnabledColor: primary,
//       ),
//       isExpanded: true,
//       hint: Center(
//         child: Text(
//           'Choose one',
//           style: TextStyle(
//               fontSize: 16, color: black, fontWeight: FontWeight.w200),
//         ),
//       ),
//       items: seenByList.map((String serviceCategoryList) {
//         return DropdownMenuItem(
//           child: Text(
//             serviceCategoryList,
//             overflow: TextOverflow.ellipsis,
//             softWrap: true,
//           ),
//           value: serviceCategoryList,
//         );
//       }).toList(),
//       onChanged: widget.isReadOnly
//           ? null
//           : (String? newValue) {
//               setState(() {
//                 seenByHintText = newValue!;
//               });
//             },
//       value: seenByHintText.toString(),
//     );
//   }
// }
