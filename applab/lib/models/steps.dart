import 'package:intl/intl.dart';

class Steps{ 
 final String time;
 final int value;
 
 //final String date;


  Steps({/*required this.date,*/ required this.value, required this.time});

  Steps.fromJson(/*String day,*/ Map<String, dynamic> json) : //trasformo un'istanza di timo Json in una di tipo Steps
      //time = DateFormat('yyyy-MM-dd HH:mm:ss').parse('$date ${json["time"]}'),
      time = json['time'],
      value = int.parse(json["value"]);
     // date=day;

  @override
  String toString() {
    return 'Steps(time: $time, value: $value)';
  }//toString

  /*List toList(){
    List steps = [];
    steps.add(time);
    steps.add(value);
    return (steps);

  }*/


}//Steps

