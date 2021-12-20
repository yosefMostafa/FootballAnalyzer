import 'package:flutter/material.dart';
import 'search.dart';
import 'AddTeam.dart';
import 'TeamChange.dart';

class Team extends StatefulWidget {
  final type;
  final db;

  Team(this.type, this.db);
  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  _Team createState() => _Team();
}

class _Team extends State<Team> {
  var searchtype = 'Name';
  var allteams;
  var teams;
  var todraw;

  @override
  void initState() {
    super.initState();
    getteams();
  }

  getteams() async {
    this.allteams =
        await widget.db.query('SELECT Name,league_division,Country From Team;');
    setState(() {
      this.teams = this.allteams.map((v) => v);
      this.todraw = this.allteams.map((v) => v);
    });
  }

  result(var newdata) {
    setState(() {
      todraw = List.from(newdata);
    });
  }

  List<Widget> draw(BuildContext ctx) {
    print(todraw);
    if (todraw != null)
      return todraw
              ?.map<Widget>((row) => info(
                  ctx, row['Name'], row['league_division'], row['Country']))
              ?.toList() ??
          [];
    // ignore: dead_code
    return [Text("no Data To be viewed")];
  }

  addTeam(BuildContext ctx) {
    Navigator.of(ctx).push(MaterialPageRoute(builder: (_) {
      return AddTeam(widget.db);
    }));
  }

  void navigate(BuildContext ctx, String name, String leaguedivision, String country) {
    Navigator.of(ctx).push(MaterialPageRoute(builder: (_) {
      return TeamChange(name,leaguedivision,country, widget.db);
    }));
  }

  Widget info(
      BuildContext ctx, String name, String leaguedivision, String country) {
    return Container(
      padding: EdgeInsets.all(15),
      child: InkWell(
          onTap: () =>navigate(ctx,name,leaguedivision,country),
          child: Column(
            children: [
              Text(
                name ,
                style: TextStyle(fontSize: 30),
              ),
              Text(
                leaguedivision,
                style: TextStyle(fontSize: 20),
              ),
              Text(
                country,
                style: TextStyle(fontSize: 20),
              ),
            ],
          )),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.red,
            Colors.pink,
          ],
        ),
        borderRadius: BorderRadius.circular(30),
      ),
    );
  }

  refresh() async {
    getteams();
  }

  @override
  Widget build(BuildContext context) {
    return (Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Stack(children: [
          Search(this.teams, this.result, this.searchtype),
        ]),
      ),
      body: RefreshIndicator(
          onRefresh: () => refresh(),
          child: Container(
            padding: EdgeInsets.only(top: 10),
            child: GridView(
                children: draw(context),
                //   [ info(context, "coach name", 21, 55),
                //   info(context, "coach name", 21, 52),
                //   info(context, "coach name", 21, 53),
                //   info(context, "coach name", 21, 56),
                //   info(context, "coach name", 21, 95),
                //   info(context, "coach name", 21, 82),
                //   info(context, "coach name", 21, 93),
                //   info(context, "coach name", 21, 32),
                //   info(context, "coach name", 21, 21),
                //   info(context, "coach name", 21, 12),
                // ],
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  mainAxisExtent: MediaQuery.of(context).size.height / 4,
                  childAspectRatio: 3 / 2,
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 15,
                  maxCrossAxisExtent: MediaQuery.of(context).size.width / 2,
                )),
          )),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => addTeam(context),
        label: Text("Add Team"),
        backgroundColor: Colors.black,
        icon: Icon(
          Icons.add,
          color: Colors.red,
        ),
      ),
    ));
  }
}
