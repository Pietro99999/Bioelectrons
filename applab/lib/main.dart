import 'package:applab/models/archivie.dart';
import 'package:applab/models/listDoctor.dart';
import 'package:applab/models/modifypatient.dart';
import 'package:applab/screens/splashscreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: 
    [ChangeNotifierProvider(create: (context)=> ListDoctor()),
    ChangeNotifierProvider(create: (context)=> ModifyPatient()),
    ChangeNotifierProvider(create: (context)=> Archivie()),
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