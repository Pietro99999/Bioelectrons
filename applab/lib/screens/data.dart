import 'package:flutter/material.dart';
import 'package:graphic/graphic.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:applab/providers/indexlistona.dart';




 class Data extends StatelessWidget{
 
  final List? timeCal;  // list of strings  
  final List? sleep;  // [0]minutesAsleep [1]minutesToFallAsleep [2]efficiency   integers
  final List? valCal; // list of int strings
  final List? timeHr; // list of strings
  final List? valHr;  // list of int values
  final String? day; 
  final List listona;
  final int times;
  final DateTime? data;
  final num calories;
  final num sleeping;
  
 
  
  Data({required this.day, required this.timeCal, required this.valCal, required this.timeHr, required this.valHr, required this.sleep, required this.listona, required this.times, required this.data, required this.calories, required this.sleeping,});


  @override
  Widget build(BuildContext context) {   
  
    
    return Scaffold(
      appBar: AppBar (
        centerTitle: true,
        title: Text('VIEW DAY',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 30.0,
                        fontWeight:FontWeight.bold,
                       ),)
                       ,
        backgroundColor:Color.fromRGBO(36, 208, 220, 1),
       
      


      ),
      body:  SingleChildScrollView(
      child: Padding(
          padding: 
            const EdgeInsets.only(left: 12.0, right: 12.0, top: 10, bottom: 20),
            child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                 
                  //DATA 
                  Row(mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    coloredPadding(
                    child: 
                     
                    Text(formatDate(data),
                     style: TextStyle(
                        color: Colors.white,
                        fontSize: 24.0,
                        fontWeight:FontWeight.bold
                        
                       
                       ),),
                       color: Color.fromRGBO(36, 208, 220, 1),
                       padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 60),
                    ),
                  ],
                  ),
                  SizedBox(
                    height: 40,
                  ),

                  Padding(padding: const EdgeInsets.all(8.0),
                  child: ColorChangingCard(number: times),
                    ),
                     Divider(
              color: Colors.black.withOpacity(0.5), 
              thickness: 2, 
              indent: 5,
              endIndent: 5,
            ),
                  SizedBox(height: 30),
                  Text('DATA SUMMARY', style: TextStyle(fontSize: 20, color: Colors.black, fontWeight:FontWeight.bold ),),
                  Padding(padding: const EdgeInsets.all(8.0),
                  
                  ),
                  Container(
                    decoration: BoxDecoration(
            border: Border.all(color: Colors.black.withOpacity(0.5), width: 2),
            borderRadius: BorderRadius.circular(12),
          ),
                  child: Column(
                    children: [  
                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(padding: const EdgeInsets.all(8.0),
                    child: InkWell( 
                      onTap: (){
                        int newindex=(Provider.of<IndexListona>(context, listen: false)).i;
                        newindex=newindex-1;
                         print(newindex);
                        if (newindex<0 ){
                          ScaffoldMessenger.of(context)
                          ..removeCurrentSnackBar()
                          ..showSnackBar(SnackBar(content: Text('No more data to show')));

                        }
                        else{
                              int ke= Provider.of<IndexListona>(context, listen: false).i;
                             (Provider.of<IndexListona>(context, listen: false)).removeIndex();
                             int primoindex= ((listona[(Provider.of<IndexListona>(context, listen: false)).i])[0]);
                              
                                Provider.of<IndexListona>(context,listen:false).modifyprimoindex(primoindex);
                                int cc= Provider.of<IndexListona>(context,listen:false).primoindice;
                             

                        }
                      },
                      child: const Icon(Icons.navigate_before,
                      ),
                    ),
                    ),
                    Text('Heartrate',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 15.0,
                        fontWeight:FontWeight.bold,
                       )),
                    Padding(padding: const EdgeInsets.all(8.0),
                    child: InkWell( 
                      onTap: (){
                        int newindex=(Provider.of<IndexListona>(context, listen: false)).i;
                        newindex=newindex+1;
                        print(newindex);
                        if (newindex>=times ){
                          ScaffoldMessenger.of(context)
                          ..removeCurrentSnackBar()
                          ..showSnackBar(SnackBar(content: Text('No more data to show')));

                        }
                        else{
                              (Provider.of<IndexListona>(context, listen: false)).addIndex();
                              
                              int f = Provider.of<IndexListona>(context, listen: false).i;
                               int primoindex= ((listona[(Provider.of<IndexListona>(context, listen: false)).i])[0]);
                               Provider.of<IndexListona>(context,listen:false).modifyprimoindex(primoindex);
                               int g= Provider.of<IndexListona>(context,listen:false).primoindice;
                             
                        }
              
                      },
                      child: const Icon(Icons.navigate_next,
                      ),
                    ),
                    ),
                  ],
                  ),
                  AspectRatio(
                    aspectRatio: 16/9,
                    child: Consumer<IndexListona>(builder: (context, provider, child){
                   if (Provider.of<IndexListona>(context,listen:false).primoindice==-1){
                    print('trie');
                    return Padding(padding: const EdgeInsets.all(8.0),
                    child: Card(
                      elevation: 1,
                        color:Colors.green.withOpacity(0.5),
                        child: 
                        Center(
                          child: Text('No critical event to show',
                          style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                        fontWeight:FontWeight.bold,
                       )),
                        ),
                    ));
                   }
                   else{    
                   return Padding(padding: const EdgeInsets.all(8.0),
                   child: Chart(
                    rebuild:true,
          data:  List.generate((listona[(Provider.of<IndexListona>(context, listen: false)).i]).length, (index)=> {
            'category': timeHr?[index + Provider.of<IndexListona>(context,listen:false).primoindice],
            'value': valHr?[index+Provider.of<IndexListona>(context,listen:false).primoindice],
          }),
          variables: {
            'category': Variable(
              accessor: (Map map) => map['category'] as String,
              scale: OrdinalScale(tickCount: 5)
            ),
            'value': Variable(
              accessor: (Map map) => map['value'] as num,
            ),
          },
          
          marks: <Mark<Shape>>[
        LineMark(
          position: Varset('category') * Varset('value'),
          shape: ShapeEncode(value: BasicLineShape(smooth: true)),
          size: SizeEncode(value: 2),
          //color:,
        ),
        
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
                      
                      );
                      }
                  }
                  ),
                  
                    ),
                     Text('The above graph shows periods when heart rate exceeds the value of 140. \nThis could be significant related to coke assumption. Check motivation with the patient',
          style: TextStyle(
                        color: Colors.grey,
                        fontSize: 10.0,
                        fontWeight:FontWeight.bold,
                       ),
          textAlign: TextAlign.center,),
          SizedBox(height: 10),
                   ],
                  ),
            ),
          SizedBox(height: 40),
          Container(
             decoration: BoxDecoration(
            border: Border.all(color: Colors.black.withOpacity(0.5), width: 2),
            borderRadius: BorderRadius.circular(12),
          ),
            child:
          Center(
            child: Column(
            children: [
               SizedBox(height: 10),
            Text('Total day calories', 
            style: TextStyle(
                        color: Colors.black,
                        fontSize: 15.0,
                        fontWeight:FontWeight.bold,
                       )),
            Caloriesdata(number: calories),
            Text('The drug use can increase the consumed cal/day. Check motivation with the patient',
             style: TextStyle(
                        color: Colors.grey,
                        fontSize: 10.0,
                        fontWeight:FontWeight.bold,
                       ),
          textAlign: TextAlign.center),
           SizedBox(height: 10),
                       ],)
          ),
            ),
           SizedBox(height: 40),
           Container( decoration: BoxDecoration(
            border: Border.all(color: Colors.black.withOpacity(0.5), width: 2),
            borderRadius: BorderRadius.circular(12),
          ),
          child:
          Center(
            child: Column(
            children: [
              SizedBox(height: 10),
            Text('Hours asleep', 
            style: TextStyle(
                        color: Colors.black,
                        fontSize: 15.0,
                        fontWeight:FontWeight.bold,
                       )),
            Sleepsdata(number: sleeping),
            Text('The drug use can decrease the sleeping hours. Moreover, the patient under treatment should get at least 9h of sleeps. \nIn case of lack of sleep, check with the patient',
             style: TextStyle(
                        color: Colors.grey,
                        fontSize: 10.0,
                        fontWeight:FontWeight.bold,
                       ),
          textAlign: TextAlign.center),
          SizedBox(height: 10),
                       ],)
          )
            ),

                ],
              ),
          ),
        
        ),
    );


   
      }//build
}//Class Data



