import 'package:intl/intl.dart';

class Calories{
 final String time;
 final String value;
 //final String day; 

  Calories({required this.time, required this.value/*, required this.day*/});

  Calories.fromJson(/*String date,*/ Map<String, dynamic> json) : //trasformo un'istanza di timo Json in una di tipo Steps
      //time = DateFormat('yyyy-MM-dd HH:mm:ss').parse('$date ${json["time"]}'),
      time = json['time'],
      //value = int.parse(json["value"]),
      value = json["value"];
      //day = date;

  @override
  String toString() {
    return 'Calories(time: $time, value: $value)';
  }//toString
}//Calories
