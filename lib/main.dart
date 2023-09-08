import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_paystack/flutter_paystack.dart';
import 'package:pet_life_gh/constants.dart';
import 'package:pet_life_gh/screens/Splash/splash_screen.dart';

var publicKey = 'pk_test_0ecb116bc4efa8beffec26cf794f25b702701a9c';
PaystackPlugin plugin = PaystackPlugin();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await plugin.initialize(publicKey: publicKey);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
        theme: ThemeData(
            appBarTheme: AppBarTheme(iconTheme: IconThemeData(color: blue))));
  }
}