class ColorChangingCard extends StatelessWidget {
  final int number;

  ColorChangingCard({required this.number});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: _getColorBasedOnNumber(number),
      child: Center(
      child: 
      Row(
          children: [
            Padding(padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 25.0),
              child:
            Icon(_smileface(number),
                color: Colors.white,
                size:50,)),
            Padding( padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 15.0),
            child:
            Column(
              children: [
         Text(
          ' DRUG EVENTS: $number',
          style: TextStyle(fontSize: 20, color: Colors.white, fontWeight:FontWeight.bold ),
        ),
        SizedBox(
          height:2 ,
        ),
        Text(
          'Warning: this is only an estimation \nbased on recorded data',
          style: TextStyle(fontSize: 10, color: Colors.white),
          textAlign: TextAlign.center,
        ),
        ]
        ),
      ),
        
        ]
        )
      )
    );
  }
  }

  class Caloriesdata extends StatelessWidget {
  final num number;

  Caloriesdata({required this.number});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: _getColorBasedOnNumbercalories(number),
      child: Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 15.0),
        child: Column(
          children: [
         Text(
          '$number',
          style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 5,
        ),
        Text(
          'Referring at a medium value of 2500 cal/day. ',
          style: TextStyle(fontSize: 10, color: Colors.white),
        ),
        ]
        )
      ),
      )
    );
  }
  }

   class Sleepsdata extends StatelessWidget {
  final num number;

  Sleepsdata({required this.number});

  @override
  Widget build(BuildContext context) {
     return Card(
      color: _getColorBasedOnNumbersleep(number),
      child: Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 15.0),
        child: Column(
          children: [
         Text(
          transformMinutesToHours(number),
          style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 5,
        ),
        Text(
          'Referring to a large value of sleeping hours for dependecies treatment.',
          style: TextStyle(fontSize: 10, color: Colors.white),
        ),
        ]
        )
      ),
      )
    );
  }
  }

