import 'package:delivery_manager/widgets/chart_bar.dart';
import 'package:delivery_manager/widgets/hero_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  double calculateHeight(int numberOfOrders, BoxConstraints constraints) {
    return numberOfOrders * constraints.maxHeight / 20;
  }

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
          padding: EdgeInsets.all(8),
          child: Column(
            children: [
              Expanded(
                flex: 2,
                child: ListView.builder(
                  reverse: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: 7,
                  itemBuilder: (context, index) {
                    DateTime date =
                        DateTime.now().subtract(Duration(days: index));
                    String text = DateFormat('dd/MM').format(date);
                    return Container(
                      margin: EdgeInsets.only(
                          left: index == 6 ? 0 : 2, right: index == 0 ? 0 : 2),
                      child: FlatButton(
                        shape: StadiumBorder(),
                        color: Colors.amber,
                        child: Text(text),
                        onPressed: () {},
                      ),
                    );
                  },
                ),
              ),
              Expanded(
                  flex: 8,
                  child: Column(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Row(
                          children: [
                            Text('#Orders'),
                            Expanded(
                              child: Container(),
                            ),
                            Expanded(
                              child: ListView(
                                scrollDirection: Axis.horizontal,
                                children: [
                                  HeroItem(Colors.blue, 'Muhammed Aly'),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  HeroItem(Colors.yellow, 'Toka Ehab'),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  HeroItem(Colors.purple, 'Ahmed Aly'),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 8,
                        child: LayoutBuilder(
                          builder: (context, constraints) {
                            return Row(
                              children: [
                                Container(
                                  width: constraints.maxWidth * 0.1,
                                  height: constraints.maxHeight,
                                  decoration: BoxDecoration(
                                      border: Border(
                                          right: BorderSide(
                                              width: 1, color: Colors.black))),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('20'),
                                      Text('10'),
                                      Text('0'),
                                    ],
                                  ),
                                ),
                                Container(
                                  width: constraints.maxWidth * 0.9,
                                  height: constraints.maxHeight,
                                  decoration: BoxDecoration(
                                      border: Border(
                                          bottom: BorderSide(
                                              width: 1, color: Colors.black))),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      ChartBar(Colors.blue, calculateHeight(8, constraints)),
                                      ChartBar(Colors.yellow, calculateHeight(12, constraints)),
                                      ChartBar(Colors.purple, calculateHeight(9, constraints)),                                  
                                    ],
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      )
                    ],
                  ))
            ],
          )),
    );
  }
}
