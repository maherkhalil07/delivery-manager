import 'package:flutter/material.dart';

class StickyHeaderHead extends StatelessWidget {
  final String date;
  StickyHeaderHead(this.date);
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(12), topRight: Radius.circular(12))),
      elevation: 5,
      margin: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.04),
      color: Theme.of(context).primaryColor,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(16  ),
        child: Text(
          date,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
