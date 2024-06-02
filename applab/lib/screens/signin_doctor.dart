import 'package:applab/models/doctordatabase.dart';
import 'package:flutter/material.dart';
import 'package:applab/models/doctor.dart';
import 'package:applab/models/doctordatabase.dart';
import 'package:hive/hive.dart';


class SignInDoctor extends StatefulWidget{
  //final ListDoctor listDoctor;
  SignInDoctor({Key? key}):super(key:key);
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
      appBar: AppBar( backgroundColor:Color.fromRGBO(36, 208, 220, 1)),
      body: SingleChildScrollView(
       
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 40),
          height: MediaQuery.of(context).size.height,
        color:Color.fromRGBO(36, 208, 220, 1),
        child: 
        Column(
          mainAxisAlignment: MainAxisAlignment.start ,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            
        SizedBox(
              height: 100.0,
        ),
            
        Text("Sign up",
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Colors.white,
        ),),
           
         SizedBox(
                height: 30,
         ),

        Text( "Create your doctor account",
                    style: TextStyle(fontSize: 15, color: Colors.white),
        ),

        SizedBox(
              height:40.00
        ),
            
        Padding(
              padding: EdgeInsets.symmetric(horizontal:15),
              child: TextField(
                controller: _nameDoctor,
                decoration: InputDecoration(
                  hintText: "Enter your last name",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(18),
                    borderSide: BorderSide.none
                    ),
                  fillColor: Colors.white.withOpacity(0.8),
                  filled: true,
                  prefixIcon:const Icon(Icons.person)
                ),),
        ),
              
        SizedBox(
                height: 25,
        ),
           
        Padding(
              padding: EdgeInsets.symmetric(horizontal:15),
              child: TextField(
                controller: _emailDoctor,
                decoration: InputDecoration(
                  hintText: "Email",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(18),
                    borderSide: BorderSide.none
                  ),
                  fillColor: Colors.white.withOpacity(0.8),
                  filled: true,
                  prefixIcon:const Icon(Icons.mail)
                ),
                 ),
          ),
               
               
        SizedBox(
                height: 25,
        ),
             
             
        Padding(
              padding: EdgeInsets.symmetric(horizontal:15),
              child: TextField(
                controller: _passwordDoctor,
                decoration: InputDecoration(
                  hintText: "Password",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(18),
                    borderSide: BorderSide.none
                  ),
                  fillColor: Colors.white.withOpacity(0.8),
                  filled: true,
                  prefixIcon:const Icon(Icons.password)
                ),
                 ),
        ),
             
             
        SizedBox(
          height: 35,
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
        
        )
       )
      );
     }//build

    void _validateAndSave(BuildContext context)async{
   //   if (formKey.currentState!.validate()){
       // Doctor newDoctor = Doctor(surname: _nameDoctor.text, email: _emailDoctor.text, password: _passwordDoctor.text );
        //widget.listDoctor.addDoctor(newDoctor);
       // widget.listDoctor.addDoctor(newDoctor);
       var newDoctor = Doctordatabase(_nameDoctor.text, _emailDoctor.text, _passwordDoctor.text);
       var box= await Hive.openBox<Doctordatabase>('doctors');
       box.add(newDoctor);
       //widget.listDoctor.addDoctor(newDoctor);
        Navigator.pop(context);
        
    //  }
      
    }
  } //SignInpage 