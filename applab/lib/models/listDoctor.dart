import 'package:flutter/material.dart';
import 'package:applab/models/doctor.dart';

//Class that contains the varoius doctor that has made login

class ListDoctor extends ChangeNotifier{

  List<Doctor> doctors = [];

  //method to use to add Doctor
  void addDoctor(Doctor newDoctor){
    doctors.add(newDoctor);
    notifyListeners();
  }//addDoctor

 
}