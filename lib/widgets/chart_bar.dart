import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final Color color;
  final double height;
  final int numberOfOrders;
  final String name;

  ChartBar({@required this.color, @required this.height, @required this.name, @required this.numberOfOrders});
  @override
  Widget build(BuildContext context) {
    return Tooltip(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(color: Colors.white, border: Border.all(width: 1,color: Theme.of(context).primaryColor), borderRadius: BorderRadius.circular(12)),
      message: 'Name: $name\n#Order: $numberOfOrders',
      textStyle: TextStyle(color: Theme.of(context).primaryColor),
      child: Container(width: 20, height: height, color: color),
    );
  }
}
