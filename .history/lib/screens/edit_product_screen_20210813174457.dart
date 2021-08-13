import 'package:flutter/material.dart';

class EditProductScreen extends StatelessWidget {
  static const routeName = "/edit-product";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Your Product"),
      ),
      body: Form(
          child: Column(
        children: [
          TextFormField(
            decoration: InputDecoration(hintText: "Enter The Product Title"),
          )
        ],
      )),
    );
  }
}
