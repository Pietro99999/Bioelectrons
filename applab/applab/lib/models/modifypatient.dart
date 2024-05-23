import 'package:flutter/material.dart' ;
import 'package:prova_homepagepaz/models/patient.dart';


class ModifyPatient extends ChangeNotifier{
List<Patients> newPatient = [];
//Map<Patients, Patients> newPatientcomplete = new Map();
void addPatient(Patients pat){
  newPatient.add(pat);
  notifyListeners();
} //addProduct --> aggiungo 

void removePatient(int index){
  newPatient.removeAt(index);
  notifyListeners();
} //removePatient --> rimuove il paziente

 //Method to use to edit a patient.
  void editPatient(int index, Patients newPat){
   newPatient[index] = newPat;
    //Call the notifyListeners() method to alert that something happened.
    notifyListeners();
  }//modifyPatient

}//ModifyPatient
