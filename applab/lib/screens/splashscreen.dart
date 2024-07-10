import 'package:applab/screens/login.dart';
import 'package:flutter/material.dart';


class SplashScreen extends StatelessWidget{
  const SplashScreen({super.key});

  void _checkLogin(BuildContext context) async {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage(),));
     
    } //_checkLogin

  @override
 
Widget build(BuildContext context) {    
    Future.delayed(const Duration(seconds: 3), () => _checkLogin(context)); 
    return Scaffold(
      body: Center(child: Image.asset('assets/logo1.png',width: double.infinity, height: double.infinity, fit: BoxFit.cover,),)
    );
    }//build
    
}//splashscreen