import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Widget textFieldWidget({
  TextInputType keyboardType = TextInputType.text,
  required TextInputAction textInputAction,
  required String hintText,
  required String labelText,
  required TextEditingController controller,
  required Function? onValidator,
}) {
  return TextFormField(
    textCapitalization: TextCapitalization.words,
    controller: controller,
    validator: onValidator as String? Function(String?)?,
    autovalidateMode: AutovalidateMode.onUserInteraction,
    keyboardType: keyboardType,
    textInputAction: textInputAction,
    style: TextStyle(
      fontSize: 15,
      fontWeight: FontWeight.w500,
    ),
    decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        label: Text(labelText),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(
            color: Color(0xffEAEAEA),
          ),
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
        fillColor: Colors.white,
        filled: true,
        hintText: hintText,
        hintStyle: const TextStyle(
            color: Color(0xffBCBCBC),
            fontSize: 15,
            fontWeight: FontWeight.w500,
            fontFamily: "Inter-Medium")),
  );
}
