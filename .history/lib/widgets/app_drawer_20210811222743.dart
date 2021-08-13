import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          AppBar(
              title: Text("Hello Friend !"), automaticallyImplyLeading: true),
          ListTile(
              leading: Icon(Icons.shop),
              title: Text("Shop"),
              onTap: () {
                Navigator.of(context).pushReplacementNamed("/");
              }),
          Divider(),
          ListTile(
              leading: Icon(Icons.payment),
              title: Text("Orders"),
              onTap: () {}),
          Divider(),
          ListTile(
              leading: Icon(Icons.edit),
              title: Text("Manage Your Products"),
              onTap: () {}),
          Divider(),
        ],
      ),
    );
  }
}
