import 'package:coronavirusstatus/pages/state.dart';
import 'package:coronavirusstatus/providers/states_data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StatesTable extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<StatesData>(
      builder: (context, model, _) => RefreshIndicator(
        onRefresh: model.refresh,
        child: OrientationBuilder(builder: (context, _) {
          model.refreshSize(MediaQuery.of(context).size);
          return SingleChildScrollView(
            child: DataTable(
              sortAscending: model.sortType,
              sortColumnIndex: model.sortCol,
              columns: model.columns
                  .map((e) => DataColumn(
                        label: Text(
                          e.title,
                          style: Theme.of(context).textTheme.headline6,
                        ),
                        numeric: (e.isNumeric),
                        onSort: (i, b) {
                          model.setSort(i, b);
                          model.sort();
                        },
                      ))
                  .toList(),
              rows: model.data
                  .map((i) => DataRow(
                      cells: i
                          .getRow(model.width)
                          .map((e) => DataCell(
                                Text(
                                  e,
                                  style: TextStyle(fontSize: 15),
                                ),
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) => StateInfo(
                                                dat: i.getStateData(),
                                              )));
                                },
                              ))
                          .toList()))
                  .toList(),
            ),
          );
        }),
      ),
    );
  }
}
