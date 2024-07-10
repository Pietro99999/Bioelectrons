import 'package:flutter/material.dart';

class IndexListona extends ChangeNotifier{
  
  int i=0;
  int primoindice=-1;

  void addIndex(){
  i=i+1;
  notifyListeners();
}

  void removeIndex(){
  i=i-1;
  notifyListeners();
}

void modifyprimoindex(int newindex){
    primoindice=newindex;
    notifyListeners();
}

void modifyi(int newi){
    i=newi;
    notifyListeners();
}


}