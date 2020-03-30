import 'package:flutter/material.dart';
import 'package:coronavirusstatus/components/info_bubble.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
      ),
      body: ListView(
        children: <Widget>[
          InfoBubble(
            title: "Total Cases",
            num: 1071,
            color: Colors.amber,
          ),
          InfoBubble(
            title: "Deaths",
            num: 29,
            color: Colors.red,
          ),
          InfoBubble(
            title: "Recovered",
            num: 100,
            color: Colors.blue,
          ),
        ],
      ),
    );
  }
}
