import 'package:applab/models/modifypatient.dart';
import 'package:applab/models/patientdatabase.dart';
import 'package:applab/screens/homepage.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:applab/models/patient.dart';
import 'package:applab/utils/format.dart';
import 'package:hive/hive.dart';
import 'package:applab/models/patientdatabase.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';


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
  final Box<Patientdatabase> patientdatabase1= Hive.box<Patientdatabase>('patients');


   int? findIndex(Patientdatabase patientofind){
    for (int i=0; i< patientdatabase1!.length; i++ ){
      if ((patientdatabase1.getAt(i))?.age==patientofind.age && (patientdatabase1.getAt(i))?.patients == patientofind.patients && (patientdatabase1.getAt(i)?.weight) ==patientofind.weight && (patientdatabase1.getAt(i)?.height) == patientofind.height && (patientdatabase1.getAt(i)?.doctorname == patientofind.doctorname)){
        return i;
      }
    }
    return null;
  }


  @override
  void initState() {
    _choControllername.text = widget.patientIndex == -1 ? '' : widget.modpat.newPatient[widget.patientIndex].patients.toString();
    _choControllerage.text = widget.patientIndex == -1 ? '' : widget.modpat.newPatient[widget.patientIndex].age.toString();
    _choControllerweight.text = widget.patientIndex == -1 ? '' : widget.modpat.newPatient[widget.patientIndex].weight.toString();
    _choControllerheight.text = widget.patientIndex == -1 ? '' : widget.modpat.newPatient[widget.patientIndex].height.toString();
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
  void _validateAndSave(BuildContext context)async {
    if(formKey.currentState!.validate()){
      final sharedPreferences = await SharedPreferences.getInstance();
      String? elemntname= await sharedPreferences.getString('USERNAMELOGGED');
      Patients newPatient = Patients(patients: _choControllername.text, age:_choControllerage.text, weight:_choControllerweight.text, height:_choControllerheight.text);
      var newPat= Patientdatabase(_choControllername.text,_choControllerage.text, _choControllerweight.text, _choControllerheight.text, elemntname!);
      if (widget.patientIndex == -1) {
        widget.modpat.addPatient(newPatient);
        var box= await Hive.openBox<Patientdatabase>('patients');
        box.add(newPat);
        } 
      else{
        Patients provoiuspat= (Provider.of<ModifyPatient>(context, listen: false)).newPatient[widget.patientIndex];
        String oldname= provoiuspat.patients;
        String oldage= provoiuspat.age;
        String oldheight = provoiuspat.height;
        String oldweight=provoiuspat.weight;
        //Bool sex= provoiuspat.sex;
        print(oldname);
        widget.modpat.editPatient(widget.patientIndex, newPatient);
        print(elemntname);
        var oldpat=Patientdatabase(oldname, oldage, oldweight, oldheight, elemntname!);
        int? oldondex= findIndex(oldpat);
        var box= await Hive.openBox<Patientdatabase>('patients');
        await box.putAt(oldondex!, newPat);
      } 
      //Navigator.popUntil(context, ModalRoute.withName('/Home Page'));
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage(),));
    }
  } // _validateAndSave

  //Utility method that deletes
  void _deleteAndPop(BuildContext context) async{
   // widget.modpat.removePatient(widget.patientIndex);
      Patients provoiuspat= (Provider.of<ModifyPatient>(context, listen: false)).newPatient[widget.patientIndex];
      String oldname= provoiuspat.patients;
      String oldage= provoiuspat.age;
      String oldheight = provoiuspat.height;
      String oldweight=provoiuspat.weight;
      final sharedPreferences = await SharedPreferences.getInstance();
      String? elemntname= await sharedPreferences.getString('USERNAMELOGGED');
      widget.modpat.removePatient(widget.patientIndex);
      var oldpat=Patientdatabase(oldname, oldage, oldweight, oldheight, elemntname!);
      var box= await Hive.openBox<Patientdatabase>('patients');
      int? oldondex= findIndex(oldpat);
      box.deleteAt(oldondex!);
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage(),));
       
  }//_deleteAndPop

} //Patien