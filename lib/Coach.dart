import 'package:flutter/material.dart';
import 'Coachstats.dart';

import 'Playeroverview.dart';

class Coach extends StatefulWidget {
  // ignore: non_constant_identifier_names
  final Function Signout;
  final iD;
  final type,db;
  Coach(this.Signout, this.type, this.iD,this.db);
  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  _Coach createState() => _Coach();
}

class _Coach extends State<Coach> {
  @override
  Widget build(BuildContext context) {
    return (DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green,
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text(
            "Coach name",
            textAlign: TextAlign.center,
          ),
          bottom: TabBar(
            tabs: [
              Tab(
                text: "Players Overview",
              ),
              Tab(text: "Stats"),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Playeroverview(widget.type,widget.db,widget.iD),
            Coachstats(widget.iD,widget.db),
          ],
        ),
        drawer: Drawer(
          child: Container(
            padding: EdgeInsets.fromLTRB(
                0, MediaQuery.of(context).padding.top, 0, 0),
            child: Column(
              children: [
                MaterialButton(
                  onPressed: () => widget.Signout(),
                  child: Text('Sign out'),
                ),
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
