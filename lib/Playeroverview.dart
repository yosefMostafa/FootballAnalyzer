import 'package:flutter/material.dart';
import 'PStats.dart';
import 'Pphy.dart';
import 'Pchara.dart';
import 'SelectMatch.dart';

class Playeroverview extends StatefulWidget {
  final type,db,iD;
  Playeroverview(this.type,this.db,this.iD);
  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  _Playeroverview createState() => _Playeroverview();
}

class _Playeroverview extends State<Playeroverview> {
var players;
var todraw;

void initState() {
    super.initState();
    getplayers();
  }
  getplayers()async{
      var tempteam = await widget.db.query('''SELECT Name,Country,league_division
       from Team where Coach_ID=${widget.iD}''');
       var tempplayers=await widget.db.query('''SELECT Name,Age,Player_ID
       from Player where team_name="${tempteam[0]['Name']}" And 
       team_league_division="${tempteam[0]['league_division']}" And 
       team_country="${tempteam[0]['Country']}"''');
       setState(() {
         this.players=tempplayers.map((v)=>v);
         this.todraw=tempplayers.map((v)=>v);
       });
  }

  draw(BuildContext ctx) {
    if (todraw != null)
      return todraw
              ?.map<Widget>(
                  (row) => info(ctx, row['Name'], row['Age'], row['Player_ID']))
              ?.toList() ??
          [];
    return [Text("no Players To be viewed try change team ")];
  }
  void navigate(BuildContext ctx, int ssn, final type) {
    Navigator.of(ctx).push(MaterialPageRoute(builder: (_) {
      if (type == "ECoach") {
         return SelectMatch(ssn,widget.db);
         //Playerstats(ssn, type);
      } else if(type=="EMedical"){
        //return Playerphy(ssn);
      }else{
        // return Playercara(ssn);
      }
    }));
  }

  Widget info(BuildContext ctx, String name, int age, int ssn) {
    return Container(
      padding: EdgeInsets.all(15),
      child: InkWell(
        onTap: () => navigate(ctx, ssn, widget.type),
        child: Column (children:[
          Text(
          name ,
          style: TextStyle(fontSize: 30),
        ),
         Text(
          age.toString(),
          style: TextStyle(fontSize: 20),
        ),
        ])),
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
    return (Container(
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
    ));
  }
}
