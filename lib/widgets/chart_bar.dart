import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final Color color;
  final double height;
  ChartBar(this.color, this.height);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 20,
      height: height,
      color: color
    );
  }
}
