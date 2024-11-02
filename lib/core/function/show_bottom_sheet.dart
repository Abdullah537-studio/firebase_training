import 'package:flutter/material.dart';

void showBottomSheetFunction(
    {required BuildContext context, required String text}) {
  showModalBottomSheet(
    context: context,
    builder: (BuildContext context) {
      return Container(
        height: 150,
        decoration: const BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
        alignment: Alignment.center,
        child: Text(
          text,
          style: const TextStyle(fontSize: 18, color: Colors.white),
        ),
      );
    },
  );
}
         // AwesomeDialog(
                          //   context: context,
                          //   dialogType: DialogType.error,
                          //   animType: AnimType.rightSlide,
                          //   title: 'wrong password',
                          //   desc: 'Wrong password provided for that user.',
                          //   btnCancelOnPress: () {},
                          //   btnOkOnPress: () {},
                          // ).show();