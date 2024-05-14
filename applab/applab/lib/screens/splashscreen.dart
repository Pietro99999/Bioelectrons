import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:applab/screens/homepage.dart';

class SplashScreen extends StatefulWidget{
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();


}

class _SplashScreenState extends State<SplashScreen> 
      with SingleTickerProviderStateMixin{
  @override
  void initState(){
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    Future.delayed(Duration(seconds: 2), () {
       Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage(),));
       }
       );
  }  
  

 @override
  void dispose(){
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
      overlays: SystemUiOverlay.values);
    super.dispose();
      
  }

  Widget build(BuildContext context) {    
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