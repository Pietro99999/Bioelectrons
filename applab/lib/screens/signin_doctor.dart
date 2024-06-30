import 'package:applab/models/doctordatabase.dart';
import 'package:applab/screens/login.dart';
import 'package:applab/utils/format.dart';
import 'package:flutter/material.dart';
import 'package:applab/models/doctor.dart';
import 'package:applab/models/doctordatabase.dart';
import 'package:hive/hive.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';


class SignInDoctor extends StatefulWidget{
  //final ListDoctor listDoctor;
  SignInDoctor({Key? key}):super(key:key);
  static const routeDisplayName = 'Signin Page';
  @override
  State<SignInDoctor> createState() => _SignInDoctorState();
  //final Box<Doctordatabase> databaseBox= Hive.box<Doctordatabase>('myBox');
}

class _SignInDoctorState extends State<SignInDoctor>{
    final formKey = GlobalKey<FormState>();

    TextEditingController _nameDoctor = TextEditingController();
    TextEditingController _emailDoctor = TextEditingController();
    TextEditingController _passwordDoctor = TextEditingController();

    @override
    void initState() {
    _nameDoctor.text = '';
    _emailDoctor.text= '';
    _passwordDoctor.text = '' ;
    super.initState();
    } 

    @override
     void dispose() {
     _nameDoctor.dispose();
     _emailDoctor.dispose();
     _passwordDoctor.dispose();
     super.dispose();
    } // dispo


    @override
     Widget build(BuildContext context) {
     return Scaffold(
      appBar: AppBar( 
       centerTitle: true,
        title: Text(SignInDoctor.routeDisplayName,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 40.0,
                        fontWeight:FontWeight.bold,
                       ),)
                       ,
        backgroundColor:Color.fromRGBO(36, 208, 220, 1),
       
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
     );
     } // build
            
    Widget _buildForm(BuildContext context) {
    return Form(
      
      key: formKey,
      child: Padding(
        
        padding: const EdgeInsets.symmetric(horizontal: 2.0),
        child: ListView(
          
          children: <Widget>[
             SingleChildScrollView(
           
        child:  Column(
          mainAxisAlignment: MainAxisAlignment.start ,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
                height: 10,
         ),

        Text( "Create your doctor account",
                    style: TextStyle(fontSize: 18, color: Colors.white),
        ),
             SizedBox(
              height:40.00
               ),

        FormDoctTile(labelText: 'Enter a valid username',
              controller: _nameDoctor,
              
            ),
        SizedBox(
                height: 40,
        ), 
           
            FormEmailTile(labelText: 'Enter a valid mail adress',
              controller: _emailDoctor,
              
            ),
               SizedBox(
                height: 40,
        ), 
 FormPswTile(labelText: 'Enter a valid password',
              controller: _passwordDoctor,
              
            ),
             
                  SizedBox(
                    height: 40,
                  ),



                  Container(
                     height: 60,
                    width: 250,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20)),
                      child: ElevatedButton(
                      onPressed: () => _validateAndSave(context),
                      child: const Text(
                        "Sign up",
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.black),
                      ),
                      style: ElevatedButton.styleFrom(
                        shape: const StadiumBorder(),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        backgroundColor: Colors.white.withOpacity(0.8),
                      ),
                    )
          ),


          ],
          ),
        
        
        ),
            

             

            
           ],
           
           ),
           
           ),
           
           );
          } // _buildForm
          
    

     

    void _validateAndSave(BuildContext context)async{
       if (formKey.currentState!.validate()){
          //Doctor newDoctor = Doctor(surname: _nameDoctor.text, email: _emailDoctor.text, password: _passwordDoctor.text );
          //widget.listDoctor.addDoctor(newDoctor);
            var newDoct= Doctordatabase(_nameDoctor.text, _emailDoctor.text, _passwordDoctor.text);
            var box= await Hive.openBox<Doctordatabase>('doctors');
            box.add(newDoct);
       //widget.listDoctor.addDoctor(newDoctor);
          Navigator.pop(context);
       
    
      
    }
  } 
  }//SignInpage 