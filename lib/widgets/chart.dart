import 'package:flutter/material.dart';

class Chart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 5,
      margin: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.05)
          .add(EdgeInsets.only(
              bottom: MediaQuery.of(context).size.height * 0.04)),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.3,
        width: double.infinity,
        child: Center(
          child: Text(
            'No Orders Yet',
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
