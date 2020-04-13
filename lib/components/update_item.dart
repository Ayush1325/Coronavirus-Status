import 'package:flutter/material.dart';

class UpdateItem extends StatelessWidget {
  final DateTime time;
  final String update;

  UpdateItem({Key key, this.time, this.update});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(
          delta(),
          style: TextStyle(color: Colors.blueGrey),
        ),
        subtitle: Text(update),
      ),
    );
  }

  String delta() {
    Duration temp = DateTime.now().difference(time);
    if (temp.inSeconds < 60) {
      return "${temp.inSeconds} Seconds Ago";
    } else if (temp.inMinutes < 60) {
      return "${temp.inMinutes} Minutes Ago";
    } else if (temp.inHours < 24) {
      return "About ${(temp.inMinutes / 60).round()} Hours";
    } else {
      return "About ${temp.inDays} Days";
    }
  }
}
