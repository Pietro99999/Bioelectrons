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
  bool sex;
  
  @HiveField(5)
  String year;

  @HiveField(6)
  String grav;

  @HiveField(7)
  String treatm;

  @HiveField(8)
  List drug;

  @HiveField(9)
  String doctorname;


  //Constructor
  Patientdatabase(this.patients, this.age,  this.weight, this.height, this.sex, this.year, this.grav,this.treatm,this.drug, this.doctorname);
  
}