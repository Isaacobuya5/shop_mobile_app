import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart.dart';

class CartItem extends StatelessWidget {

  final String id;
  final productId;
  final double price;
  final int quantity;
  final String title;

  CartItem(this.id, this.productId, this.price, this.quantity, this.title);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
        key: ValueKey(id),
        direction: DismissDirection.endToStart,
        onDismissed: (direction) {
          Provider.of<Cart>(context, listen: false).removeItem(productId);
        },
        // show dialog to confirm or reject dismiss action
        // confirm dialog returns a future boolean value
        // if future returns to true, then then the item will be dismissible otherwise vwon't be dismmissed
        confirmDismiss: (direction) {
          return showDialog(context: context,
          // builder returns context for the widget that will be built
          builder: (context) => AlertDialog(
            title: Text("Are you sure?"),
            content: Text("Do you want to remove the item from the cart?"),
            actions: <Widget>[
              FlatButton(
                onPressed: () {
                  Navigator.of(context).pop(false);
                }, 
                child: Text("No")),
              FlatButton(
                onPressed: () {
                  Navigator.of(context).pop(true);
                }, 
                child: Text("Yes"))
            ],
          ))
        },
        background: Container(
          color: Theme.of(context).errorColor,
          child: Icon(
            Icons.delete,
            color: Colors.white,
            size: 40.0,
          ),
          alignment: Alignment.centerRight,
          padding: EdgeInsets.only(right: 20.0),
          margin: EdgeInsets.symmetric(
          horizontal: 15.0,
          vertical: 4.0
        ),
        ),
        child: Card(
        margin: EdgeInsets.symmetric(
          horizontal: 15.0,
          vertical: 4.0
        ),
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: ListTile(
            leading: CircleAvatar(
              child: Padding(
                  padding: EdgeInsets.all(4.0),
                  child: FittedBox(
                  child: Text('\$$price')),
              ),
            ),
            title: Text(title),
            subtitle: Text('Total: \$${price * quantity}'),
            trailing: Text('$quantity X'),
          ),),
      ),
    );
  }
}