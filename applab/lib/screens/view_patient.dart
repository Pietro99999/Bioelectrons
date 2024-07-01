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
import 'package:applab/utils/button.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:applab/models/indexlistona.dart';



class PatientHome extends StatelessWidget {
   final int patientIndex;
   final ButtonErrorDemo button;
   final ModifyPatient modpat;
   final String day = '2023-04-27'; 
//GIORNI INTERESSANTI:
//2024-04-23 i dati sleep richiedono [0] e dorme poco perchè va a letto a mezzanotte (348 minuti)
//2024/04/26 due eventi ma uno breve. UN EVENTO SEGNALATO    BELLO COME SEMPIO
//2024/04/28 no eventi
//2024/05/30 due eventi ma brevi
//2024/05/29 due eventi DUE EVENTI SEGNALATI
//2024/12/25 NO data
//dal 2023/11/30  al 2024/02/09 non ci sono dati 
//2023/08/15 NO dati sleep
//2023-04-27 è andato a letto dopo mezzanotte. UN EVENTO

  //PatientPage constructor
  PatientHome({Key? key, required this.modpat, required this.patientIndex,required this.button}) : super(key: key);

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
                        ),),
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
      body: ListView(
        padding: EdgeInsets.zero,
        children:<Widget>[
           Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.center,
            children: [
              Container(
                color:  modpat.newPatient[patientIndex].sex == false ? Color.fromARGB(195, 131, 229, 248).withOpacity(0.6):Color.fromARGB(240, 250, 185, 241).withOpacity(0.6),
                height: 180,
                width: double.infinity,
              ),
              Positioned(
                top: 180 - 160 / 2,
                child: CircleAvatar(
                  radius: 160 / 2,
                  backgroundColor:
                      Color.fromARGB(195, 131, 229, 248).withOpacity(0.6),
                  backgroundImage: AssetImage(
                      modpat.newPatient[patientIndex].sex == false
                          ? 'assets/m.png'
                          : 'assets/w.png'),
                ),
              ),
            ]
            ),
     Container(
      padding: EdgeInsets.symmetric(horizontal: 50, vertical: 50),
      child: Column(
      children: [
                  const SizedBox(height:40),
                  Text('${modpat.newPatient[patientIndex].patients}',  style: TextStyle(fontSize: 22,color: modpat.newPatient[patientIndex].sex == false ? Color.fromARGB(195, 13, 194, 231).withOpacity(0.6):Color.fromARGB(239, 208, 17, 183).withOpacity(0.6), fontWeight: FontWeight.bold ),), 
                  
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                    text: 'Age: ',
                    style: const TextStyle(fontSize: 18, color: Color.fromARGB(255, 1, 22, 39),fontWeight: FontWeight.bold), 
                    children:  <TextSpan>[ 
                    TextSpan(text: '${modpat.newPatient[patientIndex].age}', style: TextStyle(fontWeight: FontWeight.normal, color: const Color.fromARGB(255, 12, 31, 46)), ),
               ],
              ),
           ),
            
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                    text: 'Height: ',
                    style: const TextStyle(fontSize: 18, color: Color.fromARGB(255, 1, 22, 39),fontWeight: FontWeight.bold), 
                    children:  <TextSpan>[ 
                    TextSpan(text: '${modpat.newPatient[patientIndex].height}', style: TextStyle(fontWeight: FontWeight.normal, color: const Color.fromARGB(255, 12, 31, 46)), ),
               ],
              ),
           ),
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                    text: 'Weight: ',
                    style: const TextStyle(fontSize: 18, color: Color.fromARGB(255, 1, 22, 39),fontWeight: FontWeight.bold), 
                    children:  <TextSpan>[ 
                    TextSpan(text: '${modpat.newPatient[patientIndex].weight} ', style: TextStyle(fontWeight: FontWeight.normal, color: const Color.fromARGB(255, 12, 31, 46)), ),
               ],
              ),
           ),
                
                 RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                    text: 'Sex: ',
                    style: const TextStyle(fontSize: 18, color: Color.fromARGB(255, 1, 22, 39),fontWeight: FontWeight.bold), 
                    children:  <TextSpan>[ 
                    TextSpan(text: '${modpat.newPatient[patientIndex].sex == false ? 'Male' : 'Female'}  ', style: TextStyle(fontWeight: FontWeight.normal, color: const Color.fromARGB(255, 12, 31, 46)), ),
               ],
              ),
           ),
                
                ],
      
      ),
     ),

        ],
      ),


      floatingActionButton: FloatingActionButton(
        backgroundColor:Color.fromARGB(195, 131, 229, 248).withOpacity(0.6),
        child: Text('DATA', 
        style: TextStyle(
                        color: Colors.white,
                        fontSize: 15.0,                       
                ),),
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
                  //DATA ELABORATION
                  num sumCal =0;
                  for (int i=0; i<timeCal!.length; i++){                 
                    double valore = double.parse(valCal?[i]);
                    sumCal = sumCal+valore;
                  }//for
                  print('sumCal = $sumCal');

                  if(sleep?[3]!=0){
                    String midnight_string = '24:00:00';
                    String newString = sleep?[3].substring(6);
                    DateFormat format = DateFormat("HH:mm:ss");
                    DateTime midnight = format.parse(midnight_string);
                    DateTime dateTime = format.parse(newString);
                    print('midnight $midnight');
                    print('new DateTime $dateTime');
                    Duration difference = midnight.difference(dateTime);
                    print('duration = $difference');
                    if(difference<Duration(hours: 5)){
                    int inMinutes = difference.inMinutes;
                    print('difference in minutes = $inMinutes');
                    sleep?[0]=sleep?[0]+inMinutes; //totale minuti dormiti quella notte
                    print('new sleep = $sleep');
                    }else{
                      print('è andato a letto dopo mezzanotte quindi non ho minuti da sommare');
                    }//else
                  }//if                  

                  if ((sumCal!=0)&&(valHr?[0]!=0)&&(sleep?[0]!=0)){
                  List listona = [];
                  List<int> indici = [];
                  bool droga = false;
                  if (sumCal>2500){ //first trigger VALORE APPOSITAMENTE BASSO
                  if (sleep?[0]<1000){ //second trigger VALORE APPOSITAMENTE ELEVATO
                    for (int i=0; i<timeHr!.length; i++ ){
                      if (valHr?[i]>140){ //third trigger
                        droga=true;
                        indici.add(i);
                      }//if hr>140
                      else{
                        if(droga==true){
                          listona.add(indici);                          
                          indici = [];//svuoto la lista indici 
                          droga=false;
                        }//if droga==true
                      }//else hr>140
                    };//for
                  }//if sleep
                  }//if calories
                  print('lunghezza listona = ${listona.length}');     
                  //se i periodi in cui hr>140 sono più vicini di 1 ora (720 campioni) 
                  //tra loro allora voglio che vengano considerati come un singolo evento             
                  for (int i=(listona.length-1); i>0; i--){
                    if ((listona[i][0]-listona[i-1][listona[i-1].length-1])<720){ //720=12*60
                      listona[i-1].addAll(listona[i]);
                      listona.removeAt(i);
                    };//if
                  };//for
                  print('unisco gli eventi ravvicinati:');
                  print('lunghezza new listona = ${listona.length}');
                  //se un evento non è vicino ad altri eventi ed è di durata
                  //inferiore ai 15 minuti (15*12=180) lo elimino da listona perchè
                  //può essere dovuto a cause non legate all'assunzione di cocaina 
                  for (int i=(listona.length-1); i>=0; i--){
                    if (listona[i].length<30){
                      listona.removeAt(i);                      
                    };//if
                  };//for
                  print ('elimino gli eventi isolati e di breve durata:');
                  print('lunghezza new listona = ${listona.length}');
                  print('new listona $listona');

                  listona = _addBefore(listona);
                  listona = _addAfter(listona);
                  //print('listona add = $listona');
                   int lunghezza= listona.length;
                  int primoindice; 
                  if (lunghezza != 0){
                    
                    int firstindex= (listona[(Provider.of<IndexListona>(context, listen: false)).i])[0];
                    Provider.of<IndexListona>(context,listen:false).modifyprimoindex(firstindex);
                  }
                 
                  print(Provider.of<IndexListona>(context,listen:false).primoindice);
                   Navigator.push(context, MaterialPageRoute(builder: (context) => Data(day: day, timeCal: timeCal, valCal: valCal, timeHr: timeHr, valHr: valHr, sleep: sleep, listona: listona, times: lunghezza, data: day, calories: sumCal.floor(), sleeping:sleep?[0])));
                  }//se abbiamo tutti i dati
                  else{
                     String messaggio = 'For the selected day there is not enough data available to provide an accurate answer';
                     ScaffoldMessenger.of(context)
                    ..removeCurrentSnackBar()
                    ..showSnackBar(SnackBar(content: Text(messaggio)));                   
                  }//se non abbiamo dati sufficienti 
                },//build
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
    //if OK parse the response
    if (response.statusCode == 200) {
      final decodedResponse = jsonDecode(response.body);
      //print(decodedResponse['data']);
      if (decodedResponse['data'].length!=0){      
      for (var i = 0; i < decodedResponse['data']['data'].length; i++) {  
        result.add(decodedResponse['data']['data'][i]['time']);
        result.add(decodedResponse['data']['data'][i]['value']);
      }//for
      }else{
       result.add('0');
       result.add('0');
       print ('calories data no available --> $result'); 
      }
    } //if
    else{
      result.add('0');
      result.add('0');
      print ('Error 400 calories data no available --> $result');
    }//else

    return result; } //_requestCal


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
    //if OK parse the response
    if (response.statusCode == 200) {
      final decodedResponse = jsonDecode(response.body);
      print(decodedResponse['data']);
      if (decodedResponse['data'].length!=0){ 
      for (var i = 0; i < decodedResponse['data']['data'].length; i++) { 
        result.add(decodedResponse['data']['data'][i]['time']);
        result.add(decodedResponse['data']['data'][i]['value']);
      }//for
      }else{
       result.add('0');
       result.add('0');
       print ('HR data no available --> $result'); 
      }
    } //if
    else{
      result.add('0');
      result.add('0');
      print ('Error 400 HR data no available --> $result');
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
    //if OK parse the response
    if (response.statusCode == 200) {
      final decodedResponse = jsonDecode(response.body);    
      //print(decodedResponse['data']); 
      if (decodedResponse['data'].length!=0){     
      try {result.add(decodedResponse['data']['data']['minutesAsleep']); }
      catch (e){result.add(decodedResponse['data']['data'][0]['minutesAsleep']);}
      try {result.add(decodedResponse['data']['data']['minutesToFallAsleep']); }
      catch (e){result.add(decodedResponse['data']['data'][0]['minutesToFallAsleep']);}
      try {result.add(decodedResponse['data']['data']['efficiency']); }
      catch (e){result.add(decodedResponse['data']['data'][0]['efficiency']);} 
      try {result.add(decodedResponse['data']['data']['levels']['data'][0]['dateTime']); }
      catch (e){result.add(decodedResponse['data']['data'][0]['levels']['data'][0]['dateTime']);}
      }//if    
      else{
       result.add(0);
       result.add(0);
       result.add(0);
       result.add(0);
       print ('sleep data no available --> $result'); 
      }}//if
    else{
      result.add(0);
      result.add(0);
      result.add(0);
      result.add(0);
      print ('Error 400 sleep data no available --> $result');
    }//else  
    print('sleep= $result');
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
      //val.add(int.parse(lista[i]) );
      val.add(lista[i]);
    }//for
    print('numero valori: $l');
    return (val);
    }//_splitVal

List _addBefore(List listona){
  for (int i=0; i<listona.length; i++){
    for (int j=0; j<120; j++){ //12*10=120
      listona[i].insert(0,listona[i][0]-1);
    }
  }
  return(listona);
}

List _addAfter(List listona){
  for (int i=0; i<listona.length; i++){
    for (int j=0; j<120; j++){ //12*10=120
      listona[i].add(listona[i][listona[i].length-1]+1);
    }
  }
  return(listona);
}

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