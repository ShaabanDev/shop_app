import 'package:flutter/material.dart';

class EditProductScreen extends StatefulWidget {
  static const routeName = "/edit-product";

  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  var _formKey = GlobalKey<FormState>();
  var _priceFocus = FocusNode();
  var _desciptionFocus = FocusNode();
  var _imageUrl = FocusNode();
  var _imageController = TextEditingController();

  void saveForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.validate();
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
                  ),
                  TextFormField(
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
                        ),
                        Expanded(
                            child: TextFormField(
                          decoration: InputDecoration(
                              labelText: "Image Url",
                              hintText: "Enter the image url"),
                        ))
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
