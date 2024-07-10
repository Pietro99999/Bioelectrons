import 'package:applab/models/doctordatabase.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:applab/screens/homepage.dart';
import 'package:fancy_password_field/fancy_password_field.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

//nfinal GlobalKey<FlutterPwValidatorState> validatorKey = GlobalKey<FlutterPwValidatorState>();
///Class that implements a custom [StatelessWidget] that acts as a separator in a [Form].
///It can be used to separate "categories" in a [Form].
class FormSeparator extends StatelessWidget {
 
  final label;


  FormSeparator({this.label});

  @override
  Widget build(BuildContext context) {
    
    return Center(
      child: Column(
        children: [
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 2,
                width: 75,
                child: Container(
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
              Expanded(
                  child: Center(
                      child: Text(
                label,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ))),
              SizedBox(
                height: 2,
                width: 75,
                child: Container(
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  } // build

} // FormSeparator

///Class that implement a custom-made [ListTile] to manage textboxes containing strings in a [Form].
///You must provide a controller, a label that is shown as helper, and an icon. This is checked via a regex.
///The [FormTextTile] content is valid if it is not empty.
class FormTextTile extends ListTile {
  final controller;
  final labelText;
  final icon;
  

  FormTextTile({this.icon, this.controller, this.labelText});

  @override
  Widget build(BuildContext context) {
  
    Size screenSize = MediaQuery.of(context).size;
    return ListTile(
      leading: Icon(icon, color: Theme.of(context).colorScheme.secondary),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: screenSize.width / 1.5,
            child: TextFormField(
              controller: controller,
              validator: (value) => value == "" ? 'Must not be empty.' : null,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                labelText: labelText,
                focusColor: Theme.of(context).colorScheme.secondary,
              ),
            ),
          ),
        ],
      ),
    );
  } // build
} // FormTextTile

///Class that implement a custom-made [ListTile] to manage textboxes containing numbers in a [Form].
///You must provide a controller, a label that is shown as helper, and an icon.
///The [FormNumberTileAge] content is valid if it contains numbers only. This is checked via a regex.
class FormNumberTileAge extends ListTile {
  final controller;
  final labelText;
  final icon;


  FormNumberTileAge({this.icon, this.controller, this.labelText});
  DateTime _focusedDay = DateTime.now();

  @override
  Widget build(BuildContext context) {
   int yearnow=_focusedDay.year;
    Size screenSize = MediaQuery.of(context).size;
    return ListTile(
      leading: Icon(icon, color: Theme.of(context).colorScheme.secondary),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: screenSize.width / 1.5,
            child: TextFormField(
              controller: controller,
              validator: (value) {
                String? ret;
               
                String pattern = r'^(0*[1-9][0-9]*(\.[0-9]*)?|0*\.[0-9]*[1-9][0-9]*)$';
                RegExp regex = RegExp(pattern);

                if(!regex.hasMatch(value!) )
                ret = 'Must be a number.';
                else if (double.parse(value)<1900 || double.parse(value)>(yearnow-13))
                ret = 'Valid year: between 1900 and ${yearnow-13}';
                
                return ret;
               
              
              },
              
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                fillColor: Colors.white.withOpacity(0.8),
                filled: true,
                labelText: labelText,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18),
                    borderSide: BorderSide.none
                    ),
              ),
            ),
          ),
        ],
      ),
    );
  } // build
} // FormNumberTileAge

///Class that implement a custom-made [ListTile] to manage textboxes containing numbers in a [Form].
///You must provide a controller, a label that is shown as helper, and an icon.
///The [FormNumberTileWeight] content is valid if it contains numbers only. This is checked via a regex.
class FormNumberTileWeight extends ListTile {
  final controller;
  final labelText;
  final icon;

  FormNumberTileWeight({this.icon, this.controller, this.labelText});

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return ListTile(
      leading: Icon(icon, color: Theme.of(context).colorScheme.secondary),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: screenSize.width / 1.5,
            child: TextFormField(
              controller: controller,
              validator: (value) {
                String? ret;
                String pattern = r'^(0*[1-9][0-9]*(\.[0-9]*)?|0*\.[0-9]*[1-9][0-9]*)$';
                RegExp regex = RegExp(pattern);

                if(!regex.hasMatch(value!) )
                ret = 'Must be a number.';
                else if (20>double.parse(value) || double.parse(value)>500)
                ret = 'Weight must be between 25 kg and 500 kg';
                return ret;
              
              },
              
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                fillColor: Colors.white.withOpacity(0.8),
                filled: true,
                labelText: labelText,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18),
                    borderSide: BorderSide.none
                    ),
                    
              ),
            ),
          ),
        ],
      ),
    );
  } // build
} // FormNumberTileWeight

