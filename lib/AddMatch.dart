import 'package:flutter/material.dart';

class AddMatch extends StatefulWidget {
  final db;
  AddMatch(this.db);
  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  _AddMatch createState() => _AddMatch();
}

class _AddMatch extends State<AddMatch> {
  var staduimcontroller = TextEditingController(),
      resultcontroller = TextEditingController();
  var teams;
  var dropitems1;
  var dropitems2;
  var _selectedteam1;
  var _selectedteam2;
  DateTime date;
  TimeOfDay time;
  var fulldate;
  @override
  void initState() {
    super.initState();
    getteams();
  }

  getteams() async {
    var tempteams =
        await widget.db.query('SELECT Name,league_division,Country From Team;');
    setState(() {
      this.teams = tempteams.map((v) => v);
      this.dropitems1 = tempteams.map(
          (v) => v['Name'] + "," + v['league_division'] + "," + v['Country']);
      this.dropitems2 = tempteams.map(
          (v) => v['Name'] + "," + v['league_division'] + "," + v['Country']);
    });
  }

  query() async {
    this.fulldate = new DateTime(
        date.year, date.month, date.day, time.hour, time.minute, date.second);

    var temp1 = _selectedteam1.split(',');
    var temp2 = _selectedteam2.split(',');
    widget.db.insert('''INSERT INTO Match(Match_Date,Stadium,
    results,team_country,team_name,team_league_division,
    team2_country,team2_name,team2_league_division)
        VALUES("${this.fulldate}",
        "${staduimcontroller.text}",
        "${resultcontroller.text}","${temp1[2]}",
        "${temp1[0]}","${temp1[1]}"
        ,"${temp2[2]}","${temp2[0]}",
        "${temp2[1]}")''');
  }

  alert() {
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

  Dropdown2() {
    if (this.teams != null) {
      return Container(
          width: double.infinity,
          child: DropdownButton<String>(
            hint: Text(
              "Select Team2",
              style: TextStyle(color: Colors.black),
            ),
            value: _selectedteam2,
            onChanged: (String value) {
              if (_selectedteam1 != null) {
                setState(() {
                  _selectedteam2 = value;
                });
                // if (dropitems2.length != 1)
                //   dropitems1 = dropitems2.where((row) => row != _selectedteam2);
              } else {
                return (showDialog<String>(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                          title: const Text('Error'),
                          content: Text('Select team1 first'),
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
                        )));
              }
            },
            items: dropitems2.map<DropdownMenuItem<String>>((row) {
              return DropdownMenuItem<String>(
                value: row,
                child: Row(
                  children: <Widget>[
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      row,
                      style: TextStyle(color: Colors.black),
                    ),
                  ],
                ),
              );
            }).toList(),
          ));
    } else
      return (Text("No teams Existed"));
  }

  Dropdown1() {
    if (this.teams != null) {
      return Container(
          width: double.infinity,
          child: DropdownButton<String>(
            hint: Text(
              "Select Team1",
              style: TextStyle(color: Colors.black),
            ),
            value: _selectedteam1,
            onChanged: (String value) {
              setState(() {
                _selectedteam1 = value;
              });
              if (dropitems1.length != 1) {
                dropitems2 = dropitems1.map((v) => v);
                _selectedteam2 = null;
                dropitems2 = dropitems1.where((row) => row != _selectedteam1);
              }
              print(_selectedteam1);
              print(dropitems2);
            },
            items: dropitems1.map<DropdownMenuItem<String>>((row) {
              return DropdownMenuItem<String>(
                value: row,
                child: Row(
                  children: <Widget>[
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      row,
                      style: TextStyle(color: Colors.black),
                    ),
                  ],
                ),
              );
            }).toList(),
          ));
    } else
      return (Text("No teams Existed"));
  }

  // changeID(String iDcontroller){
  //   setState(() {
  //     iD=this.iDcontroller.text;
  //   });
  // }
  showdate() {
    showDatePicker(
            context: context,
            initialDate: DateTime.utc(2020, 9, 5),
            firstDate: DateTime(2018),
            lastDate: DateTime.now())
        .then((value) {
      if (value == null) {
        return;
      } else {
        setState(() {
          this.date = value;
        });

        print(date);
      }
    });
  }

  showtime() {
    showTimePicker(
            context: context, initialTime: TimeOfDay(hour: 00, minute: 00))
        .then((value) {
      if (value == null)
        return;
      else
        setState(() {
          this.time = value;
        });

      print(time);
    });
  }

  @override
  Widget build(BuildContext context) {
    return (Scaffold(
      appBar: AppBar(
        title: Text("Add Match"),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Dropdown1(),
              SizedBox(
                height: 10,
              ),
              Dropdown2(),
              SizedBox(
                height: 10,
              ),
              Text(
                "Staduim ",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextField(
                controller: staduimcontroller,
                decoration: InputDecoration(
                  labelText: "Staduim",
                  labelStyle: TextStyle(
                    fontSize: 20,
                  ),
                  hintText: "Enter Staduim",
                ),
                // onChanged: ()=>changeID(iDcontroller),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "results ",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextField(
                controller: resultcontroller,
                decoration: InputDecoration(
                  labelText: "results",
                  labelStyle: TextStyle(
                    fontSize: 20,
                  ),
                  hintText: "Enter results",
                ),
              ),
              SizedBox(
                height: 10,
              ),
              MaterialButton(
                onPressed: () => showdate(),
                child: Column(children: [
                  Text('Pick date'),
                  this.date != null ? Text(this.date.toString()) : Text(""),
                ]),
              ),
              SizedBox(
                height: 10,
              ),
              MaterialButton(
                onPressed: () => showtime(),
                child: Column(children: [
                  Text('Pick time'),
                  this.time != null ? Text(this.time.toString()) : Text(""),
                ]),
              )
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
