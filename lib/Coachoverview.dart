import 'package:flutter/material.dart';
import 'Coachstatschange.dart';
import 'search.dart';
import 'AddCoach.dart';

class Coachoverview extends StatefulWidget {
  final type;
  final db;
  
  Coachoverview(this.type, this.db);
  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  _Coachoverview createState() => _Coachoverview();
}

class _Coachoverview extends State<Coachoverview> {
  var searchtype='name';
  var allcoaches;
  var coaches;
  var todraw;

  @override
  void initState() {
    super.initState();
    getcoaches();
  }

  getcoaches() async {
    this.allcoaches = await widget.db.query('SELECT ID,name,Age From coach;');
    print(this.allcoaches[2]['ID']);
    setState(() {
      this.coaches = this.allcoaches.map((v) => v);
      this.todraw=this.allcoaches.map((v) => v);
    });
  }

  result(var newdata) {
    setState(() {
      todraw = List.from(newdata);
    });
  }

  List<Widget> draw(BuildContext ctx) {
     
    if (todraw != null)
 
      return todraw?.map<Widget>((row) => info(ctx, row['name'], row['Age'], row['ID']))?.toList()??[];
    // ignore: dead_code
    return [Text("no Data To be viewed")];
  }

  addcoach(BuildContext ctx) {
    Navigator.of(ctx).push(MaterialPageRoute(builder: (_) {
      return AddCoach(widget.db);
    }));
  }

  void navigate(BuildContext ctx, int ssn, final type) {
    Navigator.of(ctx).push(MaterialPageRoute(builder: (_) {
      return Coachstatschange(ssn,widget.db);
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
  
  
  refresh()async{
   getcoaches();
  }
  @override
  Widget build(BuildContext context) {
    return (Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Stack(children: [
          Search(this.coaches, this.result,this.searchtype),
        ]),
      ),
      body: RefreshIndicator(
        onRefresh: ()=>refresh(), 
       child:Container(
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
        onPressed: () => addcoach(context),
        label: Text("Add coach"),
        backgroundColor: Colors.black,
        icon: Icon(
          Icons.add,
          color: Colors.red,
        ),
      ),
    ));
  }
}
