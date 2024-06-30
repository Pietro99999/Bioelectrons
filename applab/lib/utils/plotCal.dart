/*import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:applab/screens/data.dart';

class PlotCal extends StatelessWidget{

}*/

import 'package:flutter/material.dart';
import 'package:graphic/graphic.dart';

class MyChartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final categories = ['A', 'B', 'C', 'D','E'];
    final values = [30, 80, 45, 60, 50];

    return Scaffold(
      appBar: AppBar(
        title: Text('Graphic Chart Example'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Chart(
          data: List.generate(categories.length, (index) => {
            'category': categories[index],
            'value': values[index],
          }),
          variables: {
            'category': Variable(
              accessor: (Map map) => map['category'] as String,
            ),
            'value': Variable(
              accessor: (Map map) => map['value'] as num,
            ),
          },
          /*elements: [
            IntervalElement(
              elevation: Elevation(size: 5),
              color: ColorAttr(variable: 'category', values: [Colors.blue, Colors.green, Colors.red, Colors.orange]),
            ),
          ],*/
          marks: <Mark<Shape>>[
        LineMark(
          position: Varset('category') * Varset('value'),
          shape: ShapeEncode(value: BasicLineShape(smooth: true)),
          size: SizeEncode(value: 2),
          /*color: ColorEncode(
              values: [const Color(0xFF326F5E), const Color(0xFF89453C)],
              variable: 'type'),*/
        ),
        /*AreaMark(
            gradient: GradientEncode(
          value: LinearGradient(
            begin: const Alignment(0, 0),
            end: const Alignment(0, 1),
            colors: [
              const Color(0xFF326F5E).withOpacity(0.6),
              const Color(0xFFFFFFFF).withOpacity(0.0),
            ],
          ),
        ))*/  //riempio l'area sottesa dal grafico
      ],
          axes: [
            Defaults.horizontalAxis,
            Defaults.verticalAxis,
          ],
          selections: {
            'tap': PointSelection(on: {GestureType.scaleUpdate, GestureType.tap}),
          },
          tooltip: TooltipGuide(),
          crosshair: CrosshairGuide(),
        ),
      ),
    );
  }
}

void main() => runApp(MaterialApp(
  home: MyChartPage(),
));