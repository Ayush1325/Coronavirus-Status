/// Table for States data.

import 'package:coronavirusstatus/pages/state.dart';
import 'package:coronavirusstatus/providers/states_data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StatesTable extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(builder: (context, _) {
      Provider.of<StatesData>(context, listen: false)
          .refreshSize(MediaQuery.of(context).size);
      return Content();
    });
  }
}

class Content extends StatelessWidget {
  const Content({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<StatesData>(
      builder: (context, model, _) => RefreshIndicator(
        onRefresh: model.refresh,
        child: SingleChildScrollView(
          child: DataTable(
            columnSpacing: 48,
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
                      },
                    ))
                .toList(),
            rows: model.data
                .map((i) => DataRow(
                    cells: i
                        .genRow(model.width)
                        .map((e) => DataCell(
                              e,
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => StateInfo(
                                      state: i.state,
                                      data: i.getStateData(),
                                    ),
                                  ),
                                );
                              },
                            ))
                        .toList()))
                .toList(),
          ),
        ),
      ),
    );
  }
}
