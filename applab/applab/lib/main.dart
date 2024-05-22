import 'package:applab/screens/splashscreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:prova_homepagepaz/screens/homepage.dart';
import 'package:prova_homepagepaz/models/modifypatient.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //This specifies the app entrypoint
      home: SplashScreen(),
    );
  } //build
}//MyApp


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    //Here we are injecting an instance of the MealDB thorugh the widget tree
    return ChangeNotifierProvider<ModifyPatient>(
      create: (context) => ModifyPatient(),
      child: MaterialApp(
        //This specifies the entrypoint
        home: HomePage(),
      ),
    );
  } //build
} //MyApp