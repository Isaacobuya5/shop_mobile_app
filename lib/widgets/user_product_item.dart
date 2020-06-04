import 'package:flutter/material.dart';
import '../screens/EditProductScreen.dart';

class UserProductItem extends StatelessWidget {
  final id;
  final title;
  final imageUrl;

  UserProductItem(this.id, this.title, this.imageUrl);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      leading: CircleAvatar(
        // NOTE -> backgroundImage does not support Image.network since that builds an entire new widget
        // instead it takes a NetWorkImage or AssetImage that simply fetches an image
        // you cannot set a fit property for such an image
        backgroundImage: NetworkImage(imageUrl),
      ),
      trailing: Container(
        width: 100,
        child: Row(
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.edit),
              color: Theme.of(context).primaryColor, 
              onPressed: () {
                Navigator.of(context).pushNamed(EditProductScreen.routeName, arguments: id);
              }),
            IconButton(
              icon: Icon(Icons.delete),
              color: Theme.of(context).errorColor, 
              onPressed: () {

              })
          ],
        ),
      ),
    );
  }
}