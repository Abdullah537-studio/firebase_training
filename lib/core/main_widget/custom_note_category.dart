import 'package:flutter/material.dart';

class CustomNoteCategoryWidget extends StatelessWidget {
  const CustomNoteCategoryWidget(
      {super.key, required this.text, required this.longPress, this.onPreesed});
  final String text;
  final Function()? longPress;
  final Function()? onPreesed;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPreesed,
      onLongPress: longPress,
      child: Card(
        color: Colors.lightGreen,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          child: SingleChildScrollView(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 18,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
