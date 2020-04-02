import 'package:flutter/material.dart';

class NavDrawer extends StatelessWidget {
  final list = [
    [],
    ["Home", "/home"],
    ['States', "/states"],
    ['Graphs', "/graphs"],
    ['Helpful Links', "/help"],
    ['About', '/about'],
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
                color: Colors.blue,
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
