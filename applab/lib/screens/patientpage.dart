import 'dart:convert';
import 'package:applab/providers/modifypatient.dart';
import 'package:applab/models/patientdatabase.dart';
import 'package:applab/screens/homepage.dart';
import 'package:applab/utils/button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
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
  PatientPage(
      {Key? key,
      required this.modpat,
      required this.patientIndex,
      required this.button})
      : super(key: key);

  static const routeDisplayName = 'Patient Page';

  @override
  State<PatientPage> createState() => _PatientPage();
} //PatientPage

List<String> gravity = ['Low', 'Medium', 'High'];
List<String> treat = ['Yes', 'No'];
Map<String, bool> drug = {
  'No': false,
  'Benzodiazepine': false,
  'Bromocriptine': false,
  'Amantadine': false
};
List<dynamic> _drugtreat=[]; 

class _PatientPage extends State<PatientPage> {
  final formKey = GlobalKey<FormState>();

  //Variables that maintain the current form fields values in memory.
  TextEditingController _controllerName = TextEditingController();
  TextEditingController _controllerAge = TextEditingController();
  TextEditingController _controllerWeight = TextEditingController();
  TextEditingController _controllerHeight = TextEditingController();
  TextEditingController _controllerYear = TextEditingController();
  bool? _controllerSex;
  String _currentOption = gravity[0];
  String _underTreatment = treat[0];

  final Box<Patientdatabase> patientdatabase1 =
      Hive.box<Patientdatabase>('patients');

