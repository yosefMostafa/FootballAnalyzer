import 'package:flutter/material.dart';
import 'PlayerInfochange.dart';
import 'search.dart';
import 'Addplayer.dart';

class Playeroverviewchange extends StatefulWidget {
  final type, db;
  Playeroverviewchange(this.type, this.db);
  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  _Playeroverviewchange createState() => _Playeroverviewchange();
}

class _Playeroverviewchange extends State<Playeroverviewchange> {
  var dropitems;
  var _selectedteam;
  var searchtype = 'Name';
  var teams;
  var todraw;
  var players;
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
      this.dropitems = tempteams.map(
          (v) => v['Name'] + "," + v['league_division'] + "," + v['Country']);
    });
  }
    getplayers() async {
      var temp = _selectedteam.split(',');
      print(temp);
      var tempplayers = await widget.db.query('''SELECT Name,Age,Player_ID 
From Player
 where team_name="${temp[0]}" And team_league_division="${temp[1]}"
 And team_country="${temp[2]}"''');
 print(tempplayers);
      setState(() {
        this.players=tempplayers.map((v) => v);
        this.todraw=tempplayers.map((v) => v);
    });
  }

  result(var newdata) {
    setState(() {
      todraw = List.from(newdata);
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
      return PlayerInfochange(ssn,widget.db);
    }));
  }

  Widget info(BuildContext ctx, String name, int age, int ssn) {
    return Container(
      padding: EdgeInsets.all(15),
      child: InkWell(
        onTap: () => navigate(ctx, ssn, widget.type),
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

// ignore: non_constant_identifier_names
  Dropdown() {
    if (this.teams != null) {
      return Container(
          width: double.infinity,
          child: DropdownButton<String>(
            hint: Text("Select Team",style: TextStyle(color:Colors.black
            ),),
            value: _selectedteam,
            onChanged: (String value) {
              setState(() {
                _selectedteam = value;
              });
              getplayers();
            },
            items: dropitems.map<DropdownMenuItem<String>>((row) {
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
addplayer(BuildContext ctx) {
  if(_selectedteam==null ){
    return (showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Error'),
        content: Text('Select team first') ,
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
  }else{
    Navigator.of(ctx).push(MaterialPageRoute(builder: (_) {
      return Addplayer(widget.db,_selectedteam);
    }));
  }
  }
   
  refresh()async{
    if(_selectedteam!=null)
      getplayers();
  }
  search(){
    if(this.players!=null){
   return Search(this.players, this.result, this.searchtype);
    }else{
      return Container();
    }
  }
  Widget build(BuildContext context) {
    return (
      RefreshIndicator(
        onRefresh: ()=>refresh(),
      child:Scaffold(
      appBar: AppBar(
         backgroundColor: Colors.white,
          title: Stack(children: [
              Dropdown(),
      ])),
      extendBody: true,
      body: Container(
        child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
                title: Stack(children: [
       search(),
            ])),
            body: Container(
              padding: EdgeInsets.only(top: 10),
              child: GridView(
                  children: draw(context),
                  //  [ info(context, "Player name", 21, 55),
                  //   info(context, "Player name", 21, 52),
                  //   info(context, "Player name", 21, 53),
                  //   info(context, "Player name", 21, 56),
                  //   info(context, "Player name", 21, 95),
                  //   info(context, "Player name", 21, 82),
                  //   info(context, "Player name", 21, 93),
                  //   info(context, "Player name", 21, 32),
                  //   info(context, "Player name", 21, 21),
                  //   info(context, "Player name", 21, 12),
                  // ],
                  gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                    mainAxisExtent: MediaQuery.of(context).size.height / 4,
                    childAspectRatio: 3 / 2,
                    crossAxisSpacing: 15,
                    mainAxisSpacing: 15,
                    maxCrossAxisExtent: MediaQuery.of(context).size.width / 2,
                  )),
            )),
      ),
      //Dropdown(),

      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => addplayer(context),
        label: Text("Add Player"),
        backgroundColor: Colors.black,
        icon: Icon(
          Icons.add,
          color: Colors.red,
        ),
      ),
    )));
  }
}
