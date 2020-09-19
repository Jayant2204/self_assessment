import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:self_assessment/assessment/Views/register.dart';
import 'package:self_assessment/global/constants.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    navigateToRegister();
    super.initState();
  }

  // Navigate to Register page after Splash Screen delay.
  navigateToRegister() async {
    Future.delayed(Constants.splashScreenDuration)
        .then((value) => Get.to(RegisterPage()));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
