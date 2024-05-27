import 'package:hive/hive.dart';


part 'doctordatabase.g.dart';

@HiveType(typeId: 0)
class Doctordatabase extends HiveObject{

  @HiveField(0)
  String surname;

  @HiveField(1)
  String email;

   @HiveField(2)
  String password;

  Doctordatabase(this.surname, this.email, this.password);

}
