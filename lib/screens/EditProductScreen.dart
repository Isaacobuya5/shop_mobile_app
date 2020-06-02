import 'package:flutter/material.dart';
import '../providers/product.dart';

class EditProductScreen extends StatefulWidget {

  static const routeName = '/edit-products';
  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {

  final _priceFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();

  final _imageUrlController = TextEditingController();
  // enables automatic submission of imageUrl when focus is lost
  final _imageUrlFocusNode = FocusNode();
  // global key enables us to interact with a wiget from its outside
  // in this case we need to interact with Form widget from within saveForm method
  final _formKey = GlobalKey<FormState>();
  // a new product
  var _editedProduct = Product(
    id: null, 
    title: '', 
    description: '', 
    price: 0, 
    imageUrl: '');

@override
void initState() {
  _imageUrlFocusNode.addListener(_updateImageUrl);
  super.initState();
}
@override
void dispose() {
_imageUrlFocusNode.removeListener(_updateImageUrl);
_priceFocusNode.dispose();
_descriptionFocusNode.dispose();
_imageUrlController.dispose();
_imageUrlFocusNode.dispose();
super.dispose();
}

void _updateImageUrl() {
  if (!_imageUrlFocusNode.hasFocus) {
  setState(() {});
}
}

void _saveForm() {
  // the save method will collect all the values from each and every from text field
  // you can the save the values in a global map or any other place
  _formKey.currentState.save();
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit a Product'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save), 
            onPressed: _saveForm,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Form(
          key: _formKey,
          child: ListView(children: <Widget>[
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Title'
              ),
              textInputAction: TextInputAction.next,
              onFieldSubmitted: (_) {
                FocusScope.of(context).requestFocus(_priceFocusNode);
              },
              onSaved: (value){
                _editedProduct = Product(
                  id: null, 
                  title: value, 
                  description: _editedProduct.description, 
                  price: _editedProduct.price, 
                  imageUrl: _editedProduct.imageUrl
                  );
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
            onSaved: (value){
               _editedProduct = Product(
                  id: null, 
                  title: _editedProduct.title, 
                  description: _editedProduct.description, 
                  price: double.parse(value), 
                  imageUrl: _editedProduct.imageUrl
                  );
                }
            ),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Description'
              ),
              keyboardType: TextInputType.multiline,
              maxLines: 3,
              focusNode: _descriptionFocusNode,
              onSaved: (value){
               _editedProduct = Product(
                  id: null, 
                  title: _editedProduct.title, 
                  description: value, 
                  price: _editedProduct.price, 
                  imageUrl: _editedProduct.imageUrl
                  );
              }
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
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
                      child: _imageUrlController.text.isEmpty ? Text('No image uploaded') : FittedBox(
                        child: Image.network(_imageUrlController.text, 
                        fit: BoxFit.cover,)),
                  ),),
                  Expanded(
                      child: TextFormField(
                      decoration: InputDecoration(labelText: 'Image URL'),
                      keyboardType: TextInputType.url,
                      textInputAction: TextInputAction.done,
                      controller: _imageUrlController,
                      focusNode: _imageUrlFocusNode,
                      onFieldSubmitted: (_) {
                        _saveForm();
                      },
                onSaved: (value){
               _editedProduct = Product(
                  id: null, 
                  title: _editedProduct.title, 
                  description: _editedProduct.description, 
                  price: _editedProduct.price, 
                  imageUrl: value
                  );
                }
                    ),
                  )
              ]
            )
          ],),),
      ),
    );
  }
}