import 'package:flutter/material.dart';

const borderColor = Color(0xFF504A4A);
const blue = Color(0xFF0A1D3A);
const green = Color(0xFFC0E862);
const white = Color(0xFFffffff);
const grey = Color(0xFFd9d9d9);
const black = Color(0xFF000000);
Color lightBlue = Color(0xffB8D4FE);
Color deepBlue = Color(0xff1440B1);
Color sectionColor = Color(0xffF5F7F9);
Color chatBlue = Color(0xff0076F7);
Color chatRed = Color(0xffFF1AA3);
Color chatGrey = Color(0xffF2F4F5);
Color textGreyColor = Color(0xff9BA1A9);
Color chatTimeColor = Color(0xffA7A4A4);

List tabNames = [
  'Pet Products',
  'Pet Clothing',
  'Pet Food',
  'Pet Accessories',
  'Pets',
];

List<String> genderList = ['Male', 'Female'];
String genderValue = 'Male';

List<String> experienceList = [
  'Beginner (0-2)Years',
  'Amateur (3-4)Years',
  'Professional (4-7)Years',
  'Expert (9+ Years)',
];
String experienceValue = 'Beginner (0-2)Years';

double screenWidth = 1;
double screenHeight = 1;

List<String> bankList = [
  'N/A',
  'Zenith Bank',
  'Ghana Commercial Bank',
];
List<String> momoListOptions = [
  'MTN Mobile Money',
  'Vodafone Cash',
  'Airtel/Tigo Cash',
];
List<String> creditCardList = [
  'N/A',
  'Mastercard',
  'Visa Card',
  'American Express',
];

List<String> regionList = [
  'Eastern Region',
  'Western Region',
  'Volta Region',
  'Greater-Accra Region',
  'Ashanti Region',
];
String regionValue = 'Eastern Region';

List<String> categoryList = [
  'Pet Food',
  'Pet Clothing',
  'Pet Accessories',
  'Pets',
];
String categoryValue = 'Pet Food';

List featuredProdNames = [];
List featuredProductGender = [];
List featuredProductAge = [];
List featuredProductLocation = [];
List featuredProductPrice = [];

List featuredProdPics = [];

List newArrivalNames = [];

List newArrivalPics = [];
String loggedInUserID = '';

List NewArrivalPrice = [];
List NewArrivalAge = [];
List NewArrivalGender = [];
List NewArrivalLocation = [];

List categoryNames = [
  'Dogs',
  'Cats',
  'Pet Products',
  'Find Vet',
];

List categoryPics = [
  'asset/images/boston.jpeg',
  'asset/images/bullmastiff.jpeg',
  'asset/images/cane.jpeg',
  'asset/images/chihuahua.jpeg',
];

List vetImageLocation = [
  'asset/images/vet_pic.png',
  'asset/images/pic_1.jpg',
  'asset/images/pic_2.jpg',
  'asset/images/pic_3.jpg',
];
List vetStars = [5, 1, 4, 2];
List vetExp = [4, 8, 1, 5];

int selectedFeaturedProdIndex = 0;
int selectedNewArrivalIndex = 0;
