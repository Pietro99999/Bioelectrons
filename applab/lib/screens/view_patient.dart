import 'package:flutter/material.dart';
import 'package:applab/models/modifypatient.dart';
import 'package:applab/screens/login.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:applab/models/modifypatient.dart';
import 'package:applab/screens/view_patient.dart';
import 'package:provider/provider.dart';
import 'package:applab/screens/patientpage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:applab/utils/impact.dart';
import 'dart:convert'show jsonDecode;
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';


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
        //title: Text('${modpat.newPatient[patientIndex].patients}'),
        actions:<Widget>[ ElevatedButton (child: Text('MODIFY'),
        onPressed: () { Navigator.push(context, MaterialPageRoute(builder: (context) => PatientPage(modpat: modpat, patientIndex: patientIndex,ageIndex: ageIndex)));},
      )],

        ),
      body: Center(
        child: Column( mainAxisAlignment: MainAxisAlignment.center,
          children: [
          Text('Patient: ${modpat.newPatient[patientIndex].patients} '), 
          Text('Age: ${modpat.newPatient[patientIndex].age} '),
          Text('Height: ${modpat.newPatient[patientIndex].height} '),
          Text('Weight: ${modpat.newPatient[patientIndex].weight} '),
          
        ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Text('DATA'),
        onPressed: () async {
                  final result = await _authorize();
                  print(result);
                  final message =
                      result == null ? 'Request failed' : 'Request successful';
                  ScaffoldMessenger.of(context)
                    ..removeCurrentSnackBar()
                    ..showSnackBar(SnackBar(content: Text(message)));
                },
    ));
  }
  
}//PatientPage

//This method allows to obtain the JWT token pair from IMPACT and store it in SharedPreferences
  Future<int?> _authorize() async {

    //Create the request
    final url = Impact.baseUrl + Impact.tokenEndpoint;
    final body = {'username': Impact.username, 'password': Impact.password};

    //Get the response
    print('Calling: $url');
    final response = await http.post(Uri.parse(url), body: body);

    //If 200, set the token
    if (response.statusCode == 200) {
      final decodedResponse = jsonDecode(response.body);
      final sp = await SharedPreferences.getInstance();
      sp.setString('access', decodedResponse['access']);
      sp.setString('refresh', decodedResponse['refresh']);
    } //if

    //Just return the status code 
    return response.statusCode;
  } //_authorize


/*ElevatedButton(
            child: Text('delete patient'),
            onPressed: () {       
              modpat.removePatient(patientIndex); 
              Navigator.pop(context);},//onPressed
          ),*/