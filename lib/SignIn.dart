import 'package:flutter/material.dart';

class Signin extends StatefulWidget {
  final Function info;
  final title;
  Signin(this.info,this.title);
  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  _Signin createState() => _Signin();
}

class _Signin extends State<Signin> {
  var usercontroller=TextEditingController();
  var passcontroller=TextEditingController();
  bool showtext = true;
  setshowtext() {
    setState(() {
      showtext = !showtext;
    });
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(appBar: AppBar(
      backgroundColor: Colors.red,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(
          widget.title,
          textAlign: TextAlign.center,
        ),
      ),
      body:Container(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: usercontroller,
              decoration: InputDecoration(
                labelText: "Username",
                labelStyle: TextStyle(
                  fontSize: 20,
                ),
                hintText: "Enter username",
                suffixIcon: Icon(Icons.verified_user),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            TextField(
              obscureText: showtext,
              controller: passcontroller,
              decoration: InputDecoration(
                labelText: "Password",
                labelStyle: TextStyle(
                  fontSize: 20,
                ),
                hintText: "Enter Password",
                suffixIcon: IconButton(
                  icon:
                      Icon(showtext ? Icons.visibility : Icons.visibility_off),
                  onPressed: () => setshowtext(),
                ),
              ),
            ),
            Container(
         width: double.infinity,
        color: Colors.red,
          child:  MaterialButton(
              onPressed: ()=>widget.info(usercontroller.text,passcontroller.text),
              child: Text('Login'),
            ),),
          ],
        )),);
  }
}