///Class that implement a custom-made [ListTile] to manage textboxes containing numbers in a [Form].
///You must provide a controller, a label that is shown as helper, and an icon.
///The [FormNumberTileHeight] content is valid if it contains numbers only. This is checked via a regex.
class FormNumberTileHeight extends ListTile {
  final controller;
  final labelText;
  final icon;

  FormNumberTileHeight({this.icon, this.controller, this.labelText});

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return ListTile(
      leading: Icon(icon, color: Theme.of(context).colorScheme.secondary),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: screenSize.width / 1.5,
            child: TextFormField(
              controller: controller,
              validator: (value) {
                String? ret;
                String pattern = r'^(0*[1-9][0-9]*(\.[0-9]*)?|0*\.[0-9]*[1-9][0-9]*)$';
                RegExp regex = RegExp(pattern);

                if(!regex.hasMatch(value!))
                ret = 'Must be a number.';
                else if (120>double.parse(value) || double.parse(value)>250 )
                ret = 'Height must be between 120 cm and 250 cm';
                return ret;
              
              },
              
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                fillColor: Colors.white.withOpacity(0.8),
                filled: true,
                labelText: labelText,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18),
                    borderSide: BorderSide.none
                    ),
              ),
            ),
          ),
        ],
      ),
    );
  } // build
} // FormNumberTileHeight
///Class that implement a custom-made [ListTile] to manage textboxes containing numbers in a [Form].
///You must provide a controller, a label that is shown as helper, and an icon.
///The [FormNumberTileYear] content is valid if it contains numbers only. This is checked via a regex.
class FormNumberTileYear extends ListTile {
  final controller;
  final labelText;
  final icon;
  final controller2;

  FormNumberTileYear({this.icon, this.controller, this.labelText, this.controller2});
 DateTime _focusedDay = DateTime.now();
  @override
  Widget build(BuildContext context) {
    int yearnow=_focusedDay.year;
    Size screenSize = MediaQuery.of(context).size;
    return ListTile(
      leading: Icon(icon, color: Theme.of(context).colorScheme.secondary),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: screenSize.width / 1.5,
            child: TextFormField(
              controller: controller,
              validator: (value) {
                String? ret;
                String pattern = r'^(0*[1-9][0-9]*(\.[0-9]*)?|0*\.[0-9]*[1-9][0-9]*)$';
                RegExp regex = RegExp(pattern);

                if(!regex.hasMatch(value!) )
                ret = 'Must be a number.';
                else if (1940>double.parse(value)|| double.parse(value)>2024)
                ret = 'Valid year between 1940 and $yearnow';
                else if (int.parse(controller2.text)+13>int.parse(value)){
                  if(int.parse(controller2.text)>(yearnow-13)){
                    ret='Choose a valid birth year';
                  }else{

                ret = 'Year must be greater than ${int.parse(controller2.text)+13}';
                }
                }
                return ret;

               
              },
              
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                fillColor: Colors.white.withOpacity(0.8),
                filled: true,
                labelText: labelText,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18),
                    borderSide: BorderSide.none
                    ),
              ),
            ),
          ),
        ],
      ),
    );
  } // build
} // FormNumberTileYear

class FormNumberTile extends ListTile {
  final controller;
  final labelText;
  final icon;

  FormNumberTile({this.icon, this.controller, this.labelText});

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return ListTile(
      leading: Icon(icon, color: Theme.of(context).colorScheme.secondary),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: screenSize.width / 1.5,
            child: TextFormField(
              controller: controller,
              validator: (value) {
                String? ret;
                String pattern = r'^(0*[1-9][0-9]*(\.[0-9]*)?|0*\.[0-9]*[1-9][0-9]*)$';
                RegExp regex = RegExp(pattern);
                if(!regex.hasMatch(value!))
                  ret = 'Must be a number.';
                return ret;
              },
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                fillColor: Colors.white.withOpacity(0.8),
                filled: true,
                labelText: labelText,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18),
                    borderSide: BorderSide.none
                    ),
                    ),
            ),
          ),
        ],
      ),
    );
  } // build
} // FormNumberTile


///Class that implement a custom-made [ListTile] to manage textboxes containing numbers in a [Form].
///You must provide a controller, a label that is shown as helper, and an icon.
///The [FormStringTile] content is valid if it contains strings only. This is checked via a regex.
class FormStringTile extends ListTile {
  final controller;
  final labelText;
  final icon;

