import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:self_assessment/assessment/Data/user.dart';
import 'package:self_assessment/assessment/Views/assessimet.dart';
import 'package:self_assessment/assessment/Views/register.dart';
import 'package:self_assessment/global/constants.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  GetStorage box = GetStorage();

  @override
  void initState() {
    navigateToRegister();
    super.initState();
  }

  // Navigate to Register page after Splash Screen delay.
  navigateToRegister() async {
    Future.delayed(Constants.splashScreenDuration).then((value) {
      var userString = box.read(Constants.userPrefKey);
      if (userString != null) {
        Get.to(AssessmentPage());
      } else {
        Get.to(RegisterPage());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
