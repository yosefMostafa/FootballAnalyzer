
import 'search.dart';
import 'package:flutter/material.dart';
import 'Playerstatschange.dart';


class Matchplayersoverview extends StatefulWidget {
  
  final db,matchDate,teamname,teamleague,teamcountry;
  Matchplayersoverview(this.db,this.matchDate,this.teamname,this.teamleague,this.teamcountry);
  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  _Matchplayersoverview createState() => _Matchplayersoverview();
}

class _Matchplayersoverview extends State<Matchplayersoverview> {
  var searchtype='Name';
  var players;
  var todraw;
  @override
  void initState() {
    super.initState();
    getplayers();
  }
  getplayers()async{
    var temp = await widget.db
        .query('''SELECT Player_ID,Name,Age From Player 
        where team_name="${widget.teamname}" And 
        team_league_division="${widget.teamleague}" 
        And team_country="${widget.teamcountry}"''');
        setState(() {
          this.players=temp.map((v)=>v);
          this.todraw=temp.map((v)=>v);
        });
  }
 result(List<String> newdata){
  setState(() {
    todraw=List.from(newdata);
  });
 }
List<Widget> draw(BuildContext ctx){
  if(todraw!=null)
 return todraw
              ?.map<Widget>(
                  (row) => info(ctx, row['Name'], row['Age'], row['Player_ID']))
              ?.toList() ??
          [];
 return [Text("no Players To be viewed try change team ")];

}

  void navigate(BuildContext ctx, int ssn, final matchDate) {
    Navigator.of(ctx).push(MaterialPageRoute(builder: (_) {
     return Playerstatschange(widget.db,ssn,matchDate);
    }));
  }

  Widget info(BuildContext ctx, String name, int age, int ssn) {
    return Container(
      padding: EdgeInsets.all(15),
      child: InkWell(
        onTap: () => navigate(ctx, ssn, widget.matchDate),
        child: Text(
          name + "   " + age.toString(),
          style: TextStyle(fontSize: 30),
        ),
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
    return (Scaffold(
      appBar: AppBar(
        title: Stack(children: [
        
        Search(this.players,this.result,this.searchtype),
      ]
      ),),
      body:Container(
      padding: EdgeInsets.only(top: 10),
      child: GridView(
          children:draw(context),
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            mainAxisExtent: MediaQuery.of(context).size.height / 4,
            childAspectRatio: 3 / 2,
            crossAxisSpacing: 15,
            mainAxisSpacing: 15,
            maxCrossAxisExtent: MediaQuery.of(context).size.width / 2,
          )),
    ),
    // floatingActionButton: FloatingActionButton.extended(
    //       onPressed: () => {}, label: Text("Add Match"),
    //       backgroundColor: Colors.black,
    //       icon: Icon(Icons.add,color: Colors.red,),
    //       ),
    ));
  }
}
