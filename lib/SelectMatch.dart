import 'package:flutter/material.dart';
import 'PStats.dart';
import 'search.dart';

class SelectMatch extends StatefulWidget {
  final db,iD;
  SelectMatch(this.iD,this.db);
  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  _SelectMatch createState() => _SelectMatch();
}

class _SelectMatch extends State<SelectMatch> {
 var searchtype='Stadium';
var matches;
var todraw;

void initState() {
    super.initState();
    getMatches();
  }
  getMatches()async{
      var tempteam = await widget.db.query('''SELECT team_name,team_country,team_league_division
       from Player where Player_ID=${widget.iD}''');
       var tempmatch=await widget.db.query('''SELECT Match_Date,Stadium,results
       from Match where (team_name="${tempteam[0]['team_name']}" And 
       team_league_division="${tempteam[0]['team_league_division']}" And 
       team_country="${tempteam[0]['team_country']}")OR (team2_name="${tempteam[0]['team_name']}" And 
       team2_league_division="${tempteam[0]['team_league_division']}" And 
       team2_country="${tempteam[0]['team_country']}")''');
       setState(() {
         this.matches=tempmatch.map((v)=>v);
         this.todraw=tempmatch.map((v)=>v);
       });
  }
    result(var newdata){
  setState(() {
    todraw=List.from(newdata);
  });
}
  List<Widget> draw(BuildContext ctx){
 
    if (todraw != null)
 
      return todraw?.map<Widget>((row) => info(ctx,row['Stadium'] ,row['Match_Date'],row['results']))?.toList()??[];
    // ignore: dead_code
    return [Text("no Data To be viewed")];
}
 void navigate(BuildContext ctx, String matchDate) {
    Navigator.of(ctx).push(MaterialPageRoute(builder: (_) {
      return Playerstats(widget.db,widget.iD, matchDate);
    }));
  }
  Widget info(BuildContext ctx, String staduim, String matchDate,String result) {
    return Container(
      padding: EdgeInsets.all(15),
      child: InkWell(
        onTap: () => navigate(ctx, matchDate),
        child:Column(children:[ Text(
          staduim ,
          style: TextStyle(fontSize: 30),
        ),
        Text(
          matchDate ,
          style: TextStyle(fontSize: 20),
        ),
        Text(
          "Match Result= "+result ,
          style: TextStyle(fontSize: 15),
        ),
        ])

      ),
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
    return (
      Scaffold(
        appBar: AppBar( backgroundColor: Colors.green,
          title: Stack(children: [
        
        Search(this.matches,this.result,this.searchtype),
      ])),
        body:Container(
      padding: EdgeInsets.only(top: 10),
      child: GridView(
          children: draw(context)
            // info(context, "Player name", 21, 55),
            // info(context, "Player name", 21, 52),
            // info(context, "Player name", 21, 53),
            // info(context, "Player name", 21, 56),
            // info(context, "Player name", 21, 95),
            // info(context, "Player name", 21, 82),
            // info(context, "Player name", 21, 93),
            // info(context, "Player name", 21, 32),
            // info(context, "Player name", 21, 21),
            // info(context, "Player name", 21, 12),
          ,
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            mainAxisExtent: MediaQuery.of(context).size.height / 4,
            childAspectRatio: 3 / 2,
            crossAxisSpacing: 15,
            mainAxisSpacing: 15,
            maxCrossAxisExtent: MediaQuery.of(context).size.width / 2,
          )),
    )));
  }
}
