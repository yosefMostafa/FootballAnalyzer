import 'package:flutter/material.dart';

class TeamChange extends StatefulWidget {
  final name, leaguedivision, country, db;
  TeamChange(this.name, this.leaguedivision, this.country, this.db);
  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  _TeamChange createState() => _TeamChange();
}

class _TeamChange extends State<TeamChange> {
  var data = {
    'Coach_ID': 0,
    'compeitions': "",
    'budget': "",
    'Stadium': "",
    'Trophies': "",
    'Coachname': "",
  };
  var coachID = TextEditingController();
  var compeitions = TextEditingController();
  var budget = TextEditingController();
  var stadium = TextEditingController();
  var trophies = TextEditingController();
  var coachname = TextEditingController();
  @override
  void initState() {
    super.initState();
    getTeamdata();
  }

  getTeamdata() async {
    var tempdata = await widget.db.query('''SELECT * 
        From Team 
        where Name="${widget.name}" And league_division="${widget.leaguedivision}" And Country="${widget.country}";''');
    var tempcoachname = await widget.db.query('''SELECT name 
        From coach
        where ID=${tempdata[0]['Coach_ID']};''');
    // print(tempdata);
    setState(() {
      this.data['Coach_ID'] = tempdata[0]['Coach_ID'];
      this.data['compeitions'] = tempdata[0]['compeitions'];
      this.data['budget'] = tempdata[0]['budget'];
      this.data['Stadium'] = tempdata[0]['Stadium'];
      this.data['Trophies'] = tempdata[0]['Trophies'];
      this.data['Coachname'] = tempcoachname[0]['name'];
    });
  }

  changecompeitions() {
    widget.db
        .query('Update Team set compeitions="${compeitions.text}" where Name="${widget.name}" And league_division="${widget.leaguedivision}"And Country="${widget.country}";');
  }

  changeCoachID() {
    widget.db.query(
        'Update Team set Coach_ID=${coachID.text} where Name="${widget.name}" And league_division="${widget.leaguedivision}"And Country="${widget.country}";');
  }

  changebudget() {
    widget.db.query(
        'Update Team set budget="${budget.text}" where Name="${widget.name}" And league_division="${widget.leaguedivision}"And Country="${widget.country}";');
  }

  changestadium() {
    widget.db.query(
        'Update Team set Stadium="${stadium.text}" where Name="${widget.name}" And league_division="${widget.leaguedivision}"And Country="${widget.country}";');
  }
changeTrophies() {
    widget.db.query(
        'Update Team set Trophies="${trophies.text}" where Name="${widget.name}" And league_division="${widget.leaguedivision}"And Country="${widget.country}";');
  }

  refresh() async {
    getTeamdata();
  }

  var usercontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return (Scaffold(
        appBar: AppBar(
          title: Text("Team stats"),
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
                      "Compeitions ${this.data['compeitions']}",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextField(
                      controller: compeitions,
                      decoration: InputDecoration(
                        labelText: "name",
                        labelStyle: TextStyle(
                          fontSize: 20,
                        ),
                        hintText: "Enter compeitions",
                        suffixIcon: IconButton(
                          icon: Icon(Icons.add),
                          onPressed: () => changecompeitions(),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Coach Name ${this.data['Coachname']}",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextField(
                      controller: coachID,
                      decoration: InputDecoration(
                        labelText: "Coach ID",
                        labelStyle: TextStyle(
                          fontSize: 20,
                        ),
                        hintText: "Enter Coach ID",
                        suffixIcon: IconButton(
                          icon: Icon(Icons.add),
                          onPressed: () => changeCoachID(),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "budget ${this.data['budget']}",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextField(
                      controller: budget,
                      decoration: InputDecoration(
                        labelText: "budget",
                        labelStyle: TextStyle(
                          fontSize: 20,
                        ),
                        hintText: "Enter budget",
                        suffixIcon: IconButton(
                          icon: Icon(Icons.add),
                          onPressed: () => changebudget(),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Stadium ${this.data['Stadium']}",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextField(
                      controller: stadium,
                      decoration: InputDecoration(
                        labelText: "Stadium",
                        labelStyle: TextStyle(
                          fontSize: 20,
                        ),
                        hintText: "Enter Stadium",
                        suffixIcon: IconButton(
                          icon: Icon(Icons.add),
                          onPressed: () => changestadium(),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Trophies ${this.data['Trophies']}",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextField(
                      controller: trophies,
                      decoration: InputDecoration(
                        labelText: "Trophies",
                        labelStyle: TextStyle(
                          fontSize: 20,
                        ),
                        hintText: "Enter Trophies",
                        suffixIcon: IconButton(
                          icon: Icon(Icons.add),
                          onPressed: () => changeTrophies(),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            ))));
  }
}
