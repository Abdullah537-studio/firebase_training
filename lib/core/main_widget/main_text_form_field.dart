import 'package:flutter/material.dart';

class MainTextFormField extends StatelessWidget {
  const MainTextFormField(
      {super.key,
      required this.text,
      required this.controller,
      required this.validate});
  final String text;
  final TextEditingController controller;
  final String? Function(String?)? validate;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: TextFormField(
        validator: validate,
        controller: controller,
        cursorColor: Colors.orange,
        cursorErrorColor: Colors.red,
        decoration: InputDecoration(
          hintText: text,
          hintStyle: TextStyle(color: Colors.orangeAccent),
          iconColor: Colors.orange,
          border: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Color.fromARGB(255, 219, 215, 215),
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(12),
            ),
          ),
          errorBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red, width: 2),
            borderRadius: BorderRadius.all(
              Radius.circular(12),
            ),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.orange, width: 2),
            borderRadius: BorderRadius.all(
              Radius.circular(12),
            ),
          ),
          enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.orange, width: 2),
              borderRadius: BorderRadius.all(
                Radius.circular(12),
              )),
        ),
      ),
    );
  }
}