  FormStringTile({this.icon, this.controller, this.labelText});

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return ListTile(
      leading: Icon(icon, color: Theme.of(context).colorScheme.secondary),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: screenSize.width / 1.5,
            child: TextFormField(
              controller: controller,
              validator: (value) {
                String? ret;
                String pattern = r"^[\p{L} ,.'-]*$";  
                RegExp regex = RegExp(pattern, caseSensitive: false, unicode: true, dotAll: true);
                if(!regex.hasMatch(value!) || value=='')
                  ret = 'Must be a string.';
                return ret;
              },
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                fillColor: Colors.white.withOpacity(0.8),
                filled: true,
                labelText: labelText,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18),
                    borderSide: BorderSide.none
                    ),
              ),
            ),
          ),
        ],
      ),
    );
  } // build
} // FormStringTile

//Class that implement a custom-made [ListTile] to manage textboxes containing numbers in a [Form].
///You must provide a controller, a label that is shown as helper, and an icon.
///The [FormEmailTile] content is valid if it contains strings only. This is checked via a regex.
class FormEmailTile extends ListTile {
  final controller;
  final labelText;
  final icon;

  FormEmailTile({this.icon, this.controller, this.labelText});

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return ListTile(
      leading: Icon(icon, color: Theme.of(context).colorScheme.secondary),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[     
            Padding(
            padding: const EdgeInsets.symmetric(horizontal: 2.0),
            child: TextFormField(
              controller: controller,
              validator: (value) {
                String? ret;
                String pattern =r"(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'"
      r'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-'
      r'\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*'
      r'[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:(2(5[0-5]|[0-4]'
      r'[0-9])|1[0-9][0-9]|[1-9]?[0-9]))\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9]'
      r'[0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\'
      r'x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])'; 
                RegExp regex = RegExp(pattern, caseSensitive: false, unicode: true, dotAll: true);
                if(!regex.hasMatch(value!))
                  ret = 'Enter a valid email address';
                 return ret;
    
              },
               keyboardType: TextInputType.text,
              decoration: InputDecoration(
                fillColor: Colors.white.withOpacity(0.8),
                filled: true,
                labelText: labelText,
                prefixIcon:const Icon(Icons.mail),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18),
                    borderSide: BorderSide.none
                    ),
              ),
            ),
          ),
        ],
      ),
    );
  } // build
} // FormEmailTTile

//Class that implement a custom-made [ListTile] to manage textboxes containing numbers in a [Form].
///You must provide a controller, a label that is shown as helper, and an icon.
///The [FormDoctTile] content is valid if it contains strings only. This is checked via a regex.
class FormDoctTile extends ListTile {
  final controller;
  final labelText;
  final icon;

  FormDoctTile({this.icon, this.controller, this.labelText});

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return ListTile(
      leading: Icon(icon, color: Theme.of(context).colorScheme.secondary),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[     
            Padding(
            padding: const EdgeInsets.symmetric(horizontal: 2.0),
            child: TextFormField(
              controller: controller,
              validator: (value) {
                String? ret;
                String pattern =r"^[\p{L} ,.'-]*$";
                RegExp regex = RegExp(pattern, caseSensitive: false, unicode: true, dotAll: true);
                if(!regex.hasMatch(value!) || value=='')
                  ret = 'Enter a valid name';
                return ret;
              },
             keyboardType: TextInputType.text,
              decoration: InputDecoration(
                fillColor: Colors.white.withOpacity(0.8),
                filled: true,
                labelText: labelText,
                prefixIcon:const Icon(Icons.person),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18),
                    borderSide: BorderSide.none
                    ),
                
              ),
            ),
          ),
        ],
      ),
    );
  } // build
} // FormDoctTile


//Class that implement a custom-made [ListTile] to manage textboxes containing numbers in a [Form].
///You must provide a controller, a label that is shown as helper, and an icon.
///The [FormPswTile] content is valid if it contains strings only. This is checked via a regex.

final FancyPasswordController _passwordController = FancyPasswordController();
class FormPswTile extends ListTile {
  final controller;
  final labelText;
  final icon;

