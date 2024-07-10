import 'dart:convert';

import 'package:applab/models/doctordatabase.dart';
import 'package:applab/screens/splashscreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:applab/models/patientdatabase.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:applab/providers/indexlistona.dart';
import 'package:applab/providers/modifypatient.dart';


void main() async{

  WidgetsFlutterBinding.ensureInitialized();
  print('Initializing Hive...');
  await Hive.initFlutter();
  print('Hive initialized');

  Hive.registerAdapter(DoctordatabaseAdapter());
  Hive.registerAdapter(PatientdatabaseAdapter());
 
 const secureStorage = FlutterSecureStorage();
  // if key not exists return null
  print('Reading encryption key...');
  final encryptionKeyString = await secureStorage.read(key: 'key');
  if (encryptionKeyString == null) {
    final key = Hive.generateSecureKey();
    await secureStorage.write(
      key: 'key',
      value: base64UrlEncode(key),
    );
    print('New encryption key generated and saved');
  }
  else {
    final key = base64Url.decode(encryptionKeyString);}

  print('Encryption key read successfully');
  final key = await secureStorage.read(key: 'key');
  final encryptionKeyUint8List = base64Url.decode(key!);
print('Opening Hive box...');
  //open a box */
  


  print('Opening Hive box...');
  try {
  var box1 = await Hive.openBox<Doctordatabase>(('doctors') , encryptionCipher: HiveAesCipher(encryptionKeyUint8List));
  var box2 = await Hive.openBox<Patientdatabase>(('patients') , encryptionCipher: HiveAesCipher(encryptionKeyUint8List));

  }catch(e){ print('Error opening Hive box: $e');}
  
  runApp(const MyApp()); 
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: 
    [
    ChangeNotifierProvider(create: (context)=> ModifyPatient()),
     ChangeNotifierProvider(create: (context)=> IndexListona()),
    ],
    
  
      child: MaterialApp(
        home: SplashScreen(),
      ),);
  } //build
}//MyApp