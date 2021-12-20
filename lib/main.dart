import 'package:flutter/material.dart';

//import 'package:http/http.dart' as http;
import 'connect.dart';
import 'SignIn.dart';
import 'Player.dart';
import 'Coach.dart';
import 'Employee.dart';
import 'DataRec.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter App',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Sign IN'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

List<String> kind = [
  "Signin",
  "EPlayer",
  "ECoach",
  "EMedical",
  "Efunancial",
  "DataRecorders"
];

class _MyHomePageState extends State<MyHomePage> {
  // ignore: non_constant_identifier_names
  var my_db;
  @override
  void initState() {
    super.initState();
    my_db = DataB();

    init();
  }

  init() async {
    await Future.delayed(
        Duration(seconds: 3)); 
        // var temp=await my_db.query('Select * from Player');
        // print(temp);
// await my_db.insert('''INSERT INTO Player_physical(player_Age,player_Height,
// player_Weight,muscles_percentage,pace,jumping,felexability,stamina,Player_ID,Coach_exercies)
// Values(23,180,80,30,50,20,60,90,123,"No need")''');

        //to wait or databasse to properly intialized
// await my_db.insert('''INSERT INTO Player(Player_ID,Age,Name,Nationality,Value,team_country,team_name,team_league_division,Exerciese)
//           VALUES(123,23,"Treka","Egyption",10000000,"Egypt","El Ahly","Dwry el masry","no need")''');
    //  await my_db.insert('''INSERT INTO DataRecorder(Recorder_ID,Data_Type,Data_Date)
    //       VALUES(1,NULL,"${DateTime.now()}","0000")''');
        // await  my_db.insert('''INSERT INTO Signin(ID,username,type,password)
        //   VALUES(122,"Coach2","ECoach","2000")''');
        // my_db.query('Update Signin set type="EPlayer"where ID=123 ');
        //  my_db.query('Update Signin set type="EPlayer"where ID=50 ');
          // await  my_db.insert('''INSERT INTO Signin(ID,username,type,password)
          // VALUES(123,"player1","ECoach","0100")''');
          //  await  my_db.insert('''INSERT INTO Signin(ID,username,type,password)
          // VALUES(50,"player2","ECoach","0200")''');
  }

  //}
  String type = "Signin";
  int iD = 12345;
  // ignore: non_constant_identifier_names
  SigninInfo(String user, String pass) async {
    var list = await my_db.query('Select * from Signin');
    var row = list.where((row) {
      return (row['password']==pass) ;
    }).toList();
    if (!row.isEmpty) {
      if (row[0]['username'] == user) {
        setState(() {
          iD = row[0]['ID'];
          type = row[0]['type'];
        });
      }
    }
  }

  // ignore: non_constant_identifier_names
  Signout() {
    setState(() {
      type = "Signin"; // coach
    });
  }

  Widget getwidget() {
    // connect();
    if (type == "Signin") {
      return Signin(SigninInfo, widget.title);
    } else if (type == "EPlayer") {
      return Player(Signout, kind[1], iD,my_db);
    } else if (type == "ECoach") {
      return Coach(Signout, kind[2], iD, my_db);
    } else if (type == "EMedical") {
      return Employee(Signout, kind[3], iD,my_db);
    } else if (type == "Efunancial") {
      return Employee(Signout, kind[4], iD,my_db);
    } else if (type == "DataRecorders") {
      return DataRec(Signout, kind[5], iD, my_db);
    }else{
      return(Container());
    }
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    if (my_db != null) {
      return (getwidget());
    } else {
      return (Container());
    }
  }
}
