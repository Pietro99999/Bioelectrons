import 'package:applab/screens/login.dart';
import 'package:applab/utils/button.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:applab/models/modifypatient.dart';
import 'package:applab/screens/view_patient.dart';
import 'package:provider/provider.dart';
import 'package:applab/screens/patientpage.dart';
import 'package:shared_preferences/shared_preferences.dart';

//Homepage screen
class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  static const routeDisplayName = 'Doctor';

  
  Widget build(BuildContext context){
    //Print the route display name for debugging
    print('${HomePage.routeDisplayName} built');
    
    return Scaffold(
      //HomePage.routeDisplayName
      appBar: AppBar(
        title: Text('Doctor '  ,
        style: TextStyle(
                        color:  Colors.white,
                        fontStyle: FontStyle.italic,
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold
                        ),
                        ),

        backgroundColor:  Color.fromARGB(195, 89, 192, 213),
        centerTitle: true,
        actions: [IconButton(onPressed: ()=> _logout(context), icon: Icon(Icons.logout,color:  Colors.white,), color:Color.fromARGB(195, 131, 229, 248).withOpacity(0.6),)

        ],
      ),
     
      body: Center(
        
          child: Consumer<ModifyPatient>(
          builder: (context, modpat, child) {

            return modpat.newPatient.isEmpty
                ? Text('The patient list is currently empty')
                : ListView.builder(
                    itemCount: modpat.newPatient.length,
                    itemBuilder: (context, patientIndex) {
                      
                     
                      return Card(
                        elevation: 5,
                        color:Color.fromARGB(195, 178, 218, 255),
                        child: ListTile(
                          leading: Icon(MdiIcons.faceManProfile, color: Color.fromRGBO(35, 71, 101, 0.902),), 
                          trailing: Icon(MdiIcons.arrowRight, color: Color.fromRGBO(35, 71, 101, 0.902),),
                          title:
                              Text('Patient : ${modpat.newPatient[patientIndex].patients}',
                         style: TextStyle(
                            color: Color.fromRGBO(35, 71, 101, 0.902),
                            fontSize: 15.0,
                        
                        ),
                        ),
                              
                              
                              
                          
                          onTap: () => _toPatientHome(context, modpat, patientIndex,ButtonErrorDemo()),
                        ),
                      );
                    });
          },
        ),
      ),
      
      floatingActionButton: FloatingActionButton(
        backgroundColor:Color.fromARGB(195, 131, 229, 248).withOpacity(0.6),
        child: Icon(MdiIcons.plus, color:Colors.white),
        onPressed: () => _toPatientPage(context, Provider.of<ModifyPatient>(context, listen: false), -1, ButtonErrorDemo()),
      ),
    );
  } //build

  //Utility method to navigate to PatientPage
  void _toPatientPage(BuildContext context,   modpat, int patientIndex, ButtonErrorDemo button) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => PatientPage(modpat: modpat, patientIndex: patientIndex,button: button)));
  } //_toPatientPage

  
void _toPatientHome(BuildContext context,   modpat, int patientIndex, ButtonErrorDemo button) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => PatientHome(modpat: modpat, patientIndex: patientIndex,button: button )));
  } //_toPatientHome

void _logout(BuildContext context)async{

    final prefs= await SharedPreferences.getInstance();
    final doctorsurname= prefs.getString('USERNAMELOGGED');
    await prefs.remove('USERNAMELOGGED');
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => LoginPage()));


}

} //HomePage