import 'package:flutter/material.dart';
import 'SelectTeam.dart';
import 'search.dart';
import 'AddMatch.dart';

class Match extends StatefulWidget {
  final type,db;
  Match(this.type,this.db);
  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  _Match createState() => _Match();
}



class _Match extends State<Match> {
  var searchtype='Stadium';
  var staduims;
  var todraw;

  @override
  void initState() {
    super.initState();
    getstaduims();
  }
  getstaduims() async {
    var temp= await widget.db.query('SELECT Match_Date,Stadium,results From Match;');
    setState(() {
      this.staduims = temp.map((v) => v);
      this.todraw=temp.map((v) => v);
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
      return SelectTeam(matchDate,widget.db);
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
addmatch(BuildContext ctx){
     Navigator.of(ctx).push(MaterialPageRoute(builder: (_) {
      return AddMatch(widget.db);
    }));
}
refresh()async{
  getstaduims();
}
  @override
  Widget build(BuildContext context) {
    return (
      RefreshIndicator(
        onRefresh:()=>refresh(),
     child: Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
          title: Stack(children: [
        
        Search(this.staduims,this.result,this.searchtype),
      ])),
      body: Container(
        padding: EdgeInsets.only(top: 10),
        child: GridView(
             children:draw(context) ,
            //   info(context, "Staduim name", "00/00/0000"),
            //   info(context, "Staduim name", "00/00/0000"),
            //   info(context, "Staduim name", "00/00/0000"),
            //   info(context, "Staduim name", "00/00/0000"),
            //   info(context, "Staduim name", "00/00/0000"),
            //   info(context, "Staduim name", "00/00/0000"),
            //   info(context, "Staduim name", "00/00/0000"),
            //   info(context, "Staduim name", "00/00/0000"),
            //   info(context, "Staduim name", "00/00/0000"),
            //   info(context, "Staduim name", "00/00/0000"),
            //   info(context, "Staduim name", "00/00/0000"),
            //   info(context, "Staduim name", "00/00/0000"),
            //   info(context, "Staduim name", "00/00/0000"),
            // ],
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              mainAxisExtent: MediaQuery.of(context).size.height / 4,
              childAspectRatio: 3 / 2,
              crossAxisSpacing: 15,
              mainAxisSpacing: 15,
              maxCrossAxisExtent: MediaQuery.of(context).size.width / 2,
            )),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => addmatch(context),
        label: Text("Add Match"),
        backgroundColor: Colors.black,
        icon: Icon(
          Icons.add,
          color: Colors.red,
        ),
      ),
    )));
  }
}