  int? findIndex(Patientdatabase patientofind) {
    for (int i = 0; i < patientdatabase1!.length; i++) {
      if ((patientdatabase1.getAt(i))?.age == patientofind.age &&
          (patientdatabase1.getAt(i))?.patients == patientofind.patients &&
          (patientdatabase1.getAt(i)?.weight) == patientofind.weight &&
          (patientdatabase1.getAt(i)?.height) == patientofind.height &&
          (patientdatabase1.getAt(i)?.doctorname == patientofind.doctorname)) {
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
    _controllerSex= widget.patientIndex == -1 ? null : widget.modpat.newPatient[widget.patientIndex].sex;
    _controllerYear.text= widget.patientIndex == -1 ? '' : widget.modpat.newPatient[widget.patientIndex].year.toString();
    _currentOption= widget.patientIndex == -1 ? gravity[0] : widget.modpat.newPatient[widget.patientIndex].grav.toString();
    _underTreatment= widget.patientIndex == -1 ? treat[0] : widget.modpat.newPatient[widget.patientIndex].treatm.toString();

    if (widget.patientIndex == -1) {widget.button.bottonState()== false;}else{  widget.button.bottonState() == true;}
    if (widget.patientIndex == -1) {
      _drugtreat = [];
    } else {
      _drugtreat = widget.modpat.newPatient[widget.patientIndex].drug;
    
    }
    if (widget.patientIndex == -1) {
      drug = {'No':false, 'Benzodiazepine':false,'Bromocriptine':false,'Amantadine':false};
    } else {
      if (_drugtreat.contains('Benzodiazepine')==true){
       drug['Benzodiazepine']= true;
        }
       if (_drugtreat.contains('No')==true){
        drug['No']= true;
      }
        if (_drugtreat.contains('Bromocriptine')==true){
        drug['Bromocriptine']= true;
        }
        if (_drugtreat.contains('Amantidina')==true){

        drug['Amantadine']= true;
        }

        }
    super.initState();
  } // initState
  //Form controllers need to be manually disposed. So, here we need also to override the dispose() method.
  @override
  void dispose() {
    _controllerName.dispose();
    _controllerAge.dispose();
    _controllerWeight.dispose();
    _controllerHeight.dispose();
    _controllerYear.dispose();

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
        backgroundColor: Color.fromRGBO(36, 208, 220, 1),
        centerTitle: true,
        title: Text(
          PatientPage.routeDisplayName,
          style: TextStyle(
            color: Colors.white,
            fontSize: 30.0,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () => _validateAndSave(context),
            icon: Icon(
              Icons.done,
              color: Color.fromARGB(255, 255, 255, 255),
            ),
          )
        ],
      ),
      body: Stack(
        children: [
          Container(
            color: Color.fromRGBO(36, 208, 220, 1),
          ),
          Center(
            child: _buildForm(context),
          ),
        ],
      ),
      floatingActionButton: widget.patientIndex == -1
          ? null
          : FloatingActionButton(
              highlightElevation: 100,
              backgroundColor:
                  Color.fromARGB(195, 131, 229, 248).withOpacity(0.6),
              onPressed: () => _deleteAndPop(context),
              child: Icon(
                Icons.delete,
                color: Color.fromARGB(255, 255, 255, 255),
              ),
            ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  } //build

  Widget _buildForm(BuildContext context) {
    return Form(
      key: formKey,
      child: Padding(
        padding: const EdgeInsets.only(top: 10, bottom: 8, left: 20, right: 20),
        child: ListView(
          children: <Widget>[
            SizedBox(
              height: 60,
            ),
            FormStringTile(
              labelText: 'Name and Surname',
              controller: _controllerName,
              icon: MdiIcons.faceManProfile,
            ),
            SizedBox(
              height: 30,
            ),
            FormNumberTileAge(
              labelText: 'Birth year',
              controller: _controllerAge,
              icon: MdiIcons.cake,
            ),
            SizedBox(
              height: 30,
            ),
            FormNumberTileWeight(
              labelText: 'Weight (kg)',
              controller: _controllerWeight,
              icon: MdiIcons.scale,
            ),
            SizedBox(
              height: 30,
            ),
            FormNumberTileHeight(
              labelText: 'Height (cm)',
              controller: _controllerHeight,
              icon: MdiIcons.ruler,
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                    onPressed: widget.button.handleButtonPressM,
                    icon: Icon(MdiIcons.genderMale, color: Colors.white),
                    label: const Text(
                      'Male',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold),
                    ),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                        Color.fromARGB(195, 19, 121, 141).withOpacity(0.6),
                      ),
                      overlayColor: MaterialStateProperty.resolveWith(
                        (states) {
                          if (states.contains(MaterialState.pressed)) {
                            return Color.fromARGB(255, 140, 183, 218);
                          }
                        },
                      ),
                    )),
                ElevatedButton.icon(
                    onPressed: widget.button.handleButtonPressF,
                    icon: Icon(MdiIcons.genderFemale, color: Colors.white),
                    label: const Text(
                      'Female',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold),
                    ),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                        Color.fromARGB(195, 19, 121, 141).withOpacity(0.6),
                      ),
                      overlayColor: MaterialStateProperty.resolveWith(
                        (states) {
                          if (states.contains(MaterialState.pressed)) {
                            return Color.fromARGB(255, 222, 149, 222);
                          }
                        },
                      ),
                    )),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            FormNumberTileYear(
              labelText: 'Starting year of coke use',
              controller: _controllerYear,
              icon: MdiIcons.calendarAccount,
              controller2:_controllerAge,
            ),
            SizedBox(
              height: 30,
            ),
            Text(
              'How many times does the patient take coke?',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  ListTile(
                    title: const Text(
                      '1-5 times for month (LOW)',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                    leading: Radio(
                        fillColor: MaterialStateProperty.resolveWith((states) {
                          if (states.contains(MaterialState.selected)) {
                            return Color.fromARGB(195, 10, 78, 91);
                          } else {
                            return Colors.white;
                          }
                        }),
                        splashRadius: 5,
                        value: gravity[0],
                        groupValue: _currentOption,
                        onChanged: (value) {
                          setState(() {
                            _currentOption = value.toString();
                          });
                        }),
                  ),

                  ListTile(
                    title: const Text('6-10 times for month (MEDIUM)',
                        style: TextStyle(color: Colors.white, fontSize: 18)),
                    leading: Radio(
                        fillColor: MaterialStateProperty.resolveWith((states) {
                          if (states.contains(MaterialState.selected)) {
                            return Color.fromARGB(195, 10, 78, 91);
                          } else {
                            return Colors.white;
                          }
                        }),
                        splashRadius: 5,
                        value: gravity[1],
                        groupValue: _currentOption,
                        onChanged: (value) {
                          setState(() {
                            _currentOption = value.toString();
                          });
                        }),
                  ),

                  ListTile(
                    title: const Text(
                      'More than 10 times (HIGH)',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                    leading: Radio(
                        splashRadius: 5,
                        fillColor: MaterialStateProperty.resolveWith((states) {
                          if (states.contains(MaterialState.selected)) {
                            return Color.fromARGB(195, 10, 78, 91);
                          } else {
                            return Colors.white;
                          }
                        }),
                        value: gravity[2],
                        groupValue: _currentOption,
                        onChanged: (value) {
                          setState(() {
                            _currentOption = value.toString();
                          });
                        }),
                  ),

                  SizedBox(
                    height: 30,
                  ),

                  Text(
                    'Is the patient under treatment?',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),

                  Column(
                    children: <Widget>[
                      ListTile(
                        title: const Text(
                          'YES',
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                        leading: Radio(
                            fillColor:
                                MaterialStateProperty.resolveWith((states) {
                              if (states.contains(MaterialState.selected)) {
                                return Color.fromARGB(195, 10, 78, 91);
                              } else {
                                return Colors.white;
                              }
                            }),
                            splashRadius: 5,
                            value: treat[0],
                            groupValue: _underTreatment,
                            onChanged: (value) {
                              setState(() {
                                print(_underTreatment);
                                _underTreatment = value.toString();
                              });
                            }),
                      ),
                      ListTile(
                        title: const Text(
                          'NO',
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                        leading: Radio(
                            splashRadius: 5,
                            fillColor:
                                MaterialStateProperty.resolveWith((states) {
                              if (states.contains(MaterialState.selected)) {
                                return Color.fromARGB(195, 10, 78, 91);
                              } else {
                                return Colors.white;
                              }
                            }),
                            value: treat[1],
                            groupValue: _underTreatment,
                            onChanged: (value) {
                              setState(() {
                                print(_underTreatment);
                                _underTreatment = value.toString();
                              });
                            }),
                      ),
                    ],
                  ),

                  SizedBox(
                    height: 30,
                  ),

                  Text(
                    _underTreatment == 'Yes'
                        ? 'Which treatment is he doing?'
                        : 'Which treatment do you reccomend?',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),

                  // IF UNDER TREATMENT

                  if (_underTreatment == 'Yes')
                    Column(
                      children: <Widget>[

                        CheckboxListTile(
                          enabled: drug['Benzodiazepine']==true || drug['Bromocriptine']==true || drug['Amantadine']==true? false :true,
                          title: Text(
                            'No',
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                          value: drug['No'],
                          side: BorderSide(
                              width: 3,
                              color: Colors.white,
                              style: BorderStyle.solid),
                          controlAffinity: ListTileControlAffinity.leading,
                          fillColor:
                              MaterialStateProperty.resolveWith((states) {
                            if (states.contains(MaterialState.selected)) {
                              return Color.fromARGB(195, 10, 78, 91);
                            } else {
                              return Color.fromRGBO(36, 208, 220, 1);
                            }
                          }),
                          onChanged: (value) {
                            setState(() {
                              if (drug['No'] = value!) {
                                _drugtreat.add('No');
                              } else {
                                if (_drugtreat.contains('No') == true) {
                                  _drugtreat.remove('No');
                                }
                              }
                            });
                          },
                        ),
                        CheckboxListTile(
                          enabled: drug['No']==true ? false :true,
                          title: Text(
                            'Benzodiazepine',
                            style: TextStyle(color: Colors.white),
                          ),
                          value: drug['Benzodiazepine'],
                          side: BorderSide(
                              width: 3,
                              color: Colors.white,
                              style: BorderStyle.solid),
                          controlAffinity: ListTileControlAffinity.leading,
                          
                          fillColor:
                              MaterialStateProperty.resolveWith((states) {
                            if (states.contains(MaterialState.selected)) {
                              return Color.fromARGB(195, 10, 78, 91);
                            } else {
                              return Color.fromRGBO(36, 208, 220, 1);
                            }
                          }),
                          onChanged: (value) {
                            setState(() {
                              if (drug['Benzodiazepine'] = value!) {
                                _drugtreat.add('Benzodiazepine');
                              } else {
                                if (_drugtreat.contains('Benzodiazepine') ==
                                    true) {
                                  _drugtreat.remove('Benzodiazepine');
                                }
                              }
                            });
                          },
                        ),
                        CheckboxListTile(
                           //tristate: true,
                           enabled: drug['No']==true || drug['Amantadine']==true  ? false :true,
                          title: Text(
                            'Bromocriptine',
                            style: TextStyle(color: Colors.white),
                          ),
                          value: drug['Bromocriptine'],
                          side: BorderSide(
                              width: 3,
                              color: Colors.white,
                              style: BorderStyle.solid),
                          controlAffinity: ListTileControlAffinity.leading,
                          fillColor:
                              MaterialStateProperty.resolveWith((states) {
                            if (states.contains(MaterialState.selected)) {
                              return Color.fromARGB(195, 10, 78, 91);
                            } else {
                              return Color.fromRGBO(36, 208, 220, 1);
                            }
                          }),
                          onChanged: (value) {
                            setState(() {
                              if (drug['Bromocriptine'] = value!) {
                                _drugtreat.add('Bromocriptine');
                              } else {
                                if (_drugtreat.contains('Bromocriptine') ==
                                    true) {
                                  _drugtreat.remove('Bromocriptine');
                                }
                              }
                            });
                          },
                        ),
                        CheckboxListTile(
                          
                          enabled: drug['No']==true || drug['Bromocriptine']==true  ? false :true,
                          title: Text(
                            'Amantadine',
                            style: TextStyle(color: Colors.white),
                          ),
                          value: drug['Amantadine'],
                          side: BorderSide(
                              width: 3,
                              color: Colors.white,
                              style: BorderStyle.solid),
                          controlAffinity: ListTileControlAffinity.leading,
                          fillColor:
                              MaterialStateProperty.resolveWith((states) {
                            if (states.contains(MaterialState.selected)) {
                              return Color.fromARGB(195, 10, 78, 91);
                            } else {
                              return Color.fromRGBO(36, 208, 220, 1);
                            }
                          }),
                          onChanged: (value) {
                            setState(() {
                              if (drug['Amantadine'] = value!) {
                                _drugtreat.add('Amantadine');
                              } else {
                                if (_drugtreat.contains('Amantadine') == true) {
                                  _drugtreat.remove('Amantadine');
                                }
                              }
                            });
                          },
                        ),
                      ],
                    ),

                  // IF NOT UNDER TREATMENT
                  if (_underTreatment == 'No')
                    Column(
                      children: <Widget>[
                        CheckboxListTile(
                           enabled: drug['Benzodiazepine']==true || drug['Bromocriptine']==true || drug['Amantadine']==true? false :true,
                          title: RichText(
                            text: TextSpan(
                              text: 'No ',
                              style: const TextStyle(
                                  color: Color.fromARGB(255, 255, 255, 255),
                                  fontSize: 18),
                              children: <TextSpan>[
                                TextSpan(
                                    text: '(LOW)',
                                    style: TextStyle(
                                        color: Colors.green,
                                        fontWeight: FontWeight.bold)),
                              ],
                            ),
                          ),
                          value: drug['No'],
                          side: BorderSide(
                              width: 3,
                              color: Colors.white,
                              style: BorderStyle.solid),
                          controlAffinity: ListTileControlAffinity.leading,
                          fillColor:
                              MaterialStateProperty.resolveWith((states) {
                            if (states.contains(MaterialState.selected)) {
                              return Color.fromARGB(195, 10, 78, 91);
                            } else {
                              return Color.fromRGBO(36, 208, 220, 1);
                            }
                          }),
                          onChanged: (bool? value) {
                            setState(() {
                              if (drug['No'] = value!) {
                                _drugtreat.add('No');
                              } else {
                                if (_drugtreat.contains('No') == true) {
                                  _drugtreat.remove('No');
                                }
                              }
                            });
                          },
                        ),
                        CheckboxListTile(
                           enabled: drug['No']==true ? false :true,
                          title: RichText(
                            text: TextSpan(
                              text: 'Benzodiazepine ',
                              style: const TextStyle(
                                  color: Color.fromARGB(255, 255, 255, 255),
                                  fontSize: 18),
                              children: <TextSpan>[
                                TextSpan(
                                    text: '(LOW, ',
                                    style: TextStyle(
                                        color: Colors.green,
                                        fontWeight: FontWeight.bold)),
                                TextSpan(
                                    text: ' MEDIUM)',
                                    style: TextStyle(
                                        color: Colors.orange,
                                        fontWeight: FontWeight.bold)),
                              ],
                            ),
                          ),
                          value: drug['Benzodiazepine'],
                          side: BorderSide(
                              width: 3,
                              color: Colors.white,
                              style: BorderStyle.solid),
                          controlAffinity: ListTileControlAffinity.leading,
                          fillColor:
                              MaterialStateProperty.resolveWith((states) {
                            if (states.contains(MaterialState.selected)) {
                              return Color.fromARGB(195, 10, 78, 91);
                            } else {
                              return Color.fromRGBO(36, 208, 220, 1);
                            }
                          }),
                          onChanged: (bool? value) {
                            setState(() {
                              if (drug['Benzodiazepine'] = value!) {
                                _drugtreat.add('Benzodiazepine');
                              } else {
                                if (_drugtreat.contains('Benzodiazepine') ==
                                    true) {
                                  _drugtreat.remove('Benzodiazepine');
                                }
                              }
                            });
                          },
                        ),
                        CheckboxListTile(
                          enabled: drug['No']==true || drug['Amantadine']==true  ? false :true,
                          title: RichText(
                            text: TextSpan(
                              text: 'Bromocriptine ',
                              style: const TextStyle(
                                  color: Color.fromARGB(255, 255, 255, 255),
                                  fontSize: 18),
                              children: <TextSpan>[
                                TextSpan(
                                    text: '(MEDIUM,',
                                    style: TextStyle(
                                        color: Colors.orange,
                                        fontWeight: FontWeight.bold)),
                                TextSpan(
                                    text: ' HIGH)',
                                    style: TextStyle(
                                        color: Colors.red,
                                        fontWeight: FontWeight.bold)),
                              ],
                            ),
                          ),
                          value: drug['Bromocriptine'],
                          side: BorderSide(
                              width: 3,
                              color: Colors.white,
                              style: BorderStyle.solid),
                          controlAffinity: ListTileControlAffinity.leading,
                          fillColor:
                              MaterialStateProperty.resolveWith((states) {
                            if (states.contains(MaterialState.selected)) {
                              return Color.fromARGB(195, 10, 78, 91);
                            } else {
                              return Color.fromRGBO(36, 208, 220, 1);
                            }
                          }),
                          onChanged: (bool? value) {
                            setState(() {
                              if (drug['Bromocriptine'] = value!) {
                                _drugtreat.add('Bromocriptine');
                              } else {
                                if (_drugtreat.contains('Bromocriptine') ==
                                    true) {
                                  _drugtreat.remove('Bromocriptine');
                                }
                              }
                            });
                          },
                        ),
                        CheckboxListTile(
                          enabled: drug['No']==true || drug['Bromocriptine']==true  ? false :true,
                          title: RichText(
                            text: TextSpan(
                              text: 'Amantadine ',
                              style: const TextStyle(
                                  color: Color.fromARGB(255, 255, 255, 255),
                                  fontSize: 18),
                              children: <TextSpan>[
                                TextSpan(
                                    text: '(HIGH)',
                                    style: TextStyle(
                                        color: Colors.red,
                                        fontWeight: FontWeight.bold)),
                              ],
                            ),
                          ),
                          value: drug['Amantadine'],
                          controlAffinity: ListTileControlAffinity.leading,
                          side: BorderSide(
                              width: 3,
                              color: Colors.white,
                              style: BorderStyle.solid),
                          fillColor:
                              MaterialStateProperty.resolveWith((states) {
                            if (states.contains(MaterialState.selected)) {
                              return Color.fromARGB(195, 10, 78, 91);
                            } else {
                              return Color.fromRGBO(36, 208, 220, 1);
                            }
                          }),
                          onChanged: (bool? value) {
                            setState(() {
                              if (drug['Amantadine'] = value!) {
                                _drugtreat.add('Amantadine');
                              } else {
                                if (_drugtreat.contains('Amantadine') == true) {
                                  _drugtreat.remove('Amantadine');
                                }
                              }
                            });
                          },
                        ),
                      ],
                    ),

                  SizedBox(
                    height: 30,
                  ),
                ]),
          ],
        ),
      ),
    );
  } // _buildForm

