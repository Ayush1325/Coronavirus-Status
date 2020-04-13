import 'package:coronavirusstatus/components/update_item.dart';
import 'package:coronavirusstatus/providers/updates_data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UpdatesList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<UpdatesData>(
      builder: (_, model, __) => RefreshIndicator(
        onRefresh: model.refresh,
        child: ListView.builder(
          padding: EdgeInsets.fromLTRB(2, 5, 2, 5),
          itemCount: model.data.length,
          itemBuilder: (context, index) => UpdateItem(
            time: model.data[index].time,
            update: model.data[index].value,
          ),
        ),
      ),
    );
  }
}
