import 'package:flutter/foundation.dart';

class Order {
  static int _counter = 0;
  int id;
  String deliveryMan;
  DateTime orderDate;
  double price;

  Order(
      {this.id,
      @required this.deliveryMan,
      @required this.orderDate,
      @required this.price}) {
    id = ++_counter;
  }
}
