import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/product.dart';
import '../providers/products.dart';

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
    // initialize product property values
    var _initialValues = {
      'title': '',
      'description': '',
      'price': '',
      'imageUrl': ''
    };

  var _isInit = true;
  var _isLoading = false;

@override
void initState() {
  _imageUrlFocusNode.addListener(_updateImageUrl);
  super.initState();
}

@override
void didChangeDependencies() {
  if (_isInit) {
    final productId = ModalRoute.of(context).settings.arguments as String;
    // check if id existing - we only want to edit an existing product
    if (productId != null) {
      print(productId);
      // find the product with that id
      _editedProduct = Provider.of<ProductsProvider>(context, listen: false).findById(productId);
      // initial values for the product property fields
      _initialValues = {
        'title': _editedProduct.title,
        'description': _editedProduct.description,
        'price': _editedProduct.price.toString(),
        'imageUrl': ''
        // 'imageUrl': _editedProduct.imageUrl
      };
      _imageUrlController.text = _editedProduct.imageUrl;
    }
    
  }
  _isInit = false;
  super.didChangeDependencies();
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
     if (
     (!_imageUrlController.text.startsWith("http") && !_imageUrlController.text.startsWith("https")) ||
      (!_imageUrlController.text.endsWith(".jpg") && !_imageUrlController.text.endsWith(".png") && 
      !_imageUrlController.text.endsWith(".jpeg"))) {
       return;
     }

  setState(() {});
}
}

Future<void> _saveForm() async{
  // the save method will collect all the values from each and every from text field
  // you can the save the values in a global map or any other place
  // we can run validator for each input with the help of formKey
  final isValid = _formKey.currentState.validate();
  // returns true if valid
  if (!isValid) {
    return;
  }
  _formKey.currentState.save();

  // when the form is submitted we want to show a loading spinner
  setState(() {
    _isLoading = true;
  });

  // if product exist then simply update
  if (_editedProduct.id != null) {
    // dispatch action to edit a product
    await Provider.of<ProductsProvider>(context, listen: false).editProduct(_editedProduct.id, _editedProduct);
    // setState(() {
    //   _isLoading = false;
    // });
    //  Navigator.of(context).pop();
  } else {
    try {
  // dispatch the addProduct action to save a new product
  await Provider.of<ProductsProvider>(context, listen: false).addNewProduct(_editedProduct);
    } catch(error) {
   await showDialog(context: context, builder: (context) {
      return AlertDialog(
        title: Text('An error occured'),
        content: Text('Something went wrong'),
        actions: <Widget> [
          FlatButton(
            child: Text('Okay'),
            onPressed: () => Navigator.of(context).pop(),)
        ]
      );
    });
  } //finally {
    // setState(() {
    //   _isLoading = false;
    // });
    //  Navigator.of(context).pop();
  //}
}
    setState(() {
      _isLoading = false;
    });
     Navigator.of(context).pop();

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
      body: _isLoading ? Center(
        child: CircularProgressIndicator(),
      ) : Padding(
        padding: const EdgeInsets.all(10.0),
        child: Form(
          // we can force the form to run validator for each input here
          // by setting autovalidate to true
          key: _formKey,
          child: ListView(children: <Widget>[
            TextFormField(
              initialValue: _initialValues['title'],
              decoration: InputDecoration(
                labelText: 'Title',
                // we can customize styles for error handling here such as fontStyle etc
              ),
              textInputAction: TextInputAction.next,
              // we add validation to an input with the help of validator
              validator: (value) {
                // value -> is the value entered into this field
                if (value.isEmpty) {
                  return "Field cannot be empty";
                }
                // returning null means input is valid
                return null;
              },
              onFieldSubmitted: (_) {
                FocusScope.of(context).requestFocus(_priceFocusNode);
              },
              onSaved: (value){
                _editedProduct = Product(
                  id: _editedProduct.id, 
                  title: value, 
                  description: _editedProduct.description, 
                  price: _editedProduct.price, 
                  imageUrl: _editedProduct.imageUrl,
                  isFavourite: _editedProduct.isFavourite
                  );
              },
            ),
            TextFormField(
              initialValue: _initialValues['price'],
              decoration: InputDecoration(
                labelText: 'Price'
              ),
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.number,
              focusNode: _priceFocusNode,
              validator: (value) {
                if (value.isEmpty) {
                  return "Please enter a price";
                }
                if (double.tryParse(value) == null){
                  return "Please enter a valid";
                }
                if (double.parse(value) <= 0) {
                  return "Please enter a value greater than zero";
                }

                return null;
              },
              onFieldSubmitted: (_) {
                FocusScope.of(context).requestFocus(_descriptionFocusNode);
              },
            onSaved: (value){
               _editedProduct = Product(
                  id: _editedProduct.id, 
                  title: _editedProduct.title, 
                  description: _editedProduct.description, 
                  price: double.parse(value), 
                  imageUrl: _editedProduct.imageUrl,
                  isFavourite: _editedProduct.isFavourite
                  );
                }
            ),
            TextFormField(
              initialValue: _initialValues['description'],
              decoration: InputDecoration(
                labelText: 'Description'
              ),
              keyboardType: TextInputType.multiline,
              maxLines: 3,
              focusNode: _descriptionFocusNode,
              validator: (value) {
                if (value.isEmpty) {
                  return "Please enter a description";
                }
                if (value.length < 10) {
                  return "Please enter a longer description";
                }

                return null;
              },
              onSaved: (value){
               _editedProduct = Product(
                  id: _editedProduct.id, 
                  title: _editedProduct.title, 
                  description: value, 
                  price: _editedProduct.price, 
                  imageUrl: _editedProduct.imageUrl,
                  isFavourite: _editedProduct.isFavourite
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
                validator: (value) {
                  if (value.isEmpty) {
                    return "Please enter an image URL";
                  }

                  if (!value.startsWith("http") && !value.startsWith("https")) {
                    return "Please enter a valid URL";
                  }

                  if (!value.endsWith(".jpg") && !value.endsWith(".png") && !value.endsWith(".jpeg")) {
                    return "Please enter a valid image URL";
                  }

                  return null;
                },
                onSaved: (value){
               _editedProduct = Product(
                  id: _editedProduct.id, 
                  title: _editedProduct.title, 
                  description: _editedProduct.description, 
                  price: _editedProduct.price, 
                  imageUrl: value,
                  isFavourite: _editedProduct.isFavourite
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