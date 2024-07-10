import 'package:applab/models/doctor.dart';
import 'package:applab/models/patientdatabase.dart';
import 'package:applab/screens/signin_doctor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:applab/screens/homepage.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:applab/models/doctordatabase.dart';
import 'package:hive/hive.dart';
import 'package:applab/models/patient.dart';
import 'package:applab/providers/indexlistona.dart';
import 'package:applab/providers/modifypatient.dart';



class LoginPage extends StatefulWidget {
  LoginPage({Key? key}): super(key:key);
  @override
  _LoginPageState createState() => _LoginPageState();
}//LoginPage


class _LoginPageState extends State<LoginPage>{

  TextEditingController userController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final Box<Doctordatabase> databaseBox= Hive.box<Doctordatabase>('doctors');
  final Box<Patientdatabase> patientdatabase1= Hive.box<Patientdatabase>('patients');
 
  List _getUsers(){
   // List<dynamic>? listdoc= databaseBox.get('listadottori')?.cast<dynamic>();
  Iterable<Doctordatabase> dottiriii= databaseBox.values;
  print(databaseBox.values);
  List listadoctors= dottiriii.toList();
  return listadoctors;
  }

  List _getPatients(){
    Iterable<Patientdatabase>pazientiii = patientdatabase1.values;
    List listapatients= pazientiii.toList();
    return listapatients;
  }


  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:SingleChildScrollView( 
        child: Column(
         // mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Stack(
                children: [ 
                    Container(
                      height: 250,
                      color:  Color.fromRGBO(36, 208, 220, 1),
                    ),
                    Positioned(
                      top: -100,
                      left: -100,
                      child:
                      Container(
                        height:200,
                        width:200,
                        child: DecoratedBox(decoration: 
                        BoxDecoration(
                          shape: BoxShape.circle, color: Color.fromARGB(195, 131, 229, 248).withOpacity(0.6)
                        )
                        ),
                        )
                        ),
                    Positioned(
                        top: -100,
                        right: -100,
                        child:
                        Container(
                          height:200,
                          width:200,
                          child: DecoratedBox(decoration: 
                          BoxDecoration(
                             shape: BoxShape.circle, color: Color.fromARGB(195, 131, 229, 248).withOpacity(0.6)
                          )),
                          )
                          ),
                          Positioned(
                        top:100,
                        left: 90,
                        child: Text('Coke Free',style: TextStyle(
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                        fontSize: 51,))),
                        Positioned(
                        top:165,
                        left: 75,
                        child: Text('Doctor\'s ally against cocaine abuse',style: TextStyle(
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.w400,
                        color: Colors.white.withOpacity(0.9),
                        fontSize: 16,))),
                    Positioned(
                        top:200,
                        left: 120,
                        child: Text('Login Page',style: TextStyle(
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.w300,
                        color: Colors.white,
                        fontSize: 31,)))
                      ]
                  ),
            ClipPath(
             clipper: OvalBottomBorderClipper(),
              child: Container(height:50,
             
              color:  Color.fromRGBO(36, 208, 220, 1),
            ),
            ),
            SizedBox(
              height: 50,
            ),
            
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                controller: userController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Email',
                    hintText: 'Enter valid email id as abc@gmail.com'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 15, bottom: 15),
              child: 
              TextField(
                obscureText: true,
                controller: passwordController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Password',
                    hintText: 'Enter password'),
              ),
            ),
            Container(
              height: 50,
              width: 250,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
              child: ElevatedButton( 
                onPressed: () async{
                  List<dynamic> listanow= _getUsers();
                 int ind = listanow.length;

                   if (ind==0){
                      // No users in the database
                      ScaffoldMessenger.of(context)
                    ..removeCurrentSnackBar()
                    ..showSnackBar(SnackBar(
                    content: Text( 
                     'Wrong email/password', 
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Color.fromARGB(255, 219, 22, 8),fontWeight:FontWeight.bold, fontSize: 16)),
                     backgroundColor:  Color.fromRGBO(36, 208, 220, 1),)
                      );
                    }

                    bool access=false;

                  for (var i = 0; i< ind; i++ ){
                    //Doctor element = listaaa.doctors[i];
                    
                    Doctordatabase element= listanow[i]; //controllo ogni elemento del database dottori
                    print(listanow[i] );
                  

                    if (userController.text == element.email && passwordController.text== element.password){ //controllo che sia già presente nel database
                      print("Accesso Consentito");
                      final sharedPreferences = await SharedPreferences.getInstance();
                      await sharedPreferences.setString('USERNAMELOGGED', element.surname);
                      String surnamedoctor = element.surname;
                      List<dynamic> pazientinow=_getPatients();
                      int numeropat=pazientinow.length;
                      List<dynamic> listaprovvisoria=[];
                      for (var k=0; k<numeropat; k++){
                        Patientdatabase paziente= pazientinow[k];
                        if(paziente.doctorname == element.surname){//il dottore ha già un databse
                          Patients pazientegiaiscritto = Patients(patients: paziente.patients, age: paziente.age, weight: paziente.weight, height: paziente.height,sex:paziente.sex, year:paziente.year, grav : paziente.grav, treatm: paziente.treatm, drug: paziente.drug);
                          listaprovvisoria.add(pazientegiaiscritto);
                         }
                      }

                      (Provider.of<ModifyPatient>(context, listen: false)).newPatient=listaprovvisoria;
                      Navigator.pushReplacement(
                        context, MaterialPageRoute(builder: (_) => HomePage(doctorname: surnamedoctor,)));
                        access= true;
                       break;
         
                    }
                  
                  }
                     
                 // If wrong mail or password error
                    
                  if(access!=true){
  
                   ScaffoldMessenger.of(context)
                    ..removeCurrentSnackBar()
                    ..showSnackBar(SnackBar(
                    content: Text( 
                      textAlign: TextAlign.center,'Wrong email/password', 
                      style: TextStyle(color: Color.fromARGB(255, 219, 22, 8),fontWeight:FontWeight.bold, fontSize: 16)),
                     backgroundColor:  Color.fromRGBO(36, 208, 220, 1), )
                     );
                  }
                
                },

                
                style: ButtonStyle(
                   backgroundColor: MaterialStateProperty.all(Color.fromARGB(195, 131, 229, 248).withOpacity(0.6),),
                  
               
              overlayColor: MaterialStateProperty.resolveWith((states){
                if(states.contains(MaterialState.pressed)){
                return Color.fromARGB(255, 140, 183, 218);
                }
              },
              ),
             ),

                child: Text(
                  'Login',
                  style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                       
                ),
                  
                ),
                
              ),


            ),

           SizedBox(
              height: 20,
            ),
  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                    text: 'If you don\'t have an account yet please ',
                    style: const TextStyle(fontSize:17,color: Color.fromRGBO(36, 208, 220, 1),), 
                    children:  <TextSpan>[ 
                    TextSpan(text:'SIGN UP', style: TextStyle(fontWeight: FontWeight.bold) ),
               ],
              ),
           ),
           
           SizedBox(
              height: 10,
            ),
         Container(
              height: 50,
              width: 250,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
             child: ElevatedButton(
                onPressed: () => _toSignPage(context), //, Provider.of<ListDoctor>(context,listen: false)//),
                style: ButtonStyle(
                   backgroundColor: MaterialStateProperty.all(Color.fromARGB(195, 131, 229, 248).withOpacity(0.6),),
                  
               
              overlayColor: MaterialStateProperty.resolveWith((states){
                if(states.contains(MaterialState.pressed)){
                return Color.fromARGB(255, 140, 183, 218);
                }
              },
              ),
             ),

                child: const Text(
                  'Sign up',
                  style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                       
                ),
                  
                ),
          

              ),
          ),
          SizedBox(height:40),
          Center(
                   child:Image.asset('assets/logo2.png',scale:3.5,),
                    ),
          SizedBox(height:8),
          Text('from BIOELECTRONS',style:TextStyle( color:Color.fromARGB(255, 120, 144, 144), fontSize: 12,),),      
              
              
              
          ],
        ),
      ),
      

      /*
        floatingActionButton: FloatingActionButton(
          backgroundColor:Color.fromARGB(195, 131, 229, 248).withOpacity(0.6),
          child: Icon(MdiIcons.plus, color: Colors.white,),
          onPressed: ()=> _toSignPage(context) //, Provider.of<ListDoctor>(context,listen: false)//),
          ), */

    );
  }//build
  void _toSignPage(BuildContext context){
    Navigator.push(context, MaterialPageRoute(builder: (context) => SignInDoctor()));
  }

}