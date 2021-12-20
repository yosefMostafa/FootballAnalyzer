import 'package:flutter/material.dart';

class Playercara extends StatefulWidget {
  final iD, db;
  Playercara(this.iD, this.db);
  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  _Playercara createState() => _Playercara();
}

class _Playercara extends State<Playercara> {
  var data = {
    'team_name': '',
    'team_country': '',
    'team_league_division': '',
    'Age': 0,
    'Name': '',
    'Nationality': '',
    'Value': 0,
  };
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getcara();
  }
  getcara()async{
   var temp=await widget.db.query('''Select * from Player where Player_ID=${widget.iD}''');
   setState(() {
     this.data['team_name']=temp[0]['team_name'];
     this.data['team_country']=temp[0]['team_country'];
     this.data['team_league_division']=temp[0]['team_league_division'];
     this.data['Age']=temp[0]['Age'];
     this.data['Name']=temp[0]['Name'];
     this.data['Nationality']=temp[0]['Nationality'];
     this.data['Value']=temp[0]['Value'];
   });
  }
  @override
  Widget build(BuildContext context) {
    return (Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green,
          title: Text("characteristics"),
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
                  "Team Country  ${this.data['team_country']}",
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
                  "Team name ${ this.data['team_name']}",
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
                  "Team League Division  ${this.data['team_league_division']}",
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
                  "Name  ${this.data['Name']}",
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
                  "Age  ${ this.data['Age']}",
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
                  "Nationality  ${this.data['Nationality']}",
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
                  "Value  ${this.data['Value']}",
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
