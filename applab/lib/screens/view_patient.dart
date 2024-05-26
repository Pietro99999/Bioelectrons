import 'package:flutter/material.dart';
import 'package:applab/models/modifypatient.dart';

class PatientHome extends StatelessWidget {
   final int patientIndex;
   final int ageIndex;
   final ModifyPatient modpat;

  //PatientPage constructor
  PatientHome({Key? key, required this.modpat, required this.patientIndex,required this.ageIndex}) : super(key: key);

  static const routeDisplayName = 'PatientPage';
 @override
  Widget build(BuildContext context) {
    print('${PatientHome.routeDisplayName} built');
    return Scaffold(
      appBar: AppBar(
        title: Text(PatientHome.routeDisplayName),
      ),
      body: Center(
        child: Column( 
          children: [
          Text('Patient: ${modpat.newPatient[patientIndex].patients} '),
          ElevatedButton(
          child: Text('To the home'),
          onPressed: () {
            //This allows to go back to the HomePage
            Navigator.pop(context);
          },
        ),
        ],
        ),
      ),
    );
  }
  
}//PatientPage