import 'package:flutter/material.dart';

class ButtomSheetTitle extends StatelessWidget {
  final String title;
  ButtomSheetTitle(this.title);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 16),
      child: Text(
        title,
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
  }
}
