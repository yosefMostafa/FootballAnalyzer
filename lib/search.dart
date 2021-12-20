import 'package:flutter/material.dart';

class Search extends StatefulWidget {
  final data,result,searchtype;
  Search(this.data,this.result,this.searchtype);
 
  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  _Search createState() => _Search();
}

//List<String> kind = ['one', 'two', 'three'];

class _Search extends State<Search> {
  TextEditingController _textController = TextEditingController();

  var newDataList;
  onItemChanged(String value) {
    print(widget.data);
     print(widget.searchtype);
    setState(() {
      newDataList = (widget.data)
          .where((string) {return string[widget.searchtype].toLowerCase().contains(value.toLowerCase())?true:false;})
          .toList();
    });
    widget.result(newDataList);
  }

  @override
  Widget build(BuildContext context) {
    return (Container(
        child: Column(children: <Widget>[
      Padding(
        padding: const EdgeInsets.all(12.0),
        child: TextField(
          controller: _textController,
          cursorColor:Colors.white,
          keyboardType: TextInputType.name,
          //inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
          decoration: InputDecoration(
            hintText: 'Search Here...',
            suffixIcon: IconButton(
              color: Colors.black,
                  icon:
                      Icon(Icons.search ),
                  onPressed:()=>widget.result(newDataList),
                ),
          ),
          onChanged: onItemChanged,
        ),
      ),
      // Expanded(
      //     child: ListView(
      //   padding: EdgeInsets.all(12.0),
      //   children: newDataList.map((data) {
      //     return ListTile(
      //       title: Text(data),
      //       onTap: () => print(data),
      //     );
      //   }).toList(),
      // ))
    ])));
  }
}