Color _getColorBasedOnNumber(int number) {
    if (number == 0) {
      return Colors.green.withOpacity(0.5);
    } else {
      return Colors.red.withOpacity(0.5);
    } 
  }


  Color _getColorBasedOnNumbercalories(num number) {
    if (number <2500) {
      return Colors.green.withOpacity(0.5);
    } else {
      return Colors.red.withOpacity(0.5);
    } 
  }

    Color _getColorBasedOnNumbersleep(num number) {
    if (number >510) {
      return Colors.green.withOpacity(0.5);
    } else {
      return Colors.red.withOpacity(0.5);
    } 
  }

  IconData _smileface(num number) {
    if (number == 0) {
      return Icons.sentiment_satisfied;
    } else {
      return Icons.sentiment_dissatisfied;
    } 
  }
  String formatDate(DateTime? date) {
  // Format the date
  if (date!= null){
  final String day = DateFormat('EEEE').format(date); // Tuesday
  final String dateFormatted = DateFormat('dd/MM/yyyy').format(date); // 08/07/2024
  return '$day $dateFormatted';
  }
  else{
    return 'no day';
  }
}

Widget coloredPadding({required Widget child, required Color color, required EdgeInsets padding}) {
  return Container(
    color: color,
    child: Padding(
      padding: padding,
      child: child,
    ),
  );
}

String transformMinutesToHours(num totalMinutes) {
  int hours = totalMinutes ~/ 60; // Integer division to get the hours
  num minutes = totalMinutes % 60; // Remainder to get the remaining minutes
  return '$hours h $minutes min';
}

