import 'package:coronavirusstatus/providers/general_data.dart';
import 'package:flutter/material.dart';
import 'package:coronavirusstatus/components/info_bubble.dart';
import 'package:provider/provider.dart';

class BubblesList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<GeneralData>(builder: (context, model, _) {
      List<BubbleData> temp = List();
      if (model.items > 0) {
        temp = model.data[model.key].getData();
      }
      return ListView.builder(
        itemCount: model.items,
        itemBuilder: (context, index) {
          return InfoBubble(
            title: temp[index].title,
            num: temp[index].num.toString(),
            color: temp[index].color,
          );
        },
      );
    });
  }
}
