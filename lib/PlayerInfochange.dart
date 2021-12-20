import 'package:flutter/material.dart';

class PlayerInfochange extends StatefulWidget {
  final iD,db;
  PlayerInfochange(this.iD,this.db);
  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  _PlayerInfochange createState() => _PlayerInfochange();
}

class _PlayerInfochange extends State<PlayerInfochange> {
 var data = {
    'name': "",
    'Nationailty': "",
    'Age': 0,
    'Value': "",
    'Exerciese': "",
  };
  var name = TextEditingController();
  var nationality = TextEditingController();
  var age = TextEditingController();
  var value = TextEditingController();
  var exerciese = TextEditingController();
  
  @override
  void initState() {
    super.initState();
    getplayerdata();
  }

  getplayerdata() async {
    var tempdata =
        await widget.db.query('SELECT * From Player where Player_ID=${widget.iD};');
    // print(tempdata);
    setState(() {
      this.data['Name'] = tempdata[0]['Name'];
      this.data['Age'] = tempdata[0]['Age'];
      this.data['Nationality'] = tempdata[0]['Nationality'];
      this.data['Value'] = tempdata[0]['Value'];
      this.data['Exerciese'] = tempdata[0]['Exerciese'];
    });
  }

  changename() {
    widget.db
        .query('Update Player set name="${name.text}" where Player_ID=${widget.iD}');
  }

  changeNationailty() {
    widget.db.query(
        'Update Player set Nationality="${nationality.text}" where Player_ID=${widget.iD}');
  }

  changeAge() {
    widget.db.query(
        'Update Player set Age=${int.parse(age.text)} where Player_ID=${widget.iD}');
  }

  changevalue() {
    widget.db.query(
        'Update Player set Value=${int.parse(value.text)} where Player_ID=${widget.iD}');
  }

  changeexerciese() {
    widget.db.query(
        'Update Player set Exerciese="${exerciese.text}" where Player_ID=${widget.iD}');
  }


  refresh() async {
    getplayerdata();
  }

  @override
  Widget build(BuildContext context) {
    return (Scaffold(
        appBar: AppBar(
          title: Text("Player stats"),
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
                      "Name ${this.data['Name']}",
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
                      "Nationality ${this.data['Nationality']}",
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
                      "Value ${this.data['Value']}",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextField(
                      controller: value,
                      decoration: InputDecoration(
                        labelText: "value",
                        labelStyle: TextStyle(
                          fontSize: 20,
                        ),
                        hintText: "Enter value",
                        suffixIcon: IconButton(
                          icon: Icon(Icons.add),
                          onPressed: () => changevalue(),
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
                          onPressed: () => changeAge(),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Exerciese ${this.data['Exerciese']}",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextField(
                      controller: exerciese,
                      decoration: InputDecoration(
                        labelText: "Exerciese",
                        labelStyle: TextStyle(
                          fontSize: 20,
                        ),
                        hintText: "Enter Exerciese",
                        suffixIcon: IconButton(
                          icon: Icon(Icons.add),
                          onPressed: () => changeexerciese(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ))));
  }
}
