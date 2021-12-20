import 'package:flutter/material.dart';
import 'SelectMatch.dart';
import 'Pphy.dart';
import 'Pchara.dart';

class Player extends StatefulWidget {
  // ignore: non_constant_identifier_names
  final Function Signout;
  final iD;
  final type,db;
  Player(this.Signout,this.type,this.iD,this.db);
  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  _Player createState() => _Player();
}

class _Player extends State<Player> {
  var name="";
  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();
    getname();
  }
  getname()async{
    var temp = await widget.db.query('Select Name from Player where Player_ID=${widget.iD}');
    setState(() {
      this.name=temp[0]['Name'];
    });
  }
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(

      length: 3,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green,
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text(
            this.name,
            textAlign: TextAlign.center,
          ),
          bottom: TabBar(
            indicatorColor:Colors.red,
            tabs: [
            Tab(text:"Stats",),
            Tab(text:"Physical"),
            Tab(text:"characteristics"),
          ],),
        ),
        body: TabBarView(children: [
          SelectMatch(widget.iD, widget.db),
          Playerphy(widget.iD,widget.db),
          Playercara(widget.iD,widget.db),
        ],
        ),
        drawer: Drawer(child: Container(
          padding: EdgeInsets.fromLTRB(0, MediaQuery.of(context).padding.top, 0, 0),
          child: Column(
          children: [ MaterialButton(
              onPressed: ()=>widget.Signout(),
              child: Text('Sign out'),
            ),],
        ),),),
      ),
    );
  }
}
