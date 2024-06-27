import 'package:applab/models/doctordatabase.dart';
import 'package:applab/models/modifypatient.dart';
import 'package:applab/screens/splashscreen.dart';
//import 'package:applab/utils/plotCal.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
//import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:applab/models/patientdatabase.dart';

void main() async{

  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  Hive.registerAdapter(DoctordatabaseAdapter());
  Hive.registerAdapter(PatientdatabaseAdapter());

  //open a box 
  var box1 = await Hive.openBox<Doctordatabase>('doctors');
  var box2 = await Hive.openBox<Patientdatabase>('patients');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: 
    [
    ChangeNotifierProvider(create: (context)=> ModifyPatient()),
    ],
    
  
      child: MaterialApp(
        home: SplashScreen(),
      ),);
   // return MaterialApp(
      //This specifies the app entrypoint
      //home: SplashScreen(),
    //);
  } //build
}//MyApp