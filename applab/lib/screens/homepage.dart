import 'package:applab/screens/login.dart';
import 'package:applab/utils/button.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:applab/screens/view_patient.dart';
import 'package:provider/provider.dart';
import 'package:applab/screens/patientpage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:applab/providers/modifypatient.dart';


//Homepage screen
class HomePage extends StatelessWidget {
  //HomePage({Key? key}) : super(key: key);
  String doctorname;
  static const routeDisplayName = 'Doctor';
  HomePage({required this.doctorname});

  @override

  Widget build(BuildContext context){
    //Print the route display name for debugging
    print('${HomePage.routeDisplayName} built');
    
    return Scaffold(
      //HomePage.routeDisplayName
      appBar: AppBar(
        title: Text('Dr. '+doctorname  ,
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
     
      body:Center(
        
        
          child: Consumer<ModifyPatient>(
          builder: (context, modpat, child) {
            

            return modpat.newPatient.isEmpty
                ? RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                    text: 'Press ',
                    style: const TextStyle(color:Color.fromARGB(249, 13, 211, 242), fontWeight: FontWeight.normal, fontSize: 20), 
                    children:  <TextSpan>[ 
                
                    TextSpan(text: 'PLUS ', style: TextStyle(fontWeight: FontWeight.bold ),),
                      TextSpan(text: 'to add a patient', style: TextStyle(fontWeight: FontWeight.normal, )),
               ],
              ),
           )
                : ListView.builder(
                    itemCount: modpat.newPatient.length,
                    itemBuilder: (context, patientIndex) {
                      
                    
                      return Center(
                        child: Column(

                     children:[ 
                      SizedBox(
                        height:10,
                      ),
                      Container(
                        width:double.infinity,
                        height:70,
                      child: Card(
                        elevation: 15,
                        shadowColor: Color.fromARGB(255, 115, 224, 228),
                        color:modpat.newPatient[patientIndex].sex == false ? Color.fromARGB(195, 178, 218, 255): Color.fromRGBO(239, 182, 235, 0.902),
                        child: ListTile(
                          leading: Icon(modpat.newPatient[patientIndex].sex == false ? MdiIcons.faceManProfile: MdiIcons.faceWomanProfile , color: Color.fromRGBO(35, 71, 101, 0.902), ),
                          trailing: Icon(MdiIcons.arrowRight, color: Color.fromRGBO(35, 71, 101, 0.902),),
                          title:
                           RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                    text: 'Patient: ',
                    style: const TextStyle(fontSize: 15, color: Color.fromRGBO(35, 71, 101, 0.902)), 
                    children:  <TextSpan>[ 
                    TextSpan(text: '${modpat.newPatient[patientIndex].patients}', style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold, color: Color.fromRGBO(35, 71, 101, 0.902)), ),
               ],
              ),
           ),    
                          
                          onTap: () => _toPatientHome(context, modpat, patientIndex,ButtonErrorDemo()),
                        ),
                        
                      ),
                      ),
                        ],),
                      );
                       }
                    );
          },
        ),
      ),
      
      floatingActionButton: FloatingActionButton(
        highlightElevation:100,
        backgroundColor:Color.fromARGB(195, 131, 229, 248).withOpacity(0.6),
        child: Icon(MdiIcons.plus, color:Colors.white),
        onPressed: () => _toPatientPage(context, Provider.of<ModifyPatient>(context, listen: false), -1, ButtonErrorDemo()),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
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