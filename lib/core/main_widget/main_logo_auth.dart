import 'package:flutter/material.dart';

class CustomLogoAuth extends StatelessWidget {
  const CustomLogoAuth({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 60,
      alignment: Alignment.center,
      margin: const EdgeInsets.only(top: 20),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.white),
          borderRadius: BorderRadius.circular(22),
          color: const Color(0XFFF7F7F7)),
      child: Center(
        child: Image.asset(
          "assets/images/logo.jpeg",
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
