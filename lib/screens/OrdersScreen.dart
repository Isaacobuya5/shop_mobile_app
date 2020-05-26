import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/Orders.dart';
import '../widgets/order_item.dart';
import '../widgets/AppDrawer.dart';

class OrdersScreen extends StatelessWidget {

  static const routeName = "/orders";

  @override
  Widget build(BuildContext context) {
    final orderData = Provider.of<Orders>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Orders')
      ),
      drawer: AppDrawer(),
      body: ListView.builder(
        itemCount: orderData.orders.length,
        itemBuilder: (context, index) => OrderItem(orderData.orders[index])),
    );
  }
}