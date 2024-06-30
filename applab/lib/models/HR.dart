import 'package:intl/intl.dart';

class HR{
 final String time;
 final int value;
 //final String day; 

  HR({required this.time, required this.value/*, required this.day*/});

  HR.fromJson(/*String date,*/ Map<String, dynamic> json) : //trasformo un'istanza di timo Json in una di tipo Steps
      //time = DateFormat('yyyy-MM-dd HH:mm:ss').parse('$date ${json["time"]}'),
      time = json['time'],
      //value = int.parse(json["value"]),
      value = json["value"];
      //day = date;

  @override
  String toString() {
    return 'HR(time: $time, value: $value)';
  }//toString
}//HR
