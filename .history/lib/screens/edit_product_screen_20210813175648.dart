import 'package:flutter/material.dart';

class EditProductScreen extends StatelessWidget {
  var _formKey = GlobalKey<FormState>();
  void validateFrom() {
    if (_formKey.currentState!.validate()) {}
  }

  static const routeName = "/edit-product";
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
                )
              ],
            ),
          )),
    );
  }
}
