import 'package:applab/models/steps.dart';
import 'package:flutter/material.dart';
import 'package:applab/screens/view_patient.dart';
import 'package:applab/models/calories.dart';
import 'package:applab/models/HR.dart';
import 'package:applab/models/sleep.dart';

class Data extends StatelessWidget{
  List<Steps>? steps; 
  List<Calories>? calories;
  List? sleep;
  List<HR>? hr;
  String? day; 
    Data({required this.day, required this.steps, required this.calories, required this.hr, required this.sleep});
  
   Widget build(BuildContext context) {   
    return Scaffold(  
      body: Center(
        child: Column( mainAxisAlignment: MainAxisAlignment.center,
          children: [
          Text('Day = $day'),  
          Text('${steps?[10]}'),
          Text('${calories?[5]}'),
          Text('${hr?[2]}'),
          Text('minutesAsleep = ${sleep?[0]} minutesToFallAsleep = ${sleep?[1]} efficiency = ${sleep?[2]}'),        
          
          
        ],
        ),
      ),  
  
      );}
}//Class Data