/// Table for district info.

import 'package:coronavirusstatus/providers/state_data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DistrictTable extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Consumer<StateData>(
        builder: (context, model, _) => DataTable(
          sortAscending: model.sortType,
          sortColumnIndex: model.sortCol,
          columns: model.columns
              .map(
                (e) => DataColumn(
                  label: Text(
                    e.title,
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  numeric: (e.isNumeric),
                  onSort: (i, b) {
                    model.setSort(i, b);
                    model.sort();
                  },
                ),
              )
              .toList(),
          rows: model.districts
              .map((e) =>
                  DataRow(cells: e.genRow().map((e) => DataCell(e)).toList()))
              .toList(),
        ),
      ),
    );
  }
}
