import 'package:flutter/material.dart';
import 'package:csv/csv.dart';
import 'package:flutter/services.dart' show rootBundle;

class CharacterStrengths extends StatefulWidget {
  List signatureStrengths;
  List coveredVirtues;
  CharacterStrengths({required this.signatureStrengths, required this.coveredVirtues});


  @override
  State<CharacterStrengths> createState() => _CharacterStrengthsState(signatureStrengths: signatureStrengths, coveredVirtues: coveredVirtues);
}


class _CharacterStrengthsState extends State<CharacterStrengths> {
  List signatureStrengths;
  List coveredVirtues;
  _CharacterStrengthsState({required this.signatureStrengths, required this.coveredVirtues});

  List<List<dynamic>> _data = [];
  bool firstTime = true;
  //List signatureStrengths = [];

  void _loadCSV() async {
    final rawData = await rootBundle.loadString('assets/via_24.csv');
    List<List<dynamic>> listData = const CsvToListConverter().convert(rawData).map((list) => list.map((e) => e == '' ? 'sorry' : e).toList()) .toList();
    //If we don't do anything empty fields are just empty, surprisingly they don't throw any error. 
    //However, we might want to display that there is no information, thus I added the .map() part
    setState(() {
      _data = listData;
    });
    firstTime = false;
  }
  
  @override
  Widget build(BuildContext context) {
    if (firstTime) {_loadCSV();}
    return Scaffold(
      backgroundColor: Colors.lightBlue[50],
      appBar: AppBar(
        title: const Text('character strengths'),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          SizedBox(
            height: 80,
            child: TextButton(
              child: const Text(
                'update your favorite strengths',
                style: TextStyle(fontSize: 25)),
              onPressed: () async {
                Navigator.pop(context, {'signatureStrengths': signatureStrengths, 'coveredVirtues': coveredVirtues});
              }
            ),
          ),
          SizedBox(
            height: 600,
            child: ListView.builder(
              itemCount: _data.length,
              itemBuilder: (_, index_2) {
                return VirtueCard(data: _data, index: index_2, signatureStrengths: signatureStrengths, coveredVirtues: coveredVirtues);
              }
        ),
          )
          
      ],)
      
    );
  }
}


//customized classes to make the main code readerfriendly, each could/should be a separate file

class VirtueCard extends StatefulWidget {
  List<List<dynamic>> data;
  int index;
  List signatureStrengths;
  List coveredVirtues;
  VirtueCard({required this.data , required this.index, required this.signatureStrengths, required this.coveredVirtues});

  @override
  State<VirtueCard> createState() => _VirtueCardState();
}

class _VirtueCardState extends State<VirtueCard> {
  //bool chosenStrength = false;
  bool showInfos = false;

  @override
  Widget build(BuildContext context) {
    bool chosenStrength =  widget.signatureStrengths.contains(widget.data[widget.index][0]);

   return Card(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            //characterstrength
            Text(
              widget.data[widget.index][0].toString(), 
              style: TextStyle(fontSize: 30, color: Colors.grey[800]),
            ),
            //virtue and buttons buttons   
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  widget.data[widget.index][1].toString(), 
                  style: TextStyle(fontSize: 22, color: Colors.grey[500]),
                ),
                TextButton(
                  child: showInfos
                    ? const Text('hide info')
                    : const Text('learn more'),
                  onPressed: () {
                    setState(() {
                      showInfos = !showInfos;
                    });
                  },
                ),
                IconButton(
                  icon: chosenStrength
                    ? const Icon(Icons.favorite, color: Colors.pink,)
                    : const Icon(Icons.favorite_outline, color: Colors.pink,),
                  onPressed: () {                  
                    setState(() {
                      chosenStrength = !chosenStrength;
                      if (chosenStrength) {
                        widget.signatureStrengths.add(widget.data[widget.index][0].toString());
                        widget.coveredVirtues.add(widget.data[widget.index][1].toString());
                      } else {
                        widget.signatureStrengths.remove(widget.data[widget.index][0].toString());
                        widget.coveredVirtues.remove(widget.data[widget.index][1].toString());
                      }
                    });
                  },
                ),
              ]
            ),               
            //further info, if tapped
            Visibility(
              child: Text(
                widget.data[widget.index][2].toString(),
              ),
              visible: showInfos,
            ),
          ]
        ),
      )
    );
  }
}