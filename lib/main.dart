import 'dart:math';
import 'package:flutter/material.dart';
import 'package:mp_chart/mp/chart/line_chart.dart';
import 'package:mp_chart/mp/controller/line_chart_controller.dart';
import 'package:mp_chart/mp/core/data/line_data.dart';
import 'package:mp_chart/mp/core/data_interfaces/i_line_data_set.dart';
import 'package:mp_chart/mp/core/data_set/line_data_set.dart';
import 'package:mp_chart/mp/core/entry/entry.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Test MP Chart',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Test MP Chart'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  LineChartController _controller = LineChartController();

  @override
  void initState() {
    _initData();
    super.initState();
  }

  _initData() {
    var random = Random();
    List<Entry> values = List();
    List<Entry> values2 = List();
    double val2 = (random.nextDouble() * 150) + 50;

    for (int i = 0; i < 15; i++) {
      double val = (random.nextDouble() * 64) - 30;
      values.add(Entry(x: i.toDouble(), y: val));

      values2.add(Entry(x: i.toDouble(), y: val2));
      var evol = random.nextBool()
          ? (random.nextDouble() * 15)
          : -(random.nextDouble() * 10);
      val2 = val2 + evol;
    }

    LineDataSet set1 = LineDataSet(values, "DataSet 1");
    LineDataSet set2 = LineDataSet(values2, "DataSet 2")
      ..setDrawValues(false)
      ..setDrawCircles(false)
      ..setColor1(Colors.blue);
    List<ILineDataSet> dataSets = List()..add(set1)..add(set2);
    _controller.data = LineData.fromList(dataSets);
  }

  _refresh() {
    setState(() {
      _initData();
    });
    _controller.animator
      ..reset()
      ..animateX1(1500);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Stack(
        children: <Widget>[
          Positioned(
            right: 0,
            left: 0,
            top: 0,
            bottom: 30,
            child: LineChart(_controller),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _refresh,
        tooltip: 'Refresh',
        child: Icon(Icons.refresh),
      ),
    );
  }
}
