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
    if (_formKey.currentState!.validate()) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Your Product"),
      ),
      body: Form(
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
                    FocusScope.of(context).requestFocus(_priceFocus);
                  },
                )
              ],
            ),
          )),
    );
  }
}
