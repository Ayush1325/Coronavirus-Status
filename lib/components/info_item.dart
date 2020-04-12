/// Item to display particular info.

import 'package:flutter/material.dart';

class InfoItem extends StatelessWidget {
  final String title;
  final Color color;
  final int count;
  final int delta;

  InfoItem({Key key, this.title, this.count, this.delta, this.color});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: ListTile(
          title: Text(
            this.title,
            style: TextStyle(
              fontSize: 20,
              color: this.color,
            ),
          ),
          subtitle: Padding(
            padding: EdgeInsets.all(5),
            child: Text(
              this.count.toString(),
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: this.color,
              ),
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
        ),
      ),
    );
  }
}
