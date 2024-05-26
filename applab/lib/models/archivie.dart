import 'package:applab/models/patientArchieve.dart';
import 'package:flutter/material.dart' ;

// this class contains the varoius doctors asssociated to their list of patient
class Archivie extends ChangeNotifier{

List<dynamic> docpatlista = [];

void addPatient(PatientArchieve listapaz){ //listapaz è un elemento della classe da archiviare
  docpatlista.add(listapaz);
  notifyListeners();
}


}