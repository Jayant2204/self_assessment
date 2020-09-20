import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/utils.dart';
import 'package:get_storage/get_storage.dart';
import 'package:self_assessment/assessment/Data/user.dart';
import 'package:self_assessment/assessment/Views/testPage.dart';
import 'package:self_assessment/global/constants.dart';

class MyRegisterUserController extends GetxController {
  final name = "".obs;
  void setName(String value) {
    this.name.value = value;
    update();
  }

  get getName => this.name.value;

  final dob = DateTime.now().obs;
  setDob(value) => this.dob.value = value;
  get getDob => this.dob.value;

  final mobileNumber = "0".obs;
  setMobileNumber(String value) {
    this.mobileNumber.value = value;
    update();
  }

  get getMobileNumber => this.mobileNumber.value;

  validateForm() async {
    if (name.value.isNullOrBlank) {
      Get.snackbar("Name is required", "Name cannot be blank",
          margin: EdgeInsets.all(10),
          backgroundColor: Colors.red,
          snackPosition: SnackPosition.BOTTOM);
    } else if (dob.value.year == DateTime.now().year) {
      Get.snackbar("Date of Birth is required", "Select your date of birth",
          margin: EdgeInsets.all(10),
          backgroundColor: Colors.red,
          snackPosition: SnackPosition.BOTTOM);
    } else if (mobileNumber.value.isNullOrBlank) {
      Get.snackbar("Mobile Number is required", "Mobile number cannot be blank",
          margin: EdgeInsets.all(10),
          backgroundColor: Colors.red,
          snackPosition: SnackPosition.BOTTOM);
    } else if (mobileNumber.value.length != 10) {
      Get.snackbar(
          "Mobile Number is invalid", "10 digits Mobile number required",
          margin: EdgeInsets.all(10),
          backgroundColor: Colors.red,
          snackPosition: SnackPosition.BOTTOM);
    } else {
      GetStorage box = GetStorage();
      await box.write(
          Constants.userPrefKey,
          User(
            name: name.value,
            mobileNumber: mobileNumber.value,
            dob: dob.value,
          ).toRawJson());
      Get.off(TestPage());
    }
  }
}
