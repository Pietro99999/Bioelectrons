import 'package:flutter/material.dart';
import 'package:applab/utils/plotCal.dart';
import 'package:graphic/graphic.dart';
import 'package:provider/provider.dart';
import 'package:applab/models/indexlistona.dart';
import 'package:intl/intl.dart';


 class Data extends StatelessWidget{
 
  final List? timeCal;  // list of strings  
  final List? sleep;  // [0]minutesAsleep [1]minutesToFallAsleep [2]efficiency   integers
  final List? valCal; // list of int strings
  final List? timeHr; // list of strings
  final List? valHr;  // list of int values
  final String? day; 
  final List listona;
  final int times;
  final String data;
  final num calories;
  final num sleeping;
  
 // IndexListona classeprova;
  
  Data({required this.day, required this.timeCal, required this.valCal, required this.timeHr, required this.valHr, required this.sleep, required this.listona, required this.times, required this.data, required this.calories, required this.sleeping,});


  @override
  Widget build(BuildContext context) {   
  
    print(times);
    int rpr = Provider.of<IndexListona>(context, listen: false).i;
    print(rpr);
    
    return Scaffold(
      appBar: AppBar (
        centerTitle: true,
        title: Text('View Data',
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
                  SizedBox(
                    height: 2,
                  ),
                  //DATA 
                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(padding: const EdgeInsets.all(8.0),
                    child: InkWell( 
                      onTap: (){},
                      child: const Icon(Icons.calendar_month,
            
                      ),
                    ),
                    ),
                    Text(data,
                     style: TextStyle(
                        color: Colors.black,
                        fontSize: 25.0,
                        //fontWeight:FontWeight.bold,
                       ),),
                    
                    Padding(padding: const EdgeInsets.all(8.0),
                    ),
                  ],
                  ),
                  SizedBox(
                    height: 20,
                  ),

                  Padding(padding: const EdgeInsets.all(8.0),
                  child: ColorChangingCard(number: times),
                    ),
                  SizedBox(height: 20),
                  Padding(padding: const EdgeInsets.all(8.0),
                  
                  ),
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
                          ..showSnackBar(SnackBar(content: Text('No more data')));

                        }
                        else{
                              int ke= Provider.of<IndexListona>(context, listen: false).i;
                             (Provider.of<IndexListona>(context, listen: false)).removeIndex();
                             int primoindex= ((listona[(Provider.of<IndexListona>(context, listen: false)).i])[0]);
                                print('l indice è $ke');
                                Provider.of<IndexListona>(context,listen:false).modifyprimoindex(primoindex);
                                int cc= Provider.of<IndexListona>(context,listen:false).primoindice;
                              print('primo indice è $cc e $primoindex');

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
                          ..showSnackBar(SnackBar(content: Text('No more data')));

                        }
                        else{
                              (Provider.of<IndexListona>(context, listen: false)).addIndex();
                              
                              int f = Provider.of<IndexListona>(context, listen: false).i;
                               int primoindex= ((listona[(Provider.of<IndexListona>(context, listen: false)).i])[0]);
                               print('l indice è $f');
                               Provider.of<IndexListona>(context,listen:false).modifyprimoindex(primoindex);
                               int g= Provider.of<IndexListona>(context,listen:false).primoindice;
                              print('primo indice è $g e $primoindex');
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
                        color:Color.fromARGB(195, 7, 121, 62),
                        child: 
                        Center(
                          child: Text('No heart rate to show',
                          style: TextStyle(
                        color: Colors.black,
                        fontSize: 20.0,
                        fontWeight:FontWeight.bold,
                       )),
                        ),
                    ));
                   }
                   else{    
                    print('yess');
                    print(Provider.of<IndexListona>(context,listen:false).primoindice);
                   return Padding(padding: const EdgeInsets.all(8.0),
                   child: Chart(
                    rebuild:true,
                   // List.generate(10000, (index)
                   //listona[(Provider.of<IndexListona>(context, listen: false)).i]
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
                      
                      );
                      }
                  }
                  ),
                  
                    ),
          Text('The above graph shows periods when heart rate reached 130. This could be significant related to drug assumption. Check motivation',
          style: TextStyle(
                        color: Colors.grey,
                        fontSize: 10.0,
                        fontWeight:FontWeight.bold,
                       ),
          textAlign: TextAlign.center,),
          SizedBox(height: 60),
          Center(
            child: Column(
            children: [
            Text('Total day calories', 
            style: TextStyle(
                        color: Colors.black,
                        fontSize: 15.0,
                        fontWeight:FontWeight.bold,
                       )),
            Caloriesdata(number: calories)
                       ],)
          ),
           SizedBox(height: 60),
          Center(
            child: Column(
            children: [
            Text('Minutes asleep', 
            style: TextStyle(
                        color: Colors.black,
                        fontSize: 15.0,
                        fontWeight:FontWeight.bold,
                       )),
            Sleepsdata(number: sleeping)
                       ],)
          )

                ],
              ),
          ),
        
        ),
    );


    //final categories = ['A', 'B', 'C', 'D','E'];
    //final values = [30, 80, 45, 60, 50];

   /*return Scaffold(
      appBar: AppBar(
        title: Text('Graphic HR'),
      ),
      body: 
      Column(
        children: [
      Padding(
        padding: const EdgeInsets.all(16.0),
        child: Chart(
          data: List.generate(10000, (index) => {
            'category': timeHr?[index],
            'value': valHr?[index],
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
       ]
      )
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
      
  
      );*/*/

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
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 15.0),
        child: Column(
          children: [
         Text(
          'Possible drug times: $number',
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
        SizedBox(
          height: 5,
        ),
        Text(
          'Check the data below',
          style: TextStyle(fontSize: 10, color: Colors.white),
        ),
        ]
        )
      ),
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
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
        SizedBox(
          height: 5,
        ),
        Text(
          'Referring at a medium value of 2500 a day. Check motivations',
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
      color: _getColorBasedOnNumbercalories(number),
      child: Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 15.0),
        child: Column(
          children: [
         Text(
          '$number',
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
        SizedBox(
          height: 5,
        ),
        Text(
          'Check motivations',
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
    if (number >1000) {
      return Colors.green.withOpacity(0.5);
    } else {
      return Colors.red.withOpacity(0.5);
    } 
  }