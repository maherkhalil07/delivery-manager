import 'package:delivery_manager/models/order.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class OrderItem extends StatelessWidget {
  final Order order;
  final Function remove;

  OrderItem(this.order, this.remove);
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.04)
          .add(EdgeInsets.only(bottom: 8)),
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: ListTile(
          leading: CircleAvatar(
            radius: 30,
            backgroundColor: Theme.of(context).primaryColor,
            child: FittedBox(
              child: Padding(
                padding: EdgeInsets.all(5.0),
                child: Text(
                  '${order.price.toStringAsFixed(2)}\$',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
          title: Text(order.deliveryMan),
          subtitle: Text(DateFormat('hh:mm a').format(order.orderDate)),
          trailing: IconButton(
            icon: Icon(
              Icons.delete,
              color: Colors.red,
            ),
            onPressed: () {
              remove(DateFormat('yyyyMMdd').format(order.orderDate), order);
            },
          ),
        ),
      ),
    );
  }
}
