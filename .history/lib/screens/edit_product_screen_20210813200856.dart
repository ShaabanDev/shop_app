import 'package:flutter/material.dart';
import 'package:shop_app/providers/product.dart';

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
  var newProduct =
      Product(id: "", title: "", description: "", price: 0, imageUrl: "");

  @override
  void dispose() {
    _imageController.dispose();
    _imageUrlFocus.dispose();
    _desciptionFocus.dispose();
    _priceFocus.dispose();
    super.dispose();
  }

  var _init = true;

  @override
  void didChangeDependencies() {
    if (_init) {}
    super.didChangeDependencies();
  }

  void saveForm() {
    if (_formKey.currentState!.validate()) {}
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
                      newProduct = Product(
                          id: newProduct.id,
                          title: value.toString(),
                          description: newProduct.description,
                          price: newProduct.price,
                          imageUrl: newProduct.imageUrl,
                          isFavorite: newProduct.isFavorite);
                    },
                  ),
                  TextFormField(
                    onSaved: (value) {
                      newProduct = Product(
                          id: newProduct.id,
                          title: newProduct.title,
                          description: newProduct.description,
                          price: double.parse(value!),
                          imageUrl: newProduct.imageUrl,
                          isFavorite: newProduct.isFavorite);
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
                    onSaved: (value) {
                      newProduct = Product(
                          id: newProduct.id,
                          title: newProduct.title,
                          description: value.toString(),
                          price: newProduct.price,
                          imageUrl: newProduct.imageUrl,
                          isFavorite: newProduct.isFavorite);
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
                          child: NetworkImage(_imageController.text),
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
