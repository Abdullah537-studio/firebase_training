import 'package:flutter/material.dart';

class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({super.key, required this.color});
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 15,
        height: 15,
        child: CircularProgressIndicator(
          color: color,
        ),
      ),
    );
  }
}
