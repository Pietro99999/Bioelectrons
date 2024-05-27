import 'package:applab/models/doctor.dart';
import 'package:applab/models/modifypatient.dart';
import 'package:applab/models/patientdatabase.dart';
import 'package:applab/screens/signin_doctor.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:applab/screens/homepage.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:applab/models/doctordatabase.dart';
import 'package:hive/hive.dart';
import 'package:applab/models/patient.dart';
import 'package:applab/models/modifypatient.dart';


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
                      color: const Color.fromARGB(255, 16, 106, 180),
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
                          shape: BoxShape.circle, color: Color.fromARGB(195, 147, 181, 208)
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
                            shape: BoxShape.circle, color: Color.fromARGB(255, 16, 106, 180),
                          )),
                          )
                          ),
                    Positioned(
                        top:200,
                        left: 120,
                        child: Text('Login Page',style: TextStyle(
                        fontStyle: FontStyle.normal,
                        color: Colors.white,
                        fontSize: 31,)))
                      ]
                  ),
            ClipPath(
             clipper: OvalBottomBorderClipper(),
              child: Container(height:50,
              color: Color.fromARGB(255, 16, 106, 180),
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
                  for (var i = 0; i< ind; i++ ){
                    //Doctor element = listaaa.doctors[i];
                    Doctordatabase element= listanow[i]; //controllo ogni elemento del database dottori
                    if (ind==0){
                      ScaffoldMessenger.of(context)
                    ..removeCurrentSnackBar()
                    ..showSnackBar(SnackBar(content: Text('Wrong email/password')));
                    }
                    if (userController.text == element.email && passwordController.text== element.password){ //controllo che sia già presente nel database
                      print("ciao");
                      final sharedPreferences = await SharedPreferences.getInstance();
                      await sharedPreferences.setString('USERNAMELOGGED', element.surname);

                      List<dynamic> pazientinow=_getPatients();
                      int numeropat=pazientinow.length;
                      List<dynamic> listaprovvisoria=[];
                      for (var k=0; k<numeropat; k++){
                        Patientdatabase paziente= pazientinow[k];
                        if(paziente.doctorname == element.surname){//il dottore ha già un databse
                          Patients pazientegiaiscritto = Patients(patients: paziente.patients, age: paziente.age, weight: paziente.weight, height: paziente.height);
                          listaprovvisoria.add(pazientegiaiscritto);
                        }
                      }
                      (Provider.of<ModifyPatient>(context, listen: false)).newPatient=listaprovvisoria;
                      Navigator.pushReplacement(
                        context, MaterialPageRoute(builder: (_) => HomePage()));
                    }
                   // else{
                     // ScaffoldMessenger.of(context)
                    //..removeCurrentSnackBar()
                    //..showSnackBar(SnackBar(content: Text('Wrong email/password')));
                    //}
                  }
               //   ScaffoldMessenger.of(context)
                 //   ..removeCurrentSnackBar();
                 //   ..showSnackBar(SnackBar(content: Text('Wrong email/password')));
                
                },
                child: Text(
                  'Login',
                ),
              ),


            ),

           SizedBox(
              height: 130,
            ),
          ],
        ),
      ),
        floatingActionButton: FloatingActionButton(
          child: Icon(MdiIcons.plus),
          onPressed: ()=> _toSignPage(context) //, Provider.of<ListDoctor>(context,listen: false)//),
          ),

    );
  }//build
  void _toSignPage(BuildContext context){
    Navigator.push(context, MaterialPageRoute(builder: (context) => SignInDoctor()));
  }

}