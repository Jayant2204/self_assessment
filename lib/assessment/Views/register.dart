import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:self_assessment/assessment/controller/userRegisterController.dart';
import 'package:self_assessment/assessment/utils/showdatePicker.dart';

class RegisterPage extends StatelessWidget {
  final MyRegisterUserController controller = MyRegisterUserController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Register"),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Text("Register"),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: Container(
        child: Column(
          children: [
            // Name Field
            TextField(
              onChanged: controller.setName,
              decoration: InputDecoration(hintText: "Name", labelText: "Name"),
            ),
            InkWell(
              onTap: () async {
                var date = await getDatePicker(context);
                if (date != null) {
                  controller.setDob(date);
                }
              },
              child: Obx(
                () => Container(
                  child: controller.dob.value == null
                      ? Text("Date of Birth")
                      : Text(DateFormat.yMMMMd('en_US')
                          .format(controller.dob.value)),
                ),
              ),
            ),
            // Mobile Number Field
            TextField(
              onChanged: controller.setName,
              decoration: InputDecoration(hintText: "Name", labelText: "Name"),
            ),
          ],
        ),
      ),
    );
  }
}
