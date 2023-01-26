//import 'package:flutter/src/widgets/container.dart';
//import 'package:flutter/src/widgets/framework.dart';

import 'package:flutter/material.dart';
import 'allCS.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  //sbool firstTime = true;
  List signatureStrengths = [];
  List coveredVirtues = [];
 
  @override
  Widget build(BuildContext context) {
    //sort the lists alphabetically
    signatureStrengths.sort((a, b) => a.compareTo(b));
    coveredVirtues.sort((a, b) => a.compareTo(b));
    //delete duplicates from virtue list; didn't work yet
    coveredVirtues = coveredVirtues.toSet().toList();

    return Scaffold(
      backgroundColor: Colors.lightBlue[50],
      appBar: AppBar(
        title: const Text('Home Page'),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            const Text(
              'Your Favorite Character Strengths:',
              style: TextStyle(fontSize: 25, color: Colors.black),),
            SizedBox(
              height: 250,
              child: ListView.builder(
                itemCount: signatureStrengths.length,
                itemBuilder: (context_2, indexHome) {
                  return Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: Text(
                    '- ${signatureStrengths[indexHome]}',
                    style: TextStyle(fontSize: 23, color: Colors.grey[800])
                    ),
                  );
              } ,
            ),), 
            const Text(
              'Your strengths cover the following virtues:',
              style: TextStyle(fontSize: 21, color: Colors.black),),
            SizedBox(
              height: 180,
              child: ListView.builder(
                itemCount: coveredVirtues.length,
                itemBuilder: (context_3, indexHome_2) {
                  return Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: Text(
                    '- ${coveredVirtues[indexHome_2]}',
                    style: TextStyle(fontSize: 20, color: Colors.grey[800])
                    ),
                  );
              } ,
            ),), 
            //in case all virtues are covered
            Visibility(
              child: Text(
                'congratulations, you covered all virtues!',
                style: TextStyle(fontSize: 30, color: Colors.pink),
              ),
              visible: coveredVirtues.length == 6,
            ),       
            SizedBox(
              height: 60,
              child: TextButton(
                onPressed: () async {
                  dynamic result = await Navigator.push(context, 
                    MaterialPageRoute(
                      builder: ((context) => CharacterStrengths(signatureStrengths: signatureStrengths, coveredVirtues: coveredVirtues)),
                      settings: RouteSettings(name: '/allCS'),
                    )
                  );
                  setState(() {
                    if (result != null) {
                      signatureStrengths = result['signatureStrengths'];
                    }       
                  }); 
                }, 
                child: const Text('show me all character strengths')
              ),
            )
            
        
        ],
      ),),
    );
  }
}