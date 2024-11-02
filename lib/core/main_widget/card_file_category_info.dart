import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class FileCategoryCardInfo extends StatelessWidget {
  const FileCategoryCardInfo(
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SvgPicture.asset(
              "assets/svg/folder.svg",
              width: 50,
              height: 50,
            ),
            Text(text),
          ],
        ),
      ),
    );
  }
}
