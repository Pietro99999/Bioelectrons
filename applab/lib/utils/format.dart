import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:applab/screens/homepage.dart';
import 'package:fancy_password_field/fancy_password_field.dart';


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
                else if (double.parse(value)>130)
                ret = 'Must be a valid age (not allowed >130) ';
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
                ret = 'Weight must be between 20 and 500 kg';
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

                if(!regex.hasMatch(value!) )
                ret = 'Must be a number.';
                else if (120>double.parse(value) || double.parse(value)>250)
                ret = 'Height must be between 120 and 250 cm';
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
                if(!regex.hasMatch(value!))
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
                if(!regex.hasMatch(value!))
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
                  MinCharactersValidationRule(6),
                },
                strengthIndicatorBuilder: (strength) => Text(
                  strength.toString(),
                  
                ),
               

                validator: (value) {
                  return _passwordController.areAllRulesValidated
                      ? null
                      : 'Not Validated';
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