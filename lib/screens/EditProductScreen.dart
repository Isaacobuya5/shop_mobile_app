import 'package:flutter/material.dart';

class EditProductScreen extends StatefulWidget {

  static const routeName = '/edit-products';
  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {

  final _priceFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();

  final _imageUrlController = TextEditingController();

@override
dispose() {
_priceFocusNode.dispose();
_descriptionFocusNode.dispose();
_imageUrlController.dispose();
super.dispose();
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit a Product'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Form(
          child: ListView(children: <Widget>[
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Title'
              ),
              textInputAction: TextInputAction.next,
              onFieldSubmitted: (_) {
                FocusScope.of(context).requestFocus(_priceFocusNode);
              },
            ),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Price'
              ),
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.number,
              focusNode: _priceFocusNode,
              onFieldSubmitted: (_) {
                FocusScope.of(context).requestFocus(_descriptionFocusNode);
              },
            ),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Description'
              ),
              keyboardType: TextInputType.multiline,
              maxLines: 3,
              focusNode: _descriptionFocusNode,
            ),
            Row(
              children: <Widget> [
                Container(
                  width: 100,
                  height: 100,
                  margin: const EdgeInsets.only(
                    top: 8.0,
                    right: 10.0
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 1,
                      color: Colors.grey
                    )),
                  child: Container(
                    child: FittedBox(
                      child: _imageUrlController.text.isEmpty ? Text('No image uploaded') : Image.network(_imageUrlController.text, fit: BoxFit.cover,)
                    ),
                  ),),
                  Expanded(
                      child: TextFormField(
                      decoration: InputDecoration(labelText: 'Image URL'),
                      keyboardType: TextInputType.url,
                      textInputAction: TextInputAction.done,
                      controller: _imageUrlController,
                    ),
                  )
              ]
            )
          ],),),
      ),
    );
  }
}