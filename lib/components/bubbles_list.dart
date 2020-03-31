import 'package:coronavirusstatus/providers/india.dart';
import 'package:flutter/material.dart';
import 'package:coronavirusstatus/components/info_bubble.dart';
import 'package:provider/provider.dart';

class BubblesList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<India>(builder: (context, model, _) {
      return ListView.builder(
        itemCount: model.homeData.length,
        itemBuilder: (context, index) {
          return InfoBubble(
            title: model.homeData[index].title,
            num: model.homeData[index].value,
            color: model.homeData[index].color,
          );
        },
      );
    });
  }
}
