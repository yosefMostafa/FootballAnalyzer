import 'package:sqflite/sqflite.dart';

class DataB {
  // ignore: non_constant_identifier_names
  Database _my_db;
  DataB() {
    intializedb();
    print("Intialized");
  }

  intializedb() async {
    this._my_db =
        await openDatabase('data.db', version: 1, onCreate: _createDb,onOpen: _open);
  }
  void _open(Database database)async{
    
  }
  void _createDb(Database db, int newversion) async {
    db.execute('''create Table Coach (ID INTEGER not null
    primary key,name varchar(20) not null,
    Age smallint,Nationailty varchar(10),Awards varchar(50),
    formation varchar(6) not null, game_plan varchar(6) not null,
    roles varchar(50),instructions varchar(50))''').then((value) {
      print("coach table is created");
    }).catchError((error) {
      print("error on creating coach table ${error.toString()}");
    });

    await db.execute('''CREATE TABLE DataAnalyst(
        Analyst_ID int not null primary key,
        Dreport varchar(100))''').then((value) {
      print("data analystis created");
    }).catchError((error) {
      print("error on creating data analyst table ${error.toString()}");
    });
    await db.execute('''create table DataRecorder(
        Recorder_Id int not null primary key,
        Data_Type varchar(15),Data_Date datetime)''').then((value) {
      print("dataRECORDER created");
    }).catchError((error) {
      print("error on creating data REDECORDER table ${error.toString()}");
    });

    await db.execute('''create table FinancialDep
              (
              Finance_ID int not null primary key,
              Name varchar(20) not null,
              reports varchar(100),
              deals varchar(100))''').then((value) {
      print("FDEPRT created");
    }).catchError((error) {
      print("error on creating FDEPRT ${error.toString()}");
    });
    await db.execute('''create table Team
                (
                Country varchar(10) not null,
                Name varchar(10) not null,
                league_division varchar(10) not null,
                Trophies varchar(100),
                Stadium varchar(15),
                budget Bigint,
                compeitions varchar(100),
                Coach_ID int, PRIMARY KEY (Country,Name,league_division),
                Foreign key (Coach_ID) references Coach)''').then((value) {
      print("TEAM created");
    }).catchError((error) {
      print("error on creating TEAM ${error.toString()}");
    });
    await db.execute('''create table Player
        (
        Player_ID int not null primary key,
        Age smallint not null,
        Name varchar(20) not null,
        Nationality varchar(10),
        Value bigint not null,
        team_country varchar(10),
        team_name varchar(10),
        team_league_division varchar(10),
        Exerciese varchar(50), 
        Foreign key (team_country,team_name,team_league_division) references Team
        )''').then((value)
    {
      print("player created");

    }).catchError((error)
    {
      print("error on creating player ${error.toString()}");
    });



    await db.execute('''create table Match 
        (
        Match_Date datetime not null Primary Key,
        Stadium varchar(15),
        results varchar(5),
        team_country varchar(10),
        team_name varchar(10),
        team_league_division varchar(10),
        team2_country varchar(10),
        team2_name varchar(10),
        team2_league_division varchar(10),
        Foreign key   (team_country,team_name,team_league_division) references Team,
        Foreign key    (team2_country,team2_name,team2_league_division) references Team
        )''').then((value)
    {
      print("Match created");

    }).catchError((error)
    {
      print("error on creating match ${error.toString()}");
    });


    await db.execute('''create table Player_Statistics
        (
        Shots smallint,
        passes smallint,
        saves smallint,
        goals smallint,
        dribbles smallint,
        assissts smallint,
        rating smallint,
        minutes_played smallint,
        cards smallint,
        tackles smallint,
        Player_ID int,
        Match_Date datetime,
        Primary key (Player_ID,Match_Date),
        Foreign Key (Player_ID) references Player,
        Foreign key (Match_Date) references Match
        )''').then((value)
    {
      print("player stats created");

    }).catchError((error)
    {
      print("error on creating player stats ${error.toString()}");
    });

    await db.execute('''create table Player_physical
        (
        player_Age smallint,
        player_Height smallint,
        player_Weight smallint,
        muscles_percentage smallint,
        pace smallint,
        jumping smallint,
        felexability smallint,
        stamina smallint,
        Player_ID int,
        Coach_exercies varchar(50),
        Foreign key (Player_ID) references Player
        )''').then((value)
    {
      print("player phys created");

    }).catchError((error)
    {
      print("error on creating player phys ${error.toString()}");
    });

    await db.execute('''create table Employee
        (
        SSN int not null primary key,
        manager_ID int,
        Department varchar(15) not null,
        Name varchar(20) not null,
        salary bigint not null,
        fin_ID int,
        Super_SSN int,
        Foreign key (fin_ID) references FinancialDep,
        Foreign key (Super_SSN) references Employee
        )''').then((value)
    {
      print("emp created");

    }).catchError((error)
    {
      print("error on creating emp ${error.toString()}");
    });

    await db.execute('''create table DataRecord
      (
      Recorder_ID int primary key,
      Player_ID int,
      Foreign key (Player_ID) references Player
      )''').then((value)
    {
      print("data rec created");

    }).catchError((error)
    {
      print("error on creating data rec ${error.toString()}");
    });


    await db.execute('''create table MedicalTeam
      (
      Dr_ID int not null primary key,
      name varchar(20) not null,
      position varchar(10) not null,
      reports varchar(100),
      Player_ID int,
      Foreign key(Player_ID) references Player
      )''').then((value)
    {
      print("med team created");

    }).catchError((error)
    {
      print("error on creating med team ${error.toString()}");
    });
     await db.execute('''create Table Signin 
    (ID INTEGER not null,username varchar(20) not null,
    type varchar(20) not null,password varchar(20) unique)''').then((value) {
      print(" Signin is created");
    }).catchError((error) {
      print("error on creating Signin table ${error.toString()}");
    });
  }

  insert(String query) {
    this._my_db.rawInsert(query).then((annon) {
      print("Inserted");
    }).catchError((onError) {
      print("error on Inserting  ${onError.toString()}");
    });
  }

  query(String querystring) async {
    var list;
    try{
     list= await this._my_db.rawQuery(querystring);
    }on Exception catch(_){
      print("Error in query ");
    }
  return list;
  }
}
