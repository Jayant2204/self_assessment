import 'package:get/get.dart';
import 'package:self_assessment/assessment/Data/user.dart';

class MyRegisterUserController extends GetxController {
  final name = "".obs;
  setName(value) => this.name.value = value;
  get getName => this.name.value;

  final dob = DateTime(2018).obs;
  setDob(value) => this.dob.value = value;
  get getDob => this.dob.value;

  final mobileNumber = 0.obs;
  setMobileNumber(value) => this.mobileNumber.value = value;
  get getMobileNumber => this.mobileNumber.value;

  final user = User().obs;
  setUser(value) => this.user.value = value;
  get getUser => this.user.value;
}
