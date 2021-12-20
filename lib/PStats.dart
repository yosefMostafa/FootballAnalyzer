import 'package:flutter/material.dart';

class Playerstats extends StatefulWidget {
  final iD;
  final db,matchdate;
  Playerstats(this.db,this.iD,this.matchdate);
  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".
  @override
  _Playerstats createState() => _Playerstats();
}

class _Playerstats extends State<Playerstats> {
  void initState() {
    super.initState();
    getStats();
  }

  var data = {
    'Shots': 0,
    'passes': 0,
    'saves': 0,
    'goals': 0,
    'dribbles': 0,
    'assissts': 0,
    'rating': 0,
    'minutes_played': 0,
    'cards': 0,
    'tackles': 0,
  };
  getStats()async{
var temp = await widget.db.query('''SELECT * From Player_Statistics 
        where Player_ID=${widget.iD} And 
        Match_Date="${widget.matchdate}"''');
        print(temp);
        setState(() {
      this.data['Shots'] = temp[0]['Shots'];
      this.data['passes'] = temp[0]['passes'];
      this.data['saves'] = temp[0]['saves'];
      this.data['goals'] = temp[0]['goals'];
      this.data['dribbles'] = temp[0]['dribbles'];
      this.data['assissts'] = temp[0]['assissts'];
      this.data['rating'] = temp[0]['rating'];
      this.data['minutes_played'] = temp[0]['minutes_played'];
      this.data['cards'] = temp[0]['cards'];
      this.data['tackles'] = temp[0]['tackles'];
    });
  }
  @override
  Widget build(BuildContext context) {
    return (Scaffold(
        appBar: AppBar(
          title: Text("stats"),
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
                  "Passes ${this.data['passes'] }",
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
                  "Shots ${ this.data['Shots']}",
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
                  "Goals ${this.data['goals']}",
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
                  "Assists ${ this.data['assissts']}",
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
                  "Dribbles ${this.data['dribbles']}",
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
                  "Rattings ${ this.data['rating']}",
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
                  "Mins playing ${ this.data['minutes_played']}",
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
                  "Cards ${this.data['cards']}",
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
                  "Tackles ${ this.data['tackles']}",
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
                  "Saves ${ this.data['saves']}",
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
