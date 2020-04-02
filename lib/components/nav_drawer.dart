import 'package:flutter/material.dart';

class NavDrawer extends StatelessWidget {
  final list = [
    ["Home", "/home"],
    ['States', "/states"],
  ];

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView.builder(
        itemCount: list.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(list[index][0]),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushReplacementNamed(context, list[index][1]);
            },
          );
        },
      ),
    );
  }
}
