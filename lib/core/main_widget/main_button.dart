import 'package:fire_base_mastring/core/main_widget/loading_indicator.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton(
      {super.key,
      required this.text,
      required this.onPressed,
      required this.isLoading});
  final String text;
  final bool isLoading;
  final Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: InkWell(
        splashColor: Colors.deepOrange,
        borderRadius: BorderRadius.circular(12),
        onTap: onPressed,
        child: Container(
            width: double.infinity,
            height: 50,
            decoration: BoxDecoration(
                color: Colors.orange,
                border: Border.all(color: Colors.transparent),
                borderRadius: BorderRadius.circular(12)),
            child: Center(
              child: isLoading == true
                  ? const LoadingIndicator(
                      color: Colors.white,
                    )
                  : Text(
                      text,
                      style: const TextStyle(color: Colors.white),
                    ),
            )),
      ),
    );
  }
}
