import 'package:flutter/material.dart';

class ButtonGoogleToAuth extends StatelessWidget {
  const ButtonGoogleToAuth(
      {super.key, required this.onPressed, required this.text});
  final Function()? onPressed;
  final String text;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.yellow,
      borderRadius: BorderRadius.circular(12),
      onTap: onPressed,
      child: Container(
          margin: const EdgeInsets.symmetric(vertical: 12),
          padding: const EdgeInsets.symmetric(horizontal: 12),
          width: double.infinity,
          height: 50,
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.orange),
              borderRadius: BorderRadius.circular(12)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                text,
                style: const TextStyle(color: Colors.black, fontSize: 19),
              ),
              SizedBox(
                width: 25,
                height: 25,
                child: Image.asset(
                  "assets/images/google_logo.jpeg",
                ),
              ),
            ],
          )),
    );
  }
}
