import 'package:flutter/material.dart';

class NavDrawer extends StatelessWidget {
  static const list = [
    [],
    ["Home", "/home"],
    ['States', "/states"],
    ['Graphs', "/graphs"],
    ['Helpful Links', "/help"],
    ['Settings', '/settings']
  ];

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView.builder(
        itemCount: list.length,
        itemBuilder: (context, index) {
          if (index == 0) {
            return DrawerHeader(
              child: Text(
                "More Information",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
              ),
            );
          }
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
