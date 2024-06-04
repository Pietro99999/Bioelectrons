import 'package:applab/screens/data.dart';
import 'package:flutter/material.dart';
import 'package:applab/models/modifypatient.dart';
import 'package:applab/screens/patientpage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:applab/utils/impact.dart';
import 'dart:convert'show jsonDecode;
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:applab/models/steps.dart';


class PatientHome extends StatelessWidget {
   final int patientIndex;
   final ButtonErrorDemo button;
   final ModifyPatient modpat;
   final String day = '2024-04-28';

  //PatientPage constructor
  PatientHome({Key? key, required this.modpat, required this.patientIndex,required this.ageIndex}) : super(key: key);

  static const routeDisplayName = 'PatientPage';
 @override
  Widget build(BuildContext context) {
    print('${PatientHome.routeDisplayName} built');
    return Scaffold(
      appBar: AppBar(
         backgroundColor:   Color.fromARGB(195, 89, 192, 213),
        centerTitle: true,
        title: Text('Patient: ${modpat.newPatient[patientIndex].patients}',
        style: TextStyle(
                        color:  Colors.white,
                        fontStyle: FontStyle.italic,
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold
                        ),
                        
                        
        ),
        actions:<Widget>[ ElevatedButton (style: ButtonStyle(
                   backgroundColor: MaterialStateProperty.all(Color.fromARGB(195, 131, 229, 248).withOpacity(0.6),),), 
                   child: Text('MODIFY',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 15.0,
                       
                ),
                ),
        onPressed: () { Navigator.push(context, MaterialPageRoute(builder: (context) => PatientPage(modpat: modpat, patientIndex: patientIndex,button: button)));},
      )],

        ),
      body: Center(
        child: Column( 
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          Text('Patient: ${modpat.newPatient[patientIndex].patients} '), 
          Text('Age: ${modpat.newPatient[patientIndex].age} '),
          Text('Height: ${modpat.newPatient[patientIndex].height} '),
          Text('Weight: ${modpat.newPatient[patientIndex].weight} '),
          
        ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor:Color.fromARGB(195, 131, 229, 248).withOpacity(0.6),
        child: Text('DATA', 
        style: TextStyle(
                        color: Colors.white,
                        fontSize: 15.0,
                       
                ),
                ),
        onPressed: () async {
                  final result = await _authorize();
                  print(result);
                  final message = result == null ? 'Authorize failed' : 'Authorize successful';
                  ScaffoldMessenger.of(context)
                    ..removeCurrentSnackBar()
                    ..showSnackBar(SnackBar(content: Text(message)));
                   
                  final calories = await _requestCal();     
                  final hr = await _requestHR();
                  final sleep = await _requestSleep(); 
                  final message1 = calories == null ? 'Request failed' : 'Request successful';
                  final timeCal = _splitTime(calories);
                  final valCal = _splitVal(calories);
                  final timeHr = _splitTime(hr);
                  final valHr = _splitVal(hr);
                  
                  ScaffoldMessenger.of(context)
                    ..removeCurrentSnackBar()
                    ..showSnackBar(SnackBar(content: Text(message1))); 
                    Navigator.push(context, MaterialPageRoute(builder: (context) => Data(day: day, timeCal: timeCal, valCal: valCal, timeHr: timeHr, valHr: valHr, sleep: sleep)));
                },
    ));
  }//widget
  
Future<List?> _requestCal() async {
   
    List? result = [];

    //Get the stored access token
    final sp = await SharedPreferences.getInstance();  
    var access = sp.getString('access');

    //If access token is expired, refresh it
    if(JwtDecoder.isExpired(access!)){
      await _refreshTokens();
      access = sp.getString('access');
    }//if

    //Create the request   
    final url = Impact.baseUrl + Impact.caloriesEndpoint + Impact.patientUsername + '/day/$day/';
    final headers = {HttpHeaders.authorizationHeader: 'Bearer $access'};

    //Get the response
    print('Calling: $url');
    
    final response = await http.get(Uri.parse(url), headers: headers);
    print('${response.statusCode}');
    //if OK parse the response, otherwise return null
    if (response.statusCode == 200) {
      final decodedResponse = jsonDecode(response.body);
      for (var i = 0; i < decodedResponse['data']['data'].length; i++) {
        result.add(decodedResponse['data']['data'][i]['time']);
        result.add(decodedResponse['data']['data'][i]['value']);
      }//for
    } //if
    else{
      result = null;
    }//else

    return result;  } //_requestCal

Future<List?> _requestHR() async {
    
    List? result = [];

    //Get the stored access token 
    final sp = await SharedPreferences.getInstance();
    var access = sp.getString('access');

    //If access token is expired, refresh it
    if(JwtDecoder.isExpired(access!)){
      await _refreshTokens();
      access = sp.getString('access');
    }//if

    //Create the request   
    final url = Impact.baseUrl + Impact.heart_rateEndpoint + Impact.patientUsername + '/day/$day/';
    final headers = {HttpHeaders.authorizationHeader: 'Bearer $access'};

    //Get the response
    print('Calling: $url');
    final response = await http.get(Uri.parse(url), headers: headers);
    print('${response.statusCode}');
    //if OK parse the response, otherwise return null
    if (response.statusCode == 200) {
      final decodedResponse = jsonDecode(response.body);
      result = [];
      for (var i = 0; i < decodedResponse['data']['data'].length; i++) {
        result.add(decodedResponse['data']['data'][i]['time']);
        result.add(decodedResponse['data']['data'][i]['value']);
      }//for
    } //if
    else{
      result = null;
    }//else

    return result; } //_requestHR

Future<List?> _requestSleep() async {
   
    List? result = [];
  
    //Get the stored access token 
    final sp = await SharedPreferences.getInstance();
    var access = sp.getString('access');

    //If access token is expired, refresh it
    if(JwtDecoder.isExpired(access!)){
      await _refreshTokens();
      access = sp.getString('access');
    }//if

    //Create the request   
    final url = Impact.baseUrl + Impact.sleepEndpoint + Impact.patientUsername + '/day/$day/';
    final headers = {HttpHeaders.authorizationHeader: 'Bearer $access'};

    //Get the response
    print('Calling: $url');
    final response = await http.get(Uri.parse(url), headers: headers);
    print('${response.statusCode}');
    //if OK parse the response, otherwise return null
    if (response.statusCode == 200) {
      final decodedResponse = jsonDecode(response.body);    
      result.add(decodedResponse['data']['data']['minutesAsleep']);
      result.add(decodedResponse['data']['data']['minutesToFallAsleep']);
      result.add(decodedResponse['data']['data']['efficiency']);
      }//if
    
    else{
      result = null;
    }//else
  
    return result;  } //_requestSleep

}//PatientPage


List? _splitTime(List? lista){
  List? time = [];
  int l = lista!.length;
    for (int i = 0; i < l; i=i+2){ 
      time.add(lista[i]);
    }//for
    print('numero tempi: $l');
    return (time);
    }//_splitTime

List? _splitVal(List? lista){
  List? val = [];
  int l =lista!.length;
    for (int i = 1; i < l; i=i+2){
      val.add(lista[i]);
    }//for
    print('numero valori: $l');
    return (val);
    }//_splitVal


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

  Future<int> _refreshTokens() async {

    //Create the request
    final url = Impact.baseUrl + Impact.refreshEndpoint;
    final sp = await SharedPreferences.getInstance();
    final refresh = sp.getString('refresh');
    final body = {'refresh': refresh};

    //Get the respone
    print('Calling: $url');
    final response = await http.post(Uri.parse(url), body: body);

    //If 200 set the tokens
    if (response.statusCode == 200) {
      final decodedResponse = jsonDecode(response.body);
      final sp = await SharedPreferences.getInstance();
      sp.setString('access', decodedResponse['access']);
      sp.setString('refresh', decodedResponse['refresh']);
    } //if

    //Return just the status code
    return response.statusCode;

  } //_refreshTokens

