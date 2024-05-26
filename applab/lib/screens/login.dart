import 'package:applab/models/archivie.dart';
import 'package:applab/models/doctor.dart';
import 'package:applab/models/listDoctor.dart';
import 'package:applab/models/modifypatient.dart';
import 'package:applab/screens/signin_doctor.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:applab/screens/homepage.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:applab/models/patientArchieve.dart';


class LoginPage extends StatefulWidget {
  LoginPage({Key? key}): super(key:key);
  @override
  _LoginPageState createState() => _LoginPageState();
}//LoginPage


class _LoginPageState extends State<LoginPage>{

  TextEditingController userController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  
  

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
                  ListDoctor listaaa= Provider.of<ListDoctor>(context,listen: false);
                  int ind= listaaa.doctors.length;
                  for (var i = 0; i< ind; i++ ){
                    Doctor element = listaaa.doctors[i];
                    if (i==0){
                      ScaffoldMessenger.of(context)
                    ..removeCurrentSnackBar()
                    ..showSnackBar(SnackBar(content: Text('Wrong email/password')));
                    }
                    if (userController.text == element.email && passwordController.text== element.password){
                      print("ciao");
                      final sharedPreferences = await SharedPreferences.getInstance();
                      await sharedPreferences.setString('USERNAMELOGGED', element.surname);
                      //await sharedPreferences.setBool('DOCTORASSOCIATED', false);
                      int lunghezza = (Provider.of<Archivie>(context, listen: false)).docpatlista.length; //liste delle varie liste pazienti associati a dottori
                      List listanuova= Provider.of<Archivie>(context, listen: false).docpatlista; ////liste delle varie liste pazienti associati a dottori

                      for (var i=0; i<lunghezza; i++ ){
                        PatientArchieve listapazienti= (listanuova[i]); //listapazienti associata a un dottore
                        String? surnamelist= listapazienti.doctorsurname; //cognome dottore nella lista archiviata
                        if (surnamelist == element.surname ){ //se il cognome è già presente nella lista vuol dire che era già loggato: potrebbe avere dei pazienti
                          (Provider.of<ModifyPatient>(context, listen: false)).newPatient= listapazienti.lista; //la lista dei pazienti doventa quella che era in memoria
                        }
                      }
                      Navigator.pushReplacement(
                        context, MaterialPageRoute(builder: (_) => HomePage()));
                    }
                    else{
                      ScaffoldMessenger.of(context)
                    ..removeCurrentSnackBar()
                    ..showSnackBar(SnackBar(content: Text('Wrong email/password')));
                    }
                    

                  }
                
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
          onPressed: ()=> _toSignPage(context, Provider.of<ListDoctor>(context,listen: false)),
          ),

    );
  }//build
  void _toSignPage(BuildContext context, ListDoctor listDoctor){
    Navigator.push(context, MaterialPageRoute(builder: (context) => SignInDoctor(listDoctor: listDoctor,)));
  }

}