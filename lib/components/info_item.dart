import 'package:flutter/material.dart';

class InfoItem extends StatelessWidget {
  final String title;
  final Color color;
  final int count;
  final int delta;

  InfoItem({Key key, this.title, this.count, this.delta, this.color});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        this.title,
        style: TextStyle(
          fontSize: 20,
          color: this.color,
        ),
      ),
      subtitle: Text(
        this.count.toString(),
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: this.color,
        ),
      ),
      trailing: Visibility(
        visible: (this.delta != 0),
        child: Text(
          "+" + this.delta.toString(),
          style: TextStyle(
            color: this.color,
            fontSize: 18,
          ),
        ),
      ),
    );
  }
}