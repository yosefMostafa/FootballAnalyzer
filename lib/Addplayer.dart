import 'package:flutter/material.dart';


class Addplayer extends StatefulWidget {
  final db,team;
  Addplayer(this.db,this.team);
  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  _Addplayer createState() => _Addplayer();
}

class _Addplayer extends State<Addplayer> {
  var exerciesecontroller = TextEditingController(),
      iDcontroller = TextEditingController(),
      namecontroller = TextEditingController(),
      nationalitycontroller = TextEditingController(),
      valuecontroller = TextEditingController(),
      agecontroller = TextEditingController();
  query() async {
    var temp=widget.team.split(',');
    widget.db.insert('''INSERT INTO Player(Player_ID,Age,
    Name,Nationality,Value,team_country,
    team_name,team_league_division,Exerciese)
        VALUES(${int.parse(iDcontroller.text)},${int.parse(agecontroller.text)},
        "${namecontroller.text}","${nationalitycontroller.text}",
        ${int.parse(valuecontroller.text)},"${temp[2]}"
        ,"${temp[0]}","${temp[1]}",
        "${exerciesecontroller.text}")''');
   
  }

  alert()  {
    query();
    var flag = true;
    return (showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Query Result'),
        content: flag ? Text('Added') : Text('Error while adding'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 'Cancel'),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, 'OK'),
            child: const Text('OK'),
          ),
        ],
      ),
    ));
  }

  // changeID(String iDcontroller){
  //   setState(() {
  //     iD=this.iDcontroller.text;
  //   });
  // }
  @override
  Widget build(BuildContext context) {
    return (Scaffold(
      appBar: AppBar(
        title: Text("Add Coach"),
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
                "ID ",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextField(
                controller: iDcontroller,
                decoration: InputDecoration(
                  labelText: "ID",
                  labelStyle: TextStyle(
                    fontSize: 20,
                  ),
                  hintText: "Enter ID",
                ),
                // onChanged: ()=>changeID(iDcontroller),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Name ",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextField(
                controller: namecontroller,
                decoration: InputDecoration(
                  labelText: "Name",
                  labelStyle: TextStyle(
                    fontSize: 20,
                  ),
                  hintText: "Enter Name",
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Nationality ",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextField(
                controller: nationalitycontroller,
                decoration: InputDecoration(
                  labelText: "Nationality",
                  labelStyle: TextStyle(
                    fontSize: 20,
                  ),
                  hintText: "Enter Nationality",
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "value ",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextField(
                controller: valuecontroller,
                decoration: InputDecoration(
                  labelText: "Value",
                  labelStyle: TextStyle(
                    fontSize: 20,
                  ),
                  hintText: "Enter Value",
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Age ",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextField(
                controller: agecontroller,
                decoration: InputDecoration(
                  labelText: "Age",
                  labelStyle: TextStyle(
                    fontSize: 20,
                  ),
                  hintText: "Enter Age",
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Exerciese ",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextField(
                controller: exerciesecontroller,
                decoration: InputDecoration(
                  labelText: "exerciese",
                  labelStyle: TextStyle(
                    fontSize: 20,
                  ),
                  hintText: "Enter exerciese",
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => alert(),
        label: Text("Add"),
        backgroundColor: Colors.black,
        icon: Icon(
          Icons.add,
          color: Colors.red,
        ),
      ),
    ));
  }
}
