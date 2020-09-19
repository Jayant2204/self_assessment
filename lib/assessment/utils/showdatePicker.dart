import 'package:flutter/material.dart';

getDatePicker(BuildContext context) async {
  DateTime now = DateTime.now();
  var date = await showDatePicker(
    context: context,
    initialDate: DateTime(now.year - 2, now.month, now.day),
    firstDate: DateTime(now.year - 100, now.month, now.day),
    lastDate: DateTime(now.year - 2, now.month, now.day),
  );
  return date;
}
