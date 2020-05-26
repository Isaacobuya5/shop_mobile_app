import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/Orders.dart';
import '../widgets/order_item.dart';

class OrdersScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final orderData = Provider.of<Orders>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Orders')
      ),
      body: ListView.builder(
        itemCount: orderData.orders.length,
        itemBuilder: (context, index) => OrderItem(orderData.orders[index])),
    );
  }
}