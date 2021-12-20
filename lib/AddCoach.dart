import 'package:flutter/material.dart';


class AddCoach extends StatefulWidget {
  final db;
  AddCoach(this.db);
  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  _AddCoach createState() => _AddCoach();
}

class _AddCoach extends State<AddCoach> {
  var instructionscontroller = TextEditingController(),
      iDcontroller = TextEditingController(),
      namecontroller = TextEditingController(),
      nationalitycontroller = TextEditingController(),
      awardscontroller = TextEditingController(),
      agecontroller = TextEditingController(),
      formationcontroller = TextEditingController(),
      gameplancontroller = TextEditingController(),
      rolescontroller = TextEditingController();
  query() async {
    widget.db.insert('''INSERT INTO coach(ID,name,age,Nationailty,
      Awards,formation,game_plan,roles,instructions) 
        VALUES(${int.parse(iDcontroller.text)},"${namecontroller.text}",
        ${int.parse(agecontroller.text)},"${nationalitycontroller.text}",
        "${awardscontroller.text}","${formationcontroller.text}"
        ,"${gameplancontroller.text}","${rolescontroller.text}",
        "${instructionscontroller.text}")''');
   
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
                "Awards ",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextField(
                controller: awardscontroller,
                decoration: InputDecoration(
                  labelText: "Awards",
                  labelStyle: TextStyle(
                    fontSize: 20,
                  ),
                  hintText: "Enter Awards",
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
                "Formation ",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextField(
                controller: formationcontroller,
                decoration: InputDecoration(
                  labelText: "Formation",
                  labelStyle: TextStyle(
                    fontSize: 20,
                  ),
                  hintText: "Enter Formation",
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Game plan",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextField(
                controller: gameplancontroller,
                decoration: InputDecoration(
                  labelText: "Game plan",
                  labelStyle: TextStyle(
                    fontSize: 20,
                  ),
                  hintText: "Enter Game plan",
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Roles ",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextField(
                controller: rolescontroller,
                decoration: InputDecoration(
                  labelText: "Roles",
                  labelStyle: TextStyle(
                    fontSize: 20,
                  ),
                  hintText: "Enter Roles",
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Instructions",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextField(
                controller: instructionscontroller,
                decoration: InputDecoration(
                  labelText: "Instructions",
                  labelStyle: TextStyle(
                    fontSize: 20,
                  ),
                  hintText: "Enter Instructions",
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
