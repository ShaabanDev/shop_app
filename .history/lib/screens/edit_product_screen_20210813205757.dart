import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/product.dart';
import 'package:shop_app/providers/products.dart';

class EditProductScreen extends StatefulWidget {
  static const routeName = "/edit-product";

  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  var _formKey = GlobalKey<FormState>();
  var _priceFocus = FocusNode();
  var _desciptionFocus = FocusNode();
  var _imageUrlFocus = FocusNode();
  var _imageController = TextEditingController();
  var _editedProduct = Product(
    id: '',
    title: '',
    price: 0,
    description: '',
    imageUrl: '',
  );
  var _initValues = {
    'title': '',
    'description': '',
    'price': '',
    'imageUrl': '',
  };
  @override
  void dispose() {
    _imageUrlFocus.removeListener((() => _updateImageUrl()));
    _imageController.dispose();
    _imageUrlFocus.dispose();
    _desciptionFocus.dispose();
    _priceFocus.dispose();
    super.dispose();
  }

  var _init = true;

  @override
  void didChangeDependencies() {
    if (_init) {
      final productId = "";
      if (productId.length > 1) {
        _editedProduct = Provider.of<ProductsProvider>(context, listen: false)
            .findById(productId);
        _initValues = {
          'title': _editedProduct.title,
          'description': _editedProduct.description,
          'price': _editedProduct.price.toString(),
          // 'imageUrl': _editedProduct.imageUrl,
          'imageUrl': '',
        };
        _imageController.text = _editedProduct.imageUrl;
      }
    }
    super.didChangeDependencies();
  }

  @override
  void initState() {
    _imageUrlFocus.addListener(() => _updateImageUrl());
    super.initState();
  }

  void saveForm() {
    final isValid = _formKey.currentState!.validate();
    if (!isValid) {
      return;
    }
    if (_editedProduct.id.length > 1) {
      Provider.of<ProductsProvider>(context, listen: false)
          .updateProduct(_editedProduct.id, _editedProduct);
    } else {
      Provider.of<ProductsProvider>(context, listen: false)
          .addProduct(_editedProduct);
    }
    Navigator.of(context).pop();
  }

  void _updateImageUrl() {
    if (!_imageUrlFocus.hasFocus) {
      if ((!_imageController.text.startsWith('http') &&
              !_imageController.text.startsWith('https')) ||
          (!_imageController.text.endsWith('.png') &&
              !_imageController.text.endsWith('.jpg') &&
              !_imageController.text.endsWith('.jpeg'))) {
        return;
      }
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Your Product"),
        actions: [
          IconButton(
              onPressed: () {
                saveForm();
              },
              icon: Icon(Icons.save))
        ],
      ),
      body: SingleChildScrollView(
        child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  TextFormField(
                    initialValue: _initValues['title'],
                    decoration: InputDecoration(
                      hintText: "Enter The Product Title",
                      labelText: "Title",
                      labelStyle: TextStyle(fontSize: 20),
                    ),
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "please enter the title";
                      }
                      return null;
                    },
                    onFieldSubmitted: (_) {
                      FocusScope.of(context).requestFocus(_priceFocus);
                    },
                    onSaved: (value) {
                      _editedProduct = Product(
                          id: _editedProduct.id,
                          title: value.toString(),
                          description: _editedProduct.description,
                          price: _editedProduct.price,
                          imageUrl: _editedProduct.imageUrl,
                          isFavorite: _editedProduct.isFavorite);
                    },
                  ),
                  TextFormField(
                    initialValue: _initValues['price'],
                    onSaved: (value) {
                      _editedProduct = Product(
                          id: _editedProduct.id,
                          title: _editedProduct.title,
                          description: _editedProduct.description,
                          price: double.parse(value!),
                          imageUrl: _editedProduct.imageUrl,
                          isFavorite: _editedProduct.isFavorite);
                    },
                    decoration: InputDecoration(
                      hintText: "Enter The Product Price",
                      labelText: "Price",
                      labelStyle: TextStyle(fontSize: 20),
                    ),
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.number,
                    focusNode: _priceFocus,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "please enter the price";
                      }
                      if (double.tryParse(value) == null) {
                        return "Please enter valid number";
                      }
                      if (double.parse(value) < 0) {
                        return "Please enter number greater than zero";
                      }
                      return null;
                    },
                    onFieldSubmitted: (_) {
                      FocusScope.of(context).requestFocus(_desciptionFocus);
                    },
                  ),
                  TextFormField(
                    initialValue: _initValues['description'],
                    onSaved: (value) {
                      _editedProduct = Product(
                          id: _editedProduct.id,
                          title: _editedProduct.title,
                          description: value.toString(),
                          price: _editedProduct.price,
                          imageUrl: _editedProduct.imageUrl,
                          isFavorite: _editedProduct.isFavorite);
                    },
                    decoration: InputDecoration(
                      hintText: "Enter The Product description",
                      labelText: "Description",
                      labelStyle: TextStyle(fontSize: 20),
                    ),
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.text,
                    maxLines: 3,
                    focusNode: _desciptionFocus,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "please enter the description";
                      }
                      if (value.length < 10) {
                        return "Should be at least 10 characters long.";
                      }

                      return null;
                    },
                    onFieldSubmitted: (_) {
                      //        FocusScope.of(context).requestFocus();
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10, right: 5),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              border: Border.all(width: 1, color: Colors.grey)),
                          height: 100,
                          width: 100,
                          child: _imageController.text.isNotEmpty
                              ? FittedBox(
                                  child: Image.network(_imageController.text,
                                      fit: BoxFit.cover),
                                )
                              : Center(child: Text("Add Url")),
                        ),
                        Expanded(
                          child: TextFormField(
                            textInputAction: TextInputAction.done,
                            decoration: InputDecoration(
                                labelText: "Image Url",
                                hintText: "Enter the image url"),
                            controller: _imageController,
                            onFieldSubmitted: (_) {
                              saveForm();
                            },
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter an image URL.';
                              }
                              if (!value.startsWith('http') &&
                                  !value.startsWith('https')) {
                                return 'Please enter a valid URL.';
                              }
                              if (!value.endsWith('.png') &&
                                  !value.endsWith('.jpg') &&
                                  !value.endsWith('.jpeg')) {
                                return 'Please enter a valid image URL.';
                              }
                              return null;
                            },
                            focusNode: _imageUrlFocus,
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            )),
      ),
    );
  }
}
