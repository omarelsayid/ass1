import 'package:flutter/material.dart';

class CustomTextFromFiled extends StatelessWidget {
  const CustomTextFromFiled({
    super.key,
    required this.label,
    required this.controller,
    required this.multiLine,
    required this.autovalidateMode,
  });
  final String label;
  final TextEditingController controller;
  final bool multiLine;
  final AutovalidateMode autovalidateMode;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autovalidateMode: autovalidateMode,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'this field is required';
        }
        return null;
      },
      controller: controller,
      decoration: InputDecoration(
        floatingLabelBehavior: FloatingLabelBehavior.always,
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black),
        ),
        border: OutlineInputBorder(),
        labelText: label,
      ),
      keyboardType: multiLine ? TextInputType.multiline : TextInputType.text,
      minLines: multiLine ? 3 : 1,
      maxLines: multiLine ? 5 : 1,
    );
  }
}
