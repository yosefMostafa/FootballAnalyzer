import 'package:flutter/material.dart';

class Playerstatschange extends StatefulWidget {
  final db, iD, matchDate;
  Playerstatschange(this.db, this.iD, this.matchDate);
  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  _Playerstatschange createState() => _Playerstatschange();
}

class _Playerstatschange extends State<Playerstatschange> {
  var usercontroller = TextEditingController();
  var shots = TextEditingController();
  var passes = TextEditingController();
  var saves = TextEditingController();
  var goals = TextEditingController();
  var dribbles = TextEditingController();
  var assissts = TextEditingController();
  var rating = TextEditingController();
  var minutesplayed = TextEditingController();
  var cards = TextEditingController();
  var tackles = TextEditingController();
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
  getStats() async {
    await widget.db
        .insert('''Insert Into Player_Statistics (Player_ID,Match_Date)
    Values (${widget.iD},"${widget.matchDate}") ''');
    var temp2 = await widget.db.query('''SELECT * From Match''');
    print(temp2);
    var temp = await widget.db.query('''SELECT * From Player_Statistics 
        where Player_ID=${widget.iD} And 
        Match_Date="${widget.matchDate}"''');
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

  changeShots() {
    widget.db.query('''Update Player_Statistics 
        set Shots="${shots.text}" 
        where Player_ID=${widget.iD} And Match_Date="${widget.matchDate}"''');
  }

  changepasses() {
    widget.db.query('''Update Player_Statistics 
        set passes="${passes.text}" 
        where Player_ID=${widget.iD} And Match_Date="${widget.matchDate}"''');
  }

  changesaves() {
    widget.db.query('''Update Player_Statistics 
        set saves="${saves.text}" 
        where Player_ID=${widget.iD} And Match_Date="${widget.matchDate}"''');
  }

  changegoals() {
    widget.db.query('''Update Player_Statistics 
        set goals="${goals.text}" 
        where Player_ID=${widget.iD} And Match_Date="${widget.matchDate}"''');
  }

  changedribbles() {
    widget.db.query('''Update Player_Statistics 
        set dribbles="${dribbles.text}" 
        where Player_ID=${widget.iD} And Match_Date="${widget.matchDate}"''');
  }

  changeassissts() {
    widget.db.query('''Update Player_Statistics 
        set assissts="${assissts.text}" 
        where Player_ID=${widget.iD} And Match_Date="${widget.matchDate}"''');
  }

  changerating() {
    widget.db.query('''Update Player_Statistics 
        set rating="${rating.text}" 
        where Player_ID=${widget.iD} And Match_Date="${widget.matchDate}"''');
  }

  changeminutesplayed() {
    widget.db.query('''Update Player_Statistics 
        set minutes_played="${minutesplayed.text}" 
        where Player_ID=${widget.iD} And Match_Date="${widget.matchDate}"''');
  }

  changecards() {
    widget.db.query('''Update Player_Statistics 
        set cards="${cards.text}" 
        where Player_ID=${widget.iD} And Match_Date="${widget.matchDate}"''');
  }

  changetackles() {
    widget.db.query('''Update Player_Statistics 
        set tackles="${tackles.text}" 
        where Player_ID=${widget.iD} And Match_Date="${widget.matchDate}"''');
  }
refresh()async{
  getStats();
}
  @override
  Widget build(BuildContext context) {
    return (RefreshIndicator(
      onRefresh: ()=>refresh(),
        child: Scaffold(
            appBar: AppBar(
              title: Text("Player Stats"),
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
                      "Shots ${this.data['Shots']}",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextField(
                      controller: shots,
                      decoration: InputDecoration(
                        labelText: "Shots",
                        labelStyle: TextStyle(
                          fontSize: 20,
                        ),
                        hintText: "Enter Shots",
                        suffixIcon: IconButton(
                          icon: Icon(Icons.add),
                          onPressed: () => changeShots(),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "passes ${this.data['passes']}",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextField(
                      controller: passes,
                      decoration: InputDecoration(
                        labelText: "passes",
                        labelStyle: TextStyle(
                          fontSize: 20,
                        ),
                        hintText: "Enter passes",
                        suffixIcon: IconButton(
                          icon: Icon(Icons.add),
                          onPressed: () => changepasses(),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "saves ${this.data['saves']}",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextField(
                      controller: saves,
                      decoration: InputDecoration(
                        labelText: "saves",
                        labelStyle: TextStyle(
                          fontSize: 20,
                        ),
                        hintText: "Enter saves",
                        suffixIcon: IconButton(
                          icon: Icon(Icons.add),
                          onPressed: () => changesaves(),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "goals ${this.data['goals']}",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextField(
                      controller: goals,
                      decoration: InputDecoration(
                        labelText: "goals",
                        labelStyle: TextStyle(
                          fontSize: 20,
                        ),
                        hintText: "Enter goals",
                        suffixIcon: IconButton(
                          icon: Icon(Icons.add),
                          onPressed: () => changegoals(),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "dribbles ${this.data['dribbles']}",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextField(
                      controller: dribbles,
                      decoration: InputDecoration(
                        labelText: "dribbles",
                        labelStyle: TextStyle(
                          fontSize: 20,
                        ),
                        hintText: "Enter dribbles",
                        suffixIcon: IconButton(
                          icon: Icon(Icons.add),
                          onPressed: () => changedribbles(),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "assissts ${this.data['assissts']}",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextField(
                      controller: assissts,
                      decoration: InputDecoration(
                        labelText: "assissts",
                        labelStyle: TextStyle(
                          fontSize: 20,
                        ),
                        hintText: "Enter assissts",
                        suffixIcon: IconButton(
                          icon: Icon(Icons.add),
                          onPressed: () => changeassissts(),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "rating ${this.data['rating']}",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextField(
                      controller: rating,
                      decoration: InputDecoration(
                        labelText: "rating",
                        labelStyle: TextStyle(
                          fontSize: 20,
                        ),
                        hintText: "Enter rating",
                        suffixIcon: IconButton(
                          icon: Icon(Icons.add),
                          onPressed: () => changerating(),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "minutes played ${this.data['minutes_played']}",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextField(
                      controller: minutesplayed,
                      decoration: InputDecoration(
                        labelText: "minutes played",
                        labelStyle: TextStyle(
                          fontSize: 20,
                        ),
                        hintText: "Enter minutes played",
                        suffixIcon: IconButton(
                          icon: Icon(Icons.add),
                          onPressed: () => changeminutesplayed(),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "cards ${this.data['cards']}",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextField(
                      controller: cards,
                      decoration: InputDecoration(
                        labelText: "cards",
                        labelStyle: TextStyle(
                          fontSize: 20,
                        ),
                        hintText: "Enter cards",
                        suffixIcon: IconButton(
                          icon: Icon(Icons.add),
                          onPressed: () => changecards(),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "tackles ${this.data['tackles']}",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextField(
                      controller: tackles,
                      decoration: InputDecoration(
                        labelText: "tackles",
                        labelStyle: TextStyle(
                          fontSize: 20,
                        ),
                        hintText: "Enter tackles",
                        suffixIcon: IconButton(
                          icon: Icon(Icons.add),
                          onPressed: () => changetackles(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ))));
  }
}
