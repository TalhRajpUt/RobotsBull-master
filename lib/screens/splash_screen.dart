import 'dart:io';

import 'package:app/data/image_paths.dart';
import 'package:app/helpers/snack_helper.dart';
import 'package:app/screens/intro_slider.dart';
import 'package:app/screens/webview_screen.dart';
import 'package:connectivity/connectivity.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    gotoNextScreen();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Image.asset(
        splashBG,
        fit: BoxFit.cover,
        height: double.infinity,
        width: double.infinity,
      ),
    );
  }

  void gotoNextScreen() async {
    if (await connectionAvailable()) {
      //
      await Future.delayed(const Duration(seconds: 2));
      if (Platform.isIOS) {
        await FirebaseMessaging.instance.requestPermission();
      }
      await FirebaseMessaging.instance.getToken();
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => const IntroSlider()));
    } else {
      SnackBarHelper.showSnackBarWithAction(context, () {
        gotoNextScreen();
      }, message: 'Connection error', dismissDuration: const Duration(days: 1));
    }
  }

  Future<bool> connectionAvailable() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      // I am connected to a network.
      return true;
    } else {
      return false;
    }
  }
}