  FormPswTile({this.icon, this.controller, this.labelText});

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return ListTile(
      leading: Icon(icon, color: Theme.of(context).colorScheme.secondary),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[     
            Padding(
            padding: const EdgeInsets.symmetric(horizontal: 2.0),
            child: FancyPasswordField(
                passwordController: _passwordController,
                controller: controller,
                validationRules: {
                  DigitValidationRule(),
                  UppercaseValidationRule(),
                  SpecialCharacterValidationRule(),
                  MinCharactersValidationRule(8),
                },
               validator: (value) {
                String? ret;
                if(_passwordController.areAllRulesValidated!=true || value=='')
                ret= 'Must enter a valid pasword';
                return ret;
              
              },
                 strengthIndicatorBuilder: (strength) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: StepProgressIndicator(
                size:10,
                totalSteps: 6,
                roundedEdges: Radius.circular(18),
                currentStep: getStep(strength),
                selectedColor: getColor(strength)!,
                unselectedColor: Colors.grey[300]!,
              ),
            );
          },

           validationRuleBuilder: (rules, value) {
            return Wrap(
              runSpacing: 8,
              spacing: 4,
              children: rules.map(
                (rule) {
                  final ruleValidated = rule.validate(value);
                  return Chip(
                   
                    label: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (ruleValidated) ...[
                          const Icon(
                            Icons.check,
                            color: Color(0xFF0A9471),
                          ),
                          const SizedBox(width: 8),
                        ],
                        Text(
                          rule.name,
                          style: TextStyle(
                            color: ruleValidated
                                ? const Color(0xFF0A9471)
                                : Color.fromARGB(255, 208, 17, 17),
                          ),
                        ),
                      ],
                    ),
                    
                    backgroundColor: ruleValidated
                        ? const Color(0xFFD0F7ED)
                        : const Color(0xFFF4F5F6),
                  );
                },
              ).toList(),
            );
          },



                keyboardType: TextInputType.text,
              decoration: InputDecoration(
                fillColor: Colors.white.withOpacity(0.8),
                filled: true,
                labelText: labelText,
                prefixIcon:const Icon(Icons.key),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18),
                    borderSide: BorderSide.none
                )
                
              ),
            ),
          ),
         
        ],
      ),
    );
  } // build
} // FormPswTile
 
 int getStep(double strength) {
    if (strength == 0) {
      return 0;
    } else if (strength < .1) {
      return 1;
    } else if (strength < .2) {
      return 2;
    } else if (strength < .4) {
      return 3;
    } else if (strength < .6) {
      return 4;
    } else if (strength < .7) {
      return 5;
    }
    return 8;
  }

  Color? getColor(double strength) {
    if (strength == 0) {
      return Colors.grey[300];
    } else if (strength < .1) {
      return Color.fromARGB(255, 185, 19, 7);
    } else if (strength < .2) {
      return Color.fromARGB(255, 211, 55, 44);
    } else if (strength < .4) {
      return Colors.orange;
    } else if (strength < .6) {
      return Colors.yellow;
    } else if (strength < .7) {
      return  Colors.green;
    }
    return  Colors.green;
  }

 

///Class that implement a custom-made [ListTile] to manage dropdown menus containing numbers in a [Form].
///You must provide a label that is shown as helper, the value to show, the items to show, a callback to define the behaviour of the field when it changes, and an icon.
///The [DropdownButtonTileNumber] content is always valid since it is guaranteed by the fact that the values it can assumes are provided by the user.
class DropdownButtonTileNumber extends ListTile {
  final value;
  final items;
  final labelText;
  final icon;
  final onChanged;

  DropdownButtonTileNumber(
      {this.icon,
      this.value,
      this.items,
      this.labelText,
      this.onChanged});

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return ListTile(
      leading: Icon(icon, color: Theme.of(context).colorScheme.secondary),
      title: Container(
        width: screenSize.width / 1.5,
        child: DropdownButton<int>(
          isExpanded: false,
          value: value,
          onChanged: onChanged,
          items: items.map<DropdownMenuItem<int>>((int value) {
                      return DropdownMenuItem<int>(
                        value: value,
                        child: Text('${value.toString()}'),
                      );
                    })
                    .toList(),
        ),
      ),
    );
  } // build
} // DropdownButtonTileNumber

///Class that implement a custom-made [ListTile] to manage dropdown menus containing strings in a [Form].
///You must provide a label that is shown as helper, the value to show, the items to show, a callback to define the behaviour of the field when it changes, and an icon.
///The [DropdownButtonTileString] content is always valid since it is guaranteed by the fact that the values it can assumes are provided by the user.
class DropdownButtonTileString extends ListTile {
  final value;
  final items;
  final labelText;
  final icon;
  final onChanged;

  DropdownButtonTileString(
      {this.icon,
      this.value,
      this.items,
      this.labelText,
      this.onChanged});

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return ListTile(
      leading: Icon(icon, color: Theme.of(context).colorScheme.secondary),
      title: Container(
        width: screenSize.width / 1.5,
        child: DropdownButton<String>(
          isExpanded: false,
          value: value,
          onChanged: onChanged,
          items: items.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text('$value'),
                      );
                    })
                    .toList(),
        ),
      ),
    );
  } // build
} // DropdownButtonTileString