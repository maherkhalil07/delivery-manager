import 'package:delivery_manager/models/order.dart';
import 'package:delivery_manager/widgets/buttom_sheet_title.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddOrderSheet extends StatefulWidget {
  final List<String> deliveryMen;
  final Function addOrder;
  AddOrderSheet(this.deliveryMen, this.addOrder);

  @override
  _AddOrderSheetState createState() => _AddOrderSheetState();
}

class _AddOrderSheetState extends State<AddOrderSheet> {
  String selectedDeliverMan;
  DateTime selectedDate;
  TextEditingController priceController;
  @override
  void initState() {
    super.initState();
    selectedDeliverMan = widget.deliveryMen[0];
    selectedDate = DateTime.now();
    priceController = TextEditingController();
  }

  @override
  void dispose() {
    priceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).accentColor,
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(16),
              color: Theme.of(context).primaryColor,
              width: double.infinity,
              child: Text(
                'Let\'s add an order',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ButtomSheetTitle('who\'ll deliver?'),
                  Card(
                    color: Colors.blue[100],
                    elevation: 5,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton(
                          isExpanded: true,
                          value: selectedDeliverMan,
                          items: widget.deliveryMen.map((e) {
                            return DropdownMenuItem(
                              child: Text(e),
                              value: e,
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              selectedDeliverMan = value;
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                  ButtomSheetTitle('when\'ll be delivered?'),
                  Row(
                    children: [
                      RaisedButton(
                        child: Text(DateFormat('EEEE, dd/MM/yyyy')
                            .format(selectedDate)),
                        color: Colors.blue[100],
                        onPressed: () async {
                          DateTime pickedDate = await showDatePicker(
                            context: context,
                            initialDate: selectedDate,
                            firstDate:
                                DateTime.now().subtract(Duration(days: 7)),
                            lastDate: DateTime.now().add(Duration(days: 90)),
                          );
                          if (pickedDate != null) {
                            setState(() {
                              selectedDate = DateTime(
                                  pickedDate.year,
                                  pickedDate.month,
                                  pickedDate.day,
                                  selectedDate.hour,
                                  selectedDate.minute);
                            });
                          }
                        },
                      ),
                      Container(
                          margin: EdgeInsets.symmetric(horizontal: 10),
                          child: Text('at')),
                      RaisedButton(
                        child: Text(DateFormat('hh:mm a').format(selectedDate)),
                        color: Colors.blue[100],
                        onPressed: () async {
                          TimeOfDay pickedTime = await showTimePicker(
                            context: context,
                            initialTime: TimeOfDay.now(),
                          );
                          if (pickedTime != null) {
                            setState(() {
                              selectedDate = DateTime(
                                  selectedDate.year,
                                  selectedDate.month,
                                  selectedDate.day,
                                  pickedTime.hour,
                                  pickedTime.minute);
                            });
                          }
                        },
                      ),
                    ],
                  ),
                  ButtomSheetTitle('what\'s the price?'),
                  Card(
                    elevation: 5,
                    color: Colors.blue[100],
                    child: TextField(
                      controller: priceController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(horizontal: 8),
                        hintText: 'please enter the price',
                        border: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        focusedErrorBorder: InputBorder.none,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 8),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: RaisedButton(
                        child: Text(
                          'Add order',
                          style: TextStyle(color: Colors.white),
                        ),
                        color: Theme.of(context).primaryColor,
                        onPressed: () {
                          try {
                            double price = double.parse(priceController.text);
                            if (price < 0.0) {
                              throw 'invalid price';
                            }
                            String key =
                                DateFormat('yyyyMMdd').format(selectedDate);
                            Order order = Order(
                                deliveryMan: selectedDeliverMan,
                                orderDate: selectedDate,
                                price: price);
                            widget.addOrder(key, order);
                          } catch (error) {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text('Invalid order data'),
                                    content: Text('please enter valid price.'),
                                    actions: [
                                      FlatButton(
                                        child: Text('Ok'),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      )
                                    ],
                                  );
                                });
                          }
                        },
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
