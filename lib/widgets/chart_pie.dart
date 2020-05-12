import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import '../models/transaction.dart';
import 'package:intl/intl.dart';
import '../models/pietask.dart';
import 'dart:collection';

class ChartPie extends StatelessWidget {
  final List<Transaction> recentTransactions;
  final LinkedHashMap linkedHashMap = new LinkedHashMap<String, Color>();
  final LinkedHashMap dayCodeLinkedHashMap = new LinkedHashMap<String, int>();

  ChartPie(this.recentTransactions);

  Map get colorMap {
    linkedHashMap['Mo'] = Colors.lightBlueAccent[200];
    linkedHashMap['Tu'] = Colors.pink[300];
    linkedHashMap['We'] = Colors.lightGreen;
    linkedHashMap['Th'] = Colors.brown[200];
    linkedHashMap['Fr'] = Colors.tealAccent;
    linkedHashMap['Sa'] = Colors.indigo[300];
    linkedHashMap['Su'] = Colors.red[300];
    return linkedHashMap;
  }

  Map get dayCodeMap {
    dayCodeLinkedHashMap['Mo'] = 1;
    dayCodeLinkedHashMap['Tu'] = 2;
    dayCodeLinkedHashMap['We'] = 3;
    dayCodeLinkedHashMap['Th'] = 4;
    dayCodeLinkedHashMap['Fr'] = 5;
    dayCodeLinkedHashMap['Sa'] = 6;
    dayCodeLinkedHashMap['Su'] = 7;
    return dayCodeLinkedHashMap;
  }

  List<PieTask> get pieData {
    //gerenate linked hashmap
    List<PieTask> finalLis = List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(
        Duration(days: index),
      );
      var totalSum = 0.0;
      for (var i = 0; i < recentTransactions.length; i++) {
        if (recentTransactions[i].date.day == weekDay.day &&
            recentTransactions[i].date.month == weekDay.month &&
            recentTransactions[i].date.year == weekDay.year) {
          totalSum += recentTransactions[i].amount;
        }
      }

      return PieTask(
          DateFormat.E().format(weekDay).substring(0, 2),
          totalSum,
          colorMap[colorMap.keys.singleWhere((element) =>
              element == DateFormat.E().format(weekDay).substring(0, 2))],
          dayCodeMap[DateFormat.E().format(weekDay).substring(0, 2)]);
    }).toList();
    finalLis.sort((PieTask t1, PieTask t2) => t1.dayCode.compareTo(t2.dayCode));
    return finalLis;
  }

  List<charts.Series<PieTask, String>> get _seriesPieDataUpdate {
    List<charts.Series<PieTask, String>> _seriesPieUpdate =
        List<charts.Series<PieTask, String>>();
    if (recentTransactions.isNotEmpty) {
      _seriesPieUpdate.add(
        charts.Series(
          domainFn: (PieTask task, _) => task.task,
          measureFn: (PieTask task, _) => task.taskvalue,
          colorFn: (PieTask task, _) =>
              charts.ColorUtil.fromDartColor(task.colorval),
          id: 'Spending',
          data: pieData,
          labelAccessorFn: (PieTask row, _) => '${row.taskvalue}',
        ),
      );
    }
    return _seriesPieUpdate.length == 0 ? null : _seriesPieUpdate;
  }

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
          maxHeight: 250, minHeight: 0, maxWidth: 250, minWidth: 0),
      child: Container(
        child: _seriesPieDataUpdate != null
            ? charts.PieChart(
                _seriesPieDataUpdate,
                animate: true,
                animationDuration: Duration(seconds: 1),
                behaviors: [
                  new charts.DatumLegend(
                    outsideJustification:
                        charts.OutsideJustification.endDrawArea,
                    horizontalFirst: true,
                    desiredMaxColumns: 3,
                    cellPadding: new EdgeInsets.only(right: 4.0, bottom: 4.0),
                    entryTextStyle: charts.TextStyleSpec(
                        color: charts.MaterialPalette.purple.shadeDefault,
                        fontFamily: 'Georgia',
                        fontSize: 11),
                  )
                ],
                defaultRenderer: new charts.ArcRendererConfig(
                    arcWidth: 100,
                    arcRendererDecorators: [
                      new charts.ArcLabelDecorator(
                        labelPosition: charts.ArcLabelPosition.outside,
                      )
                    ]),
              )
            : SizedBox.shrink(),
      ),
    );
  }
}
