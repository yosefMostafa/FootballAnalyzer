import 'package:flutter/material.dart';

class Coachstatschange extends StatefulWidget {
  final iD, db;
  Coachstatschange(this.iD, this.db);
  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  _Coachstatschange createState() => _Coachstatschange();
}

class _Coachstatschange extends State<Coachstatschange> {
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
  var name = TextEditingController();
  var nationality = TextEditingController();
  var awards = TextEditingController();
  var age = TextEditingController();
  var formation = TextEditingController();
  var gameplan = TextEditingController();
  var instructions = TextEditingController();
  var roles = TextEditingController();
  @override
  void initState() {
    super.initState();
    getcoachdata();
  }

  getcoachdata() async {
    var tempdata =
        await widget.db.query('SELECT * From coach where ID=${widget.iD};');
    // print(tempdata);
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

  changename() {
    widget.db
        .query('Update coach set name="${name.text}" where ID=${widget.iD}');
  }

  changeNationailty() {
    widget.db.query(
        'Update coach set Nationailty="${nationality.text}" where ID=${widget.iD}');
  }

  changeawards() {
    widget.db.query(
        'Update coach set Awards="${awards.text}" where ID=${widget.iD}');
  }

  changeage() {
    widget.db.query(
        'Update coach set Age=${int.parse(age.text)} where ID=${widget.iD}');
  }

  changeformation() {
    widget.db.query(
        'Update coach set formation="${formation.text}" where ID=${widget.iD}');
  }

  changegameplan() {
    widget.db.query(
        'Update coach set game_plan="${gameplan.text}" where ID=${widget.iD}');
  }

  changeroles() {
    widget.db
        .query('Update coach set roles="${roles.text}" where ID=${widget.iD}');
  }

  changeinstructions() {
    widget.db.query(
        'Update coach set instructions="${instructions.text}" where ID=${widget.iD}');
  }

  refresh() async {
    getcoachdata();
  }

  var usercontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return (Scaffold(
        appBar: AppBar(
          title: Text("Coach stats"),
        ),
        body: RefreshIndicator(
            onRefresh: () => refresh(),
            child: SingleChildScrollView(
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Name ${this.data['name']}",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextField(
                      controller: name,
                      decoration: InputDecoration(
                        labelText: "name",
                        labelStyle: TextStyle(
                          fontSize: 20,
                        ),
                        hintText: "Enter name",
                        suffixIcon: IconButton(
                          icon: Icon(Icons.add),
                          onPressed: () => changename(),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Nationality ${this.data['Nationailty']}",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextField(
                      controller: nationality,
                      decoration: InputDecoration(
                        labelText: "Nationailty",
                        labelStyle: TextStyle(
                          fontSize: 20,
                        ),
                        hintText: "Enter Nationailty",
                        suffixIcon: IconButton(
                          icon: Icon(Icons.add),
                          onPressed: () => changeNationailty(),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Awards ${this.data['Awards']}",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextField(
                      controller: awards,
                      decoration: InputDecoration(
                        labelText: "Awards",
                        labelStyle: TextStyle(
                          fontSize: 20,
                        ),
                        hintText: "Enter Awards",
                        suffixIcon: IconButton(
                          icon: Icon(Icons.add),
                          onPressed: () => changeawards(),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Age ${this.data['Age']}",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextField(
                      controller: age,
                      decoration: InputDecoration(
                        labelText: "Age",
                        labelStyle: TextStyle(
                          fontSize: 20,
                        ),
                        hintText: "Enter Age",
                        suffixIcon: IconButton(
                          icon: Icon(Icons.add),
                          onPressed: () => changeage(),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Formation ${this.data['formation']}",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextField(
                      controller: formation,
                      decoration: InputDecoration(
                        labelText: "Formation",
                        labelStyle: TextStyle(
                          fontSize: 20,
                        ),
                        hintText: "Enter Formation",
                        suffixIcon: IconButton(
                          icon: Icon(Icons.add),
                          onPressed: () => changeformation(),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Game plan ${this.data['game_plan']}",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextField(
                      controller: gameplan,
                      decoration: InputDecoration(
                        labelText: "Game plan",
                        labelStyle: TextStyle(
                          fontSize: 20,
                        ),
                        hintText: "Enter Game plan",
                        suffixIcon: IconButton(
                          icon: Icon(Icons.add),
                          onPressed: () => changegameplan(),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Roles ${this.data['roles']}",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextField(
                      controller: roles,
                      decoration: InputDecoration(
                        labelText: "Roles",
                        labelStyle: TextStyle(
                          fontSize: 20,
                        ),
                        hintText: "Enter Roles",
                        suffixIcon: IconButton(
                          icon: Icon(Icons.add),
                          onPressed: () => changeroles(),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Instructions ${this.data['instructions']}",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextField(
                      controller: instructions,
                      decoration: InputDecoration(
                        labelText: "Instructions",
                        labelStyle: TextStyle(
                          fontSize: 20,
                        ),
                        hintText: "Enter Instructions",
                        suffixIcon: IconButton(
                          icon: Icon(Icons.add),
                          onPressed: () => changeinstructions(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ))));
  }
}
