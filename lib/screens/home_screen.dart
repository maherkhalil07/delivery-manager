import 'dart:collection';
import 'dart:math';
import 'package:delivery_manager/models/order.dart';
import 'package:delivery_manager/widgets/add_order_sheet.dart';
import 'package:delivery_manager/widgets/background_container.dart';
import 'package:delivery_manager/widgets/chart.dart';
import 'package:delivery_manager/widgets/homescreen_title.dart';
import 'package:delivery_manager/widgets/order_item.dart';
import 'package:delivery_manager/widgets/sticky_header_head.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sticky_headers/sticky_headers.dart';

class HomeScreen extends StatefulWidget {
  final Function toggle;
  HomeScreen(this.toggle);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  SplayTreeMap<String, Map<String, dynamic>> orders =
      SplayTreeMap<String, Map<String, dynamic>>((String a, String b) {
    return -a.compareTo(b);
  });
  ScrollController scrollController;
  bool showUpButton = false;
  List<String> deliveryMen = ['Muhamed Aly', 'Toka Ehab', 'Ahmed Ali'];
  DateTime selectedDate;
  SplayTreeSet<Order> selectedOrders;
  bool isDark;
  int compareTwoOrders(Order a, Order b) {
    return -a.orderDate.compareTo(b.orderDate);
  }

  void removeOrder(String key, Order order) {
    setState(() {
      (orders[key]['list'] as SplayTreeSet<Order>).remove(order);
      if (orders[key]['list'].isEmpty) {
        orders.remove(key);
      }
    });
  }

  void addOrder(String key, Order order) {
    Navigator.of(context).pop();
    setState(() {
      if (orders.containsKey(key)) {
        orders[key]['list'].add(order);
      } else {
        orders[key] = Map<String, dynamic>();
        orders[key]['date'] =
            DateFormat('EEEE, dd/MM/yyyy').format(order.orderDate);
        orders[key]['list'] = SplayTreeSet<Order>(compareTwoOrders);
        orders[key]['list'].add(order);
      }
    });
  }

  void initState() {
    super.initState();
    isDark = false;
    scrollController = ScrollController();
    final ordersList = List.generate(12, (index) {
      return Order(
        deliveryMan: deliveryMen[Random().nextInt(3)],
        price: Random().nextDouble() * 500,
        orderDate: DateTime.now().subtract(
          Duration(
            days: Random().nextInt(12),
            hours: Random().nextInt(24),
            minutes: Random().nextInt(60),
          ),
        ),
      );
    });

    ordersList.forEach((element) {
      final key = DateFormat('yyyyMMdd').format(element.orderDate);
      if (!orders.containsKey(key)) {
        orders[key] = Map<String, dynamic>();
        orders[key]['date'] =
            DateFormat('EEEE, dd/MM/yyyy').format(element.orderDate);
        orders[key]['list'] = SplayTreeSet<Order>(compareTwoOrders);
      }
      orders[key]['list'].add(element);
    });

    selectedDate = DateTime.now();
    String key = DateFormat('yyyyMMdd').format(selectedDate);
    if (orders.containsKey(key)) {
      selectedOrders = orders[key]['list'];
    } else {
      selectedOrders = null;
    }
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  void changeDate(DateTime date) {
    setState(() {
      selectedDate = date;
      String key = DateFormat('yyyyMMdd').format(selectedDate);
      if (orders.containsKey(key)) {
        selectedOrders = orders[key]['list'];
      } else {
        selectedOrders = null;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).accentColor,
      body: Stack(
        children: [
          BackGroundContainer(),
          SafeArea(
            child: Container(
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  HomeScreenTitle(),
                  Chart(selectedDate, changeDate, selectedOrders),
                  Expanded(
                    child: NotificationListener<ScrollUpdateNotification>(
                      onNotification: (notification) {
                        if (notification.metrics.pixels > 40 &&
                            showUpButton == false) {
                          setState(() {
                            showUpButton = true;
                          });
                        } else if (notification.metrics.pixels <= 40 &&
                            showUpButton == true) {
                          setState(() {
                            showUpButton = false;
                          });
                        }
                        return true;
                      },
                      child: ListView.builder(
                        controller: scrollController,
                        padding: EdgeInsets.only(
                            bottom: kFloatingActionButtonMargin + 56),
                        physics: BouncingScrollPhysics(),
                        itemCount: orders.length,
                        itemBuilder: (context, index) {
                          List<String> keys = orders.keys.toList();
                          String key = keys[index];
                          String date = orders[key]['date'];
                          SplayTreeSet<Order> list = orders[key]['list'];
                          return StickyHeader(
                              header: StickyHeaderHead(date),
                              content: Column(
                                children: list.map((element) {
                                  return OrderItem(element, removeOrder);
                                }).toList(),
                              ));
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: Container(
        margin: EdgeInsets.only(left: 2 * kFloatingActionButtonMargin),
        child: Row(
          mainAxisAlignment: (showUpButton)
              ? MainAxisAlignment.spaceBetween
              : MainAxisAlignment.end,
          children: [
            if (showUpButton)
              FloatingActionButton(
                mini: true,
                backgroundColor: Colors.grey,
                child: Icon(Icons.keyboard_arrow_up),
                onPressed: () {
                  scrollController.jumpTo(0.0);
                },
              ),
            Spacer(),
            Switch(
              value: isDark,
              onChanged: (value) {
                setState(() {
                  isDark = value;
                });
                widget.toggle();
              },
            ),
            FloatingActionButton(
              backgroundColor: Theme.of(context).primaryColor,
              child: Icon(Icons.add, color: Colors.white,),
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  builder: (context) {
                    return AddOrderSheet(deliveryMen, addOrder);
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
