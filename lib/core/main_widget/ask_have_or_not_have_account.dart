import 'package:flutter/material.dart';

class AskHaveOrNotHaveAccount extends StatelessWidget {
  const AskHaveOrNotHaveAccount(
      {super.key,
      required this.textRegisterOrLogin,
      required this.textHaveOrNotHaveAccount,
      required this.onPressend});
  final String textRegisterOrLogin;
  final String textHaveOrNotHaveAccount;

  final Function()? onPressend;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 12),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onPressend,
        child: Text.rich(
          TextSpan(
            children: [
              TextSpan(text: textHaveOrNotHaveAccount),
              TextSpan(
                text: textRegisterOrLogin,
                style: const TextStyle(
                  color: Colors.orange,
                  fontWeight: FontWeight.bold,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
