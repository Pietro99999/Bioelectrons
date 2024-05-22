import 'package:prova_homepagepaz/models/modifypatient.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:prova_homepagepaz/models/patient.dart';
import 'package:prova_homepagepaz/utils/format.dart';

class PatientPage extends StatefulWidget {
    final int patientIndex;
    final int ageIndex;
    final ModifyPatient modpat;

  //PatientPage constructor
  PatientPage({Key? key, required this.modpat, required this.patientIndex,required this.ageIndex}) : super(key: key);

  static const routeDisplayName = 'Patient Page';
  
  @override
 State<PatientPage> createState() => _PatientPage();
  
}//PatientPage

class _PatientPage extends State<PatientPage> {

  final formKey = GlobalKey<FormState>();

  //Variables that maintain the current form fields values in memory.
  TextEditingController _choControllername = TextEditingController();
  TextEditingController _choControllerage = TextEditingController();
  TextEditingController _choControllerweight = TextEditingController();
  TextEditingController _choControllerheight = TextEditingController();
  TextEditingController _choControllersex = TextEditingController();
  
  @override
  void initState() {
    _choControllername.text = widget.patientIndex == -1 ? '' : widget.modpat.newPatient[widget.patientIndex].patients.toString();
    _choControllerage.text = widget.ageIndex == -1 ? '' : widget.modpat.newPatient[widget.ageIndex].patients.toString();
    _choControllerweight.text = widget.patientIndex == -1 ? '' : widget.modpat.newPatient[widget.patientIndex].patients.toString();
    _choControllerheight.text = widget.patientIndex == -1 ? '' : widget.modpat.newPatient[widget.patientIndex].patients.toString();
    _choControllersex.text = widget.patientIndex == -1 ? '' : widget.modpat.newPatient[widget.patientIndex].patients.toString();
    
    super.initState();
  } // initState

  //Form controllers need to be manually disposed. So, here we need also to override the dispose() method.
  @override
  void dispose() {
    _choControllername.dispose();
    _choControllerage.dispose();
    _choControllerweight.dispose();
    _choControllerheight.dispose();
    _choControllersex.dispose();
    super.dispose();
  } // dispose

  @override
  Widget build(BuildContext context) {    

    //Print the route display name for debugging
    print('${PatientPage.routeDisplayName} built');

    //The page is composed of a form. An action in the AppBar is used to validate and save the information provided by the user.
    //A FAB is showed to provide the "delete" functinality. It is showed only if the patient already exists.
    return Scaffold(
      appBar: AppBar(
        title: Text(PatientPage.routeDisplayName),
        actions: [
          IconButton(onPressed: () => _validateAndSave(context), icon: Icon(Icons.done))
        ],
      ),
      body: Center(
        child: _buildForm(context),
      ),
      floatingActionButton: widget.patientIndex == -1 ? null : FloatingActionButton(onPressed: () => _deleteAndPop(context), child: Icon(Icons.delete),),
    );
  }//build

  
  Widget _buildForm(BuildContext context) {
    return Form(
      key: formKey,
      child: Padding(
        padding: const EdgeInsets.only(top: 10, bottom: 8, left: 20, right: 20),
        child: ListView(
          children: <Widget>[
            FormSeparator(label: 'Patient'),
           
            FormStringTile(labelText: 'Name and Surname',
              controller: _choControllername,
              icon: MdiIcons.faceManProfile,
              
            ),
            FormSeparator(label: 'Age'),
             FormNumberTileAge(
              labelText: 'Age',
              controller: _choControllerage,
              icon: MdiIcons.cake,
            ),
            FormSeparator(label: 'Weight'),
            FormNumberTileWeight(
              labelText: 'Weight (kg)',
              controller: _choControllerweight,
              icon: MdiIcons.scale,
            ),
            FormSeparator(label: 'Height'),
            FormNumberTileHeight(
              labelText: 'Height (cm)',
              controller: _choControllerheight,
              icon: MdiIcons.ruler,
            ),
            FormSeparator(label: 'Sex'),
            FormSexTile(
              labelText: 'Sex',
              controller: _choControllersex,
              icon: MdiIcons.genderFemale,
            ),
          ],
        ),
      ),
    );
  } // _buildForm

  

  //Utility method that validate the form and, if it is valid, save the new patient information.
  void _validateAndSave(BuildContext context) {
    if(formKey.currentState!.validate()){
      Patients newPatient = Patients(patients: _choControllername.text, age:_choControllerage.text, weight:_choControllerweight.text, height:_choControllerweight.text);
      widget.patientIndex == -1 ? widget.modpat.addPatient(newPatient) : widget.modpat.editPatient(widget.patientIndex, newPatient);
      Navigator.pop(context);
    }
  } // _validateAndSave

  //Utility method that deletes
  void _deleteAndPop(BuildContext context){
    widget.modpat.removePatient(widget.patientIndex);
    Navigator.pop(context);
  }//_deleteAndPop

} //PatientPage
