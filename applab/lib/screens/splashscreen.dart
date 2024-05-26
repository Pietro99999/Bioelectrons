import 'package:applab/screens/login.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatelessWidget{
  const SplashScreen({super.key});

  void _checkLogin(BuildContext context) async {
     SharedPreferences login = await SharedPreferences.getInstance();
     if (login.getBool('isUserLogged') !=null){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage(),));
     }
     else{
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage(),));
     }
    
  } //_checkLogin

  @override
  Widget build(BuildContext context) {    
    Future.delayed(const Duration(seconds: 3), () => _checkLogin(context)); 
    return Scaffold(
      body: Container(
        width:double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(colors: [Color.fromARGB(255, 8, 108, 190), Color.fromARGB(255, 39, 150, 241)], 
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,      
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 20,
          ),
          Text('FreeToLive',
          style: TextStyle(
            fontStyle: FontStyle.italic,
            color: Colors.white,
            fontSize: 31,
          )),
        ],)
      )
    );
}
}