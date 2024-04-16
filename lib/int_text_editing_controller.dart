import 'package:flutter/cupertino.dart';

class IntTextEditingController extends TextEditingController {
  IntTextEditingController({String text = ''}) : super(text: text);

  // Override the text getter to return an integer value
  int get intValue {
    return int.tryParse(text) ?? 0; // Default to 0 if parsing fails
  }

  // Override the text setter to set integer value as string
  set intValue(int value) {
    text = value.toString();
  }
}
