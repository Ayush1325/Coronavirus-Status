import 'package:flutter/material.dart';

const list = [
  ["Home", "/home"],
  ["Graph", "/graph"]
];

class NavDrawer extends StatelessWidget {
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
              Navigator.pushNamed(context, list[index][2]);
            },
          );
        },
      ),
    );
  }
}
