import 'package:flutter/material.dart';


class AddTeam extends StatefulWidget {
  final db;
  AddTeam(this.db);
  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  _AddTeam createState() => _AddTeam();
}

class _AddTeam extends State<AddTeam> {
  var 
      countrycontroller = TextEditingController(),
      namecontroller = TextEditingController(),
      trophiescontroller = TextEditingController(),
      stadiumcontroller = TextEditingController(),
      leaguedivisioncontroller = TextEditingController(),
      budgetcontroller = TextEditingController(),
      compeitionscontroller = TextEditingController(),
      coachIDcontroller = TextEditingController();
  query() async {
    widget.db.insert('''INSERT INTO Team(Country,Name,league_division,Trophies,
      Stadium,budget,compeitions,Coach_ID) 
        VALUES("${countrycontroller.text}","${namecontroller.text}",
        "${leaguedivisioncontroller.text}","${trophiescontroller.text}",
        "${stadiumcontroller.text}","${budgetcontroller.text}"
        ,"${compeitionscontroller.text}",${int.parse(coachIDcontroller.text)})''');
   
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
        title: Text("Add Team"),
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
                "Country ",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextField(
                controller: countrycontroller,
                decoration: InputDecoration(
                  labelText: "Country",
                  labelStyle: TextStyle(
                    fontSize: 20,
                  ),
                  hintText: "Enter Country",
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
                "Trophies ",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextField(
                controller: trophiescontroller,
                decoration: InputDecoration(
                  labelText: "Trophies",
                  labelStyle: TextStyle(
                    fontSize: 20,
                  ),
                  hintText: "Enter Trophies",
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Stadium ",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextField(
                controller: stadiumcontroller,
                decoration: InputDecoration(
                  labelText: "Stadium",
                  labelStyle: TextStyle(
                    fontSize: 20,
                  ),
                  hintText: "Enter Stadium",
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "league division ",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextField(
                controller: leaguedivisioncontroller,
                decoration: InputDecoration(
                  labelText: "league division",
                  labelStyle: TextStyle(
                    fontSize: 20,
                  ),
                  hintText: "Enter league division",
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Budget ",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextField(
                controller: budgetcontroller,
                decoration: InputDecoration(
                  labelText: "budget",
                  labelStyle: TextStyle(
                    fontSize: 20,
                  ),
                  hintText: "Enter budget",
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Compeitions",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextField(
                controller: compeitionscontroller,
                decoration: InputDecoration(
                  labelText: "compeitions",
                  labelStyle: TextStyle(
                    fontSize: 20,
                  ),
                  hintText: "Enter compeitions",
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "coach ID ",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextField(
                controller: coachIDcontroller,
                decoration: InputDecoration(
                  labelText: "coach ID",
                  labelStyle: TextStyle(
                    fontSize: 20,
                  ),
                  hintText: "Enter coach ID",
                ),
              ),
              SizedBox(
                height: 10,
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
