import 'package:applab/models/modifypatient.dart';
import 'package:applab/models/patientdatabase.dart';
import 'package:applab/screens/homepage.dart';
import 'package:applab/utils/button.dart';
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

    final ModifyPatient modpat;
    final ButtonErrorDemo button;

  //PatientPage constructor
  PatientPage({Key? key, required this.modpat, required this.patientIndex,required this.button}) : super(key: key);

  static const routeDisplayName = 'Patient Page';

 
  
  @override
 State<PatientPage> createState() => _PatientPage();
  
}//PatientPage

class _PatientPage extends State<PatientPage> {

  final formKey = GlobalKey<FormState>();

  //Variables that maintain the current form fields values in memory.
  TextEditingController _controllerName = TextEditingController();
  TextEditingController _controllerAge = TextEditingController();
  TextEditingController _controllerWeight = TextEditingController();
  TextEditingController _controllerHeight = TextEditingController();
  bool? _controllerSex;

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
    _controllerName.text = widget.patientIndex == -1 ? '' : widget.modpat.newPatient[widget.patientIndex].patients.toString();
    _controllerAge.text = widget.patientIndex == -1 ? '' : widget.modpat.newPatient[widget.patientIndex].age.toString();
    _controllerWeight.text = widget.patientIndex == -1 ? '' : widget.modpat.newPatient[widget.patientIndex].weight.toString();
    _controllerHeight.text = widget.patientIndex == -1 ? '' : widget.modpat.newPatient[widget.patientIndex].height.toString();
    _controllerSex= widget.patientIndex == -1 ? true : widget.modpat.newPatient[widget.patientIndex].sex;
    
    super.initState();
  } // initState

  //Form controllers need to be manually disposed. So, here we need also to override the dispose() method.
  @override
  void dispose() {
    _controllerName.dispose();
    _controllerAge.dispose();
    _controllerWeight.dispose();
    _controllerHeight.dispose();
   
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
        backgroundColor:   Color.fromRGBO(36, 208, 220, 1),
        centerTitle: true,
        title: Text(PatientPage.routeDisplayName,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 30.0,
                       ),)
                       ,
        actions: [
          IconButton(onPressed: () => _validateAndSave(context), icon: Icon(Icons.done, color: Color.fromARGB(255, 255, 255, 255),),)
        ],
      ),
      body: Stack(
        children: [ 
                    Container(
                      
                      color:  Color.fromRGBO(36, 208, 220, 1),
                    ), 
                
      Center(
        child: _buildForm(context),
      ),
        ],
        ),
      floatingActionButton: widget.patientIndex == -1 ? null : FloatingActionButton(highlightElevation:100, backgroundColor:Color.fromARGB(195, 131, 229, 248).withOpacity(0.6), onPressed: () => _deleteAndPop(context), child: Icon(Icons.delete, color:Color.fromARGB(255, 255, 255, 255),),),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        
      
    );
  }//build

  
  Widget _buildForm(BuildContext context) {
    return Form(
      key: formKey,
      child: Padding(
        
        padding: const EdgeInsets.only(top: 10, bottom: 8, left: 20, right: 20),
        child: ListView(
          
          children: <Widget>[
            SizedBox(
              height:60,
            ),
            FormStringTile(labelText: 'Name and Surname',
              controller: _controllerName,
              icon: MdiIcons.faceManProfile,
              
            ),
            SizedBox(
              height:30,
            ),
             FormNumberTileAge(
              labelText: 'Age',
              controller: _controllerAge,
              icon: MdiIcons.cake,
            ),
            SizedBox(
              height:30,
            ),
            FormNumberTileWeight(
              labelText: 'Weight (kg)',
              controller: _controllerWeight,
              icon: MdiIcons.scale,
            ),
            SizedBox(
              height:30,
            ),
            FormNumberTileHeight(
              labelText: 'Height (cm)',
              controller: _controllerHeight,
              icon: MdiIcons.ruler,
            ),
            SizedBox(
              height:30,
            ),
         
            Row(
              
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [ 
              ElevatedButton.icon(
             onPressed:  widget.button.handleButtonPressM,
             icon:  Icon(MdiIcons.genderMale,color: Colors.white),
             label:const Text('Male' ,
                        style: TextStyle(
                        color: Colors.white,
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold
                ),
                ),
             style: ButtonStyle(
               backgroundColor: MaterialStateProperty.all(Color.fromARGB(195, 19, 121, 141).withOpacity(0.6),),
              overlayColor: MaterialStateProperty.resolveWith((states){
                if(states.contains(MaterialState.pressed)){
                return Color.fromARGB(255, 140, 183, 218);
                }
              },
              ),
             )

           ),
           
           ElevatedButton.icon(
             onPressed: widget.button.handleButtonPressF,
             icon:  Icon(MdiIcons.genderFemale, color: Colors.white),
             label:const Text('Female' ,
                        style: TextStyle(
                        color: Colors.white,
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold
                ),
                ),
             style: ButtonStyle(
               backgroundColor: MaterialStateProperty.all(Color.fromARGB(195, 19, 121, 141).withOpacity(0.6),),
              overlayColor: MaterialStateProperty.resolveWith((states){
                if(states.contains(MaterialState.pressed)){
                return Color.fromARGB(255, 222, 149, 222);
                }
              },
              ),
             )

           ),
        
        ],  
         ),
          ],
        ),
      ),
    );
  } // _buildForm

  

  //Utility method that validate the form and, if it is valid, save the new patient information.
  void _validateAndSave(BuildContext context)async {
     if(widget.button.bottonState()!=true){ 
       ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('You must push a botton')),);
       }
    if (widget.button.bottonStateM()==true ){
         _controllerSex=false;
    }

   if(formKey.currentState!.validate() && widget.button.bottonState()==true){
      final sharedPreferences = await SharedPreferences.getInstance();
      String? elemntname= await sharedPreferences.getString('USERNAMELOGGED');
      Patients newPatient = Patients(patients: _controllerName.text, age:_controllerAge.text, weight:_controllerWeight.text, height:_controllerHeight.text,sex:_controllerSex);
      var newPat= Patientdatabase(_controllerName.text,_controllerAge.text, _controllerWeight.text, _controllerHeight.text, elemntname!);
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
      Navigator.pop(context);
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
      Navigator.pop(context);
       
  }//_deleteAndPop

} //Patient