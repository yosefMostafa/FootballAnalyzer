import 'package:flutter/material.dart';

import 'Coachoverview.dart';
import 'Playeroverviewchange.dart';
import 'Match.dart';
import 'Team.dart';

class DataRec extends StatefulWidget {
  // ignore: non_constant_identifier_names
  final Function Signout;
  final iD;
  final type;
  final    db;
  DataRec(this.Signout, this.type, this.iD,this.db);
  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  _DataRec createState() => _DataRec();
}

class _DataRec extends State<DataRec> {
  @override
  Widget build(BuildContext context) {
    return (DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text(
            widget.type,
            textAlign: TextAlign.center,
          ),
          bottom: TabBar(
            tabs: [
              Tab(
                text: "Coach",
              ),
              Tab(
                text: "Player",
              ),
              Tab(
                text: "Match",
              ),
                Tab(
                text: "Team",
              ),

              //Tab(text:"Stats"),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Coachoverview(widget.type,widget.db),
            Playeroverviewchange(widget.type,widget.db),
            Match(widget.type,widget.db),
            Team(widget.type,widget.db),
            //Playeroverview(widget.type),
          ],
        ),
        drawer: Drawer(
          child: Container(
            padding: EdgeInsets.fromLTRB(0, MediaQuery.of(context).padding.top, 0, 0),
            child: Column(
              children: [
                MaterialButton(
                  onPressed: () => widget.Signout(),
                  child: Text('Sign out'),
                  color: Colors.tealAccent,
                  minWidth: double.infinity,
                ),
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
