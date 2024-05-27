import 'package:hive/hive.dart';
//import 'package:flutter/material.dart' ;

part 'patientdatabase.g.dart';


@HiveType(typeId: 1)
class Patientdatabase extends HiveObject{
  @HiveField(0)
  String patients;

  @HiveField(1)
  String age;

  @HiveField(2)
  String weight;

  @HiveField(3)
  String height;

  @HiveField(4)
  bool sex=true;

  @HiveField(5)
  String doctorname;


  //Constructor
  Patientdatabase(this.patients, this.age,  this.weight, this.height, this.doctorname);
  
}