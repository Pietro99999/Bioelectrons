import 'package:intl/intl.dart';

class Sleep{
 //final String time;
 //final String value;
 //final String day; 
 final int minutesAsleep; 
 final int minutesToFallAsleep; 
 final int efficiency; 

  Sleep({required this.minutesAsleep, required this.minutesToFallAsleep, required this.efficiency});

  Sleep.fromJson(int minSleep, int minFall, int eff) : //trasformo un'istanza di timo Json in una di tipo Sleep
      //time = DateFormat('yyyy-MM-dd HH:mm:ss').parse('$date ${json["time"]}'),
      //time = json['time'],
     // value = int.parse(json["value"]),
    // value = json["value"],
      minutesAsleep = minSleep,
      minutesToFallAsleep = minFall,
      efficiency = eff;
      //day = date;

  @override
  String toString() {
    return 'Sleep(day:  minutesAsleep: $minutesAsleep)'; //da sistemare
  }//toString
}//Calories
