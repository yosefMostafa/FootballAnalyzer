import 'package:flutter/material.dart';

class Coachstats extends StatefulWidget {
  final iD,db;
  Coachstats(this.iD,this.db);
  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  _Coachstats createState() => _Coachstats();
}
class _Coachstats extends State<Coachstats>{
   var data = {
    'name': "",
    'Nationailty': "",
    'Awards': "",
    'Age': 0,
    'instructions': "",
    'roles': "",
    'formation': "",
    'game_plan': "",
  };
  @override
  void initState() {
    super.initState();
    getcoachdata();
  }

  getcoachdata() async {
    var tempdata =
        await widget.db.query('SELECT * From coach where ID=${widget.iD};');
     print(widget.iD);
    setState(() {
      this.data['name'] = tempdata[0]['name'];
      this.data['Age'] = tempdata[0]['Age'];
      this.data['Nationailty'] = tempdata[0]['Nationailty'];
      this.data['Awards'] = tempdata[0]['Awards'];
      this.data['instructions'] = tempdata[0]['instructions'];
      this.data['roles'] = tempdata[0]['roles'];
      this.data['formation'] = tempdata[0]['formation'];
      this.data['game_plan'] = tempdata[0]['game_plan'];
    });
  }
  @override
  Widget build(BuildContext context) {
    return(SingleChildScrollView(
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10,),
            Text("Name ${this.data['name']}",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,),),
             Divider(
              color: Colors.black
            ),
            SizedBox(height: 10,),
            Text("Nationality ${this.data['Nationailty']}",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,),),
            Divider(
              color: Colors.black
            ),
             SizedBox(height: 10,),
            Text("Awards ${this.data['Awards']}",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,),),
            Divider(
              color: Colors.black
            ),
            SizedBox(height: 10,),
            Text("Age ${this.data['Age']}",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,),),
            Divider(
              color: Colors.black
            ),
            SizedBox(height: 10,),
            Text("Formation ${this.data['formation']}",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,),),
            Divider(
              color: Colors.black
            ),
            SizedBox(height: 10,),
            Text("Game plan ${this.data['game_plan']}",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,),),
            Divider(
              color: Colors.black
            ),
            SizedBox(height: 10,),
            Text("Roles ${this.data['roles']}",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,),),
            Divider(
              color: Colors.black
            ),
            SizedBox(height: 10,),
            Text("Instructions ${this.data['instructions']}",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,),),
         
            
          ],
        ),
      ),
    ));
  }

}