  //Utility method that validate the form and, if it is valid, save the new patient information.
  void _validateAndSave(BuildContext context) async {
    bool yearval=true;
     bool butnStat=true;
    if (widget.patientIndex == -1 && widget.button.bottonState() != true) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
           textAlign: TextAlign.center,
            'You must push a botton',
            style: TextStyle(color: const Color.fromARGB(255, 122, 22, 15),fontWeight:FontWeight.bold, fontSize: 16)
          ),
          closeIconColor: Colors.amber,
          backgroundColor: const Color.fromARGB(255, 234, 119, 110),
        ),
      );
      bool butnStat=false;
    }

    if (widget.button.bottonStateM() == true && widget.button.bottonStateF() == false  ) {
      _controllerSex = false;
    } 
    if(widget.button.bottonStateF() == true && widget.button.bottonStateM() == false  ) {
      _controllerSex = true;
    }
    
  

    if (formKey.currentState!.validate() && butnStat && yearval==true) {
      //print(currentOption);
      final sharedPreferences = await SharedPreferences.getInstance();
      String? elemntname = await sharedPreferences.getString('USERNAMELOGGED');
      Patients newPatient = Patients(
          patients: _controllerName.text,
          age: _controllerAge.text,
          weight: _controllerWeight.text,
          height: _controllerHeight.text,
          sex: _controllerSex!,
          year: _controllerYear.text,
          grav: _currentOption,
          treatm: _underTreatment,
          drug: _drugtreat);
      var newPat = Patientdatabase(
          _controllerName.text,
          _controllerAge.text,
          _controllerWeight.text,
          _controllerHeight.text,
          _controllerSex!,
          _controllerYear.text,
          _currentOption,
          _underTreatment,
          _drugtreat,
          elemntname!);
      if (widget.patientIndex == -1) {
        widget.modpat.addPatient(newPatient);
        

        var box =Hive.box<Patientdatabase>('patients');
        box.add(newPat);
      } else {
        Patients provoiuspat =
            (Provider.of<ModifyPatient>(context, listen: false))
                .newPatient[widget.patientIndex];
        String oldname = provoiuspat.patients;
        String oldage = provoiuspat.age;
        String oldheight = provoiuspat.height;
        String oldweight = provoiuspat.weight;
        bool oldsex = provoiuspat.sex;
        String oldyear = provoiuspat.year;
        String oldgrav = provoiuspat.grav;
        String oldtreatm = provoiuspat.treatm;
        List olddrug = provoiuspat.drug;

        print(oldname);
        widget.modpat.editPatient(widget.patientIndex, newPatient);
        print(elemntname);
        var oldpat = Patientdatabase(oldname, oldage, oldweight, oldheight,
            oldsex, oldyear, oldgrav, oldtreatm, olddrug, elemntname!);
        int? oldondex = findIndex(oldpat);

        

       var box =Hive.box<Patientdatabase>('patients');
       await box.putAt(oldondex!, newPat);
      }
  
      //Navigator.popUntil(context, ModalRoute.withName('/Home Page'))
     Navigator.pushAndRemoveUntil(context,MaterialPageRoute(  builder: (context) => HomePage(doctorname: elemntname,)),(Route<dynamic> route) => false,);
    }
  } // _validateAndSave

  //Utility method that deletes
  void _deleteAndPop(BuildContext context) async {
    // widget.modpat.removePatient(widget.patientIndex);
    Patients provoiuspat = (Provider.of<ModifyPatient>(context, listen: false))
        .newPatient[widget.patientIndex];
    String oldname = provoiuspat.patients;
    String oldage = provoiuspat.age;
    String oldheight = provoiuspat.height;
    String oldweight = provoiuspat.weight;
    bool oldsex = provoiuspat.sex;
    String oldyear = provoiuspat.year;
    String oldgrav = provoiuspat.grav;
    String oldtreatm = provoiuspat.treatm;
    List olddrug = provoiuspat.drug;
    final sharedPreferences = await SharedPreferences.getInstance();
    String? elemntname = await sharedPreferences.getString('USERNAMELOGGED');
    widget.modpat.removePatient(widget.patientIndex);
    var oldpat = Patientdatabase(oldname, oldage, oldweight, oldheight, oldsex,
        oldyear, oldgrav, oldtreatm, olddrug, elemntname!);
    
  
    var box =Hive.box<Patientdatabase>('patients');
    int? oldondex = findIndex(oldpat);
    box.deleteAt(oldondex!);
     Navigator.pushAndRemoveUntil(context,MaterialPageRoute(  builder: (context) => HomePage(doctorname: elemntname,)),(Route<dynamic> route) => false,);
  } //_deleteAndPop
} //Patient