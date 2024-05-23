import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:prova_homepagepaz/models/modifypatient.dart';
import 'package:prova_homepagepaz/screens/view_patient.dart';
import 'package:provider/provider.dart';
import 'package:prova_homepagepaz/screens/patientpage.dart';

//Homepage screen
class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  static const routeDisplayName = 'Home Page';

  @override
  Widget build(BuildContext context) {
    //Print the route display name for debugging
    print('${HomePage.routeDisplayName} built');
    
    return Scaffold(
      appBar: AppBar(
        title: Text(HomePage.routeDisplayName),
      ),
      body: Center(
        //Here we are using a Consumer because we want the UI showing 
        //the list of patient to rebuild every time the modify patient updates.
        child: Consumer<ModifyPatient>(
          builder: (context, modpat, child) {
            //If the list of patient is empty, show a simple Text, otherwise show the list of patient using a ListView.
            return modpat.newPatient.isEmpty
                ? Text('The patient list is currently empty')
                : ListView.builder(
                    itemCount: modpat.newPatient.length,
                    itemBuilder: (context, patientIndex) {
                      
                      //We are using the Card widget to wrap each ListTile to make the UI prettier;
                      //Improving UI/UX adding a leading and a trailing to the ListTile
                      return Card(
                        elevation: 5,
                        child: ListTile(
                          leading: Icon(MdiIcons.faceManProfile), 
                          trailing: Icon(MdiIcons.arrowRight),
                          title:
                              Text('Patient : ${modpat.newPatient[patientIndex].patients}'),
                          
                          //When a ListTile is tapped, the user is redirected to the PatientPage, where it will be able to edit it.
                          onTap: () => _toPatientHome(context, modpat, patientIndex, 0),
                        ),
                      );
                    });
          },
        ),
      ),
      //Here, I'm using a FAB to let the user add new patients.
      //Rationale: I'm using -1 as patientIndex to let PatientPage know that we want to add a new patient.
      floatingActionButton: FloatingActionButton(
        child: Icon(MdiIcons.plus),
        onPressed: () => _toPatientPage(context, Provider.of<ModifyPatient>(context, listen: false), -1,-1),
      ),
    );
  } //build

  //Utility method to navigate to PatientPage
  void _toPatientPage(BuildContext context,   modpat, int patientIndex, int ageIndex) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => PatientPage(modpat: modpat, patientIndex: patientIndex,ageIndex: ageIndex)));
  } //_toPatientPage

  
void _toPatientHome(BuildContext context,   modpat, int patientIndex, int ageIndex) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => PatientHome(modpat: modpat, patientIndex: patientIndex, ageIndex: ageIndex)));
  } //_toPatientHome

} //HomePage
