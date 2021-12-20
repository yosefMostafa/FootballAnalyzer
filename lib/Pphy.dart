import 'package:flutter/material.dart';

class Playerphy extends StatefulWidget {
  final iD, db;
  Playerphy(this.iD, this.db);
  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  _Playerphy createState() => _Playerphy();
}

class _Playerphy extends State<Playerphy> {
  var data = {
    'player_Age': 0,
    'player_Height': 0,
    'player_Weight': 0,
    'muscles_percentage': 0,
    'pace': 0,
    'jumping': 0,
    'felexability': 0,
    'stamina': 0,
    'Coach_exercies': '',
  };
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getphy();
  }

  getphy() async {
    var temp = await widget.db.query('''Select * from Player_physical 
where Player_ID=${widget.iD}''');
    setState(() {
      this.data['player_Age'] = temp[0]['player_Age'];
      this.data['player_Height'] = temp[0]['player_Height'];
      this.data['player_Weight'] = temp[0]['player_Weight'];
      this.data['muscles_percentage'] = temp[0]['muscles_percentage'];
      this.data['pace'] = temp[0]['pace'];
      this.data['jumping'] = temp[0]['jumping'];
      this.data['felexability'] = temp[0]['felexability'];
      this.data['stamina'] = temp[0]['stamina'];
      this.data['Coach_exercies'] = temp[0]['Coach_exercies'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return (Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green,
          title: Text("Player phyiscal"),
        ),
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Age ${this.data['player_Age']}",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Divider(color: Colors.black),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Height ${this.data['player_Height']}",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Divider(color: Colors.black),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "wieght ${this.data['player_Weight']}",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Divider(color: Colors.black),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Muscels precentage ${this.data['muscles_percentage']} %",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Divider(color: Colors.black),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Pace ${this.data['pace']}",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Divider(color: Colors.black),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Jumping ${this.data['jumping']}",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Divider(color: Colors.black),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Flexability ${this.data['felexability']}",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Divider(color: Colors.black),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Stamina ${this.data['stamina']}",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Divider(color: Colors.black),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Coach exersize ",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  this.data['Coach_exercies'],
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Divider(color: Colors.black),
              ],
            ),
          ),
        )));
  }
}
