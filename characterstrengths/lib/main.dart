import 'package:flutter/material.dart';
//import 'package:csv/csv.dart';
//import 'package:flutter/services.dart' show rootBundle;
import 'pages/home.dart';
import 'pages/allCS.dart';


void main() {
  List signatureStrengths = [];
  List coveredVirtues = [];
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: '/home',
    routes: {
      '/home':(context) => Home(),
      '/allCS':(context) => CharacterStrengths(signatureStrengths: signatureStrengths, coveredVirtues: coveredVirtues),
    },
  ));
}



/* To-Do's and to-like's
To-Do's finished! :)
Further ideas/to-likes:
- have some reader input
- include the covered virtues, without duplicates
- add a cake diagram of all virtues, covered virtues in different color
- add background info subpage (science behind this)
*/