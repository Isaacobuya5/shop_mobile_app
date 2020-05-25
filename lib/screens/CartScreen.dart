import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/cart_item.dart';

import '../providers/cart.dart';

class CartScreen extends StatelessWidget {

  static const routeName = '/cart';

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    return Scaffold(
      appBar: AppBar(title: Text("Your cart items"),),
      body: Column(
        children: <Widget>[
          Card(
            margin: EdgeInsets.all(10.0),
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget> [
                  Text("Total",
                  style: TextStyle(fontSize: 20)),
                  Spacer(),
                  Chip(label: Text('\$${cart.totalAmount}',
                  style: TextStyle(
                    color: Theme.of(context).primaryTextTheme.title.color
                  ),),
                  backgroundColor: Theme.of(context).primaryColor,),
                  FlatButton(onPressed: (){}, 
                  child: Text("ORDER NOW"),
                  textColor: Theme.of(context).primaryColor,)
                ]
              ),),
          ),
          SizedBox(height: 10.0),
          Expanded(
            child: ListView.builder(
              itemCount: cart.itemCount,
              itemBuilder: (context, index) => CartItem(
                cart.items.values.toList()[index].id,
                cart.items.keys.toList()[index],
                cart.items.values.toList()[index].price,
                cart.items.values.toList()[index].quantity,
                cart.items.values.toList()[index].name
              ) ) 
          )
        ],
      ),
    );
  }
}