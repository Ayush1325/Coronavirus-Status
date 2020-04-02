import 'package:coronavirusstatus/components/info_item.dart';
import 'package:coronavirusstatus/providers/general_data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class InfoList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<GeneralData>(
      builder: (context, model, _) => RefreshIndicator(
        onRefresh: model.refresh,
        child: ListView.builder(
          itemBuilder: (context, index) => InfoItem(
            title: model.data[index].title,
            count: model.data[index].num,
            delta: model.data[index].delta,
            color: model.data[index].color,
          ),
          itemCount: model.data.length,
        ),
      ),
    );
  }
}
