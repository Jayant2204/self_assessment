import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:self_assessment/assessment/controller/userRegisterController.dart';
import 'package:self_assessment/assessment/utils/showdatePicker.dart';

class RegisterPage extends StatelessWidget {
  final MyRegisterUserController controller = MyRegisterUserController();

  final FocusNode focusNodeName = FocusNode();
  final FocusNode focusNodeDob = FocusNode();
  final FocusNode focusNodeMobile = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Register"),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          controller.validateForm();
        },
        label: Text("Register"),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            // Name Field
            TextField(
              onChanged: controller.setName,
              focusNode: focusNodeName,
              autofocus: true,
              keyboardType: TextInputType.name,
              textInputAction: TextInputAction.next,
              onEditingComplete: () =>
                  FocusScope.of(context).requestFocus(focusNodeDob),
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'^[a-zA-Z]+$'))
              ],
              decoration: InputDecoration(
                hintText: "Name",
                labelText: "Name",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            Obx(() => InkWell(
                  focusNode: focusNodeDob,
                  onTap: () async {
                    var date = await getDatePicker(
                        context,
                        controller.dob.value.year == DateTime.now().year
                            ? null
                            : controller.dob.value);
                    if (date != null) {
                      controller.setDob(date);
                    }
                    FocusScope.of(context).requestFocus(focusNodeMobile);
                  },
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      border: Border.all(),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: controller.dob.value.year == DateTime.now().year
                        ? Text("Date of Birth")
                        : Text(DateFormat.yMMMMd('en_US')
                            .format(controller.dob.value)),
                  ),
                )),
            const SizedBox(height: 20),
            // Mobile Number Field
            TextField(
              focusNode: focusNodeMobile,
              onChanged: controller.setMobileNumber,
              onEditingComplete: () => FocusScope.of(context).unfocus(),
              autofocus: false,
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.done,
              inputFormatters: [
                LengthLimitingTextInputFormatter(10),
                FilteringTextInputFormatter.digitsOnly
              ],
              decoration: InputDecoration(
                hintText: "Mobile",
                labelText: "Mobile",
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
