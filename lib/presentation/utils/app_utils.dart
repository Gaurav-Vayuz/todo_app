import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AppUtils {
  static String formatDate(DateTime date) {
    String formattedDate = "";

    try {
      formattedDate = DateFormat('MMM d, y').format(date);
    } catch (e) {
      formattedDate = "";
    }
    return formattedDate;
  }

  static Widget textFiledDesign(TextEditingController mController, String label,
      {bool readOnly = false, bool autoFocus = false, dynamic validator}) {
    return InkWell(
      child: TextFormField(
        autofocus: autoFocus,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        controller: mController,
        style: const TextStyle(color: Colors.black),
        readOnly: readOnly,
        validator: validator,
        decoration: InputDecoration(
          filled: true,
          label: Text(label),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(width: 1.5, color: Colors.white)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide:
                  const BorderSide(width: 1.5, color: Colors.deepPurple)),
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(width: 1.5, color: Colors.red)),
          focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(width: 1.5, color: Colors.red)),
        ),
      ),
    );
  }

  static String capitalizeFirstLetter(String text) {
    if (text.isEmpty) {
      return text;
    }
    return text[0].toUpperCase() + text.substring(1);
  }
}
