import 'package:flutter/material.dart';
import 'Matchplayersoverview.dart';

class SelectTeam extends StatefulWidget {
  final matchDate, db;
  SelectTeam(this.matchDate, this.db);
  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  _SelectTeam createState() => _SelectTeam();
}

class _SelectTeam extends State<SelectTeam> {
  var teams = {
    'teamname1': '',
    'teamleague1': '',
    'teamcountry1': '',
    'teamname2': '',
    'teamleague2': '',
    'teamcountry2': '',
  };

  @override
  void initState() {
    super.initState();
    getteams();
  }

  getteams() async {
    var temp = await widget.db
        .query('SELECT * From Match where Match_Date="${widget.matchDate}"');
    setState(() {
      this.teams['teamname1'] = temp[0]['team_name'];
      this.teams['teamleague1'] = temp[0]['team_league_division'];
      this.teams['teamcountry1'] = temp[0]['team_country'];
      this.teams['teamname2'] = temp[0]['team2_name'];
      this.teams['teamleague2'] = temp[0]['team2_league_division'];
      this.teams['teamcountry2'] = temp[0]['team2_country'];
    });
  }

  void navigate(BuildContext ctx, String matchDate, 
  String teamname,String teamleague,String teamcountry) {
    Navigator.of(ctx).push(MaterialPageRoute(builder: (_) {
      return Matchplayersoverview(widget.db,matchDate, teamname,teamleague,teamcountry);
    }));
  }

  Widget info(
    BuildContext ctx,
    String teamname,String teamleague,String teamcountry
  ) {
    return Container(
      padding: EdgeInsets.all(15),
      child: InkWell(
        onTap: () => navigate(ctx, widget.matchDate,teamname,teamleague,teamcountry ),
        child: Column(children:[
          Text(
          teamname ,
          style: TextStyle(fontSize: 30),
        ),
        Text(
          teamleague ,
          style: TextStyle(fontSize: 15),
        ),
        Text(
          teamcountry ,
          style: TextStyle(fontSize: 15),
        ),
      ]
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

  @override
  Widget build(BuildContext context) {
    return (Scaffold(
      appBar: AppBar(
        title: Text("Player change"),
      ),
      body: Container(
        padding: EdgeInsets.only(top: 10),
        child: GridView(
            children: [
              info(context, this.teams['teamname1'],
              this.teams['teamleague1'],this.teams['teamcountry1']),
              info(context, this.teams['teamname2'],
              this.teams['teamleague2'],this.teams['teamcountry2']),
            ],
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              mainAxisExtent: MediaQuery.of(context).size.height / 4,
              childAspectRatio: 3 / 2,
              crossAxisSpacing: 15,
              mainAxisSpacing: 15,
              maxCrossAxisExtent: MediaQuery.of(context).size.width / 2,
            )),
      ),
      // floatingActionButton: FloatingActionButton.extended(
      //   onPressed: () => {},
      //   label: Text("Add Player"),
      //   backgroundColor: Colors.black,
      //   icon: Icon(
      //     Icons.add,
      //     color: Colors.red,
      //   ),
      // ),
    ));
  }
}
