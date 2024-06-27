import 'package:flutter/material.dart';
import 'package:applab/utils/plotCal.dart';
import 'package:flutter/widgets.dart';
import 'package:graphic/graphic.dart';

 class Data extends StatelessWidget{
 
  final List? timeCal;  // list of strings  
  final List? sleep;  // [0]minutesAsleep [1]minutesToFallAsleep [2]efficiency   integers
  final List? valCal; // list of int strings
  final List? timeHr; // list of strings
  final List? valHr;  // list of int values
  final String? day; 
  final List listona;
    
  Data({required this.day, required this.timeCal, required this.valCal, required this.timeHr, required this.valHr, required this.sleep, required this.listona});
  

  Widget build(BuildContext context) { 
    return Scaffold(
      appBar: AppBar(
        title: Text('Graphic HR'),
      ),
      body: Padding(
        padding: const EdgeInsets.only(),
        child: Chart(
          data: List.generate(timeHr!.length, (index) => {
            'time': timeHr?[index],
            'value': valHr?[index],
          }),
          variables: {
            'time': Variable(
              accessor: (Map map) => map['time'] as String,
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
          position: Varset('time') * Varset('value'),
          shape: ShapeEncode(value: BasicLineShape(smooth: true)),
          size: SizeEncode(value: 2),
          //color:,
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
    /*return Scaffold(  
      body: Center(Column( mainAxisAlignment: MainAxisAlignment.center,
          children: [
          Text('Day = $day'), 
          Text('time: ${timeCal?[0]} calories: ${valCal?[0]+valCal?[154]}'),
          Text('time: ${timeHr?[0]} hr: ${valHr?[1]}'),
          Text('minutesAsleep = ${sleep?[0]} minutesToFallAsleep = ${sleep?[1]} efficiency = ${sleep?[2]}'),   
        ],//children
        ),
        
        
      ),
      
  
      );*/

      }//build
}//Class Data

 