import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';


class ButtonErrorDemo extends ChangeNotifier {
  
  bool _isButtonPressed = false;
  bool _isButtonPressedF = false;
  bool _isButtonPressedM = false;

  void handleButtonPressM() {
    
      _isButtonPressedM = true;
      _isButtonPressed = true;
      _isButtonPressedF = false;
       
      notifyListeners();
    }

  void handleButtonPressF() {
    
      _isButtonPressedF = true;
      _isButtonPressed = true;
      _isButtonPressedM = false;
       
      notifyListeners();
    }
  bool bottonState(){
    return _isButtonPressed ;

    }

    bool bottonStateM(){
    return _isButtonPressedM ;

    }
    bool bottonStateF(){
    return _isButtonPressedF ;

    }
      
}



       
     