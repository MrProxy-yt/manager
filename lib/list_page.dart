import 'package:flutter/material.dart';
import 'package:manager/main.dart';
import 'package:manager/view_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Listp extends StatefulWidget {
  @override
  _ListpState createState() => _ListpState();
}

class _ListpState extends State<Listp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
        ),
        body: Builder(builder: (context){
          return Page();
        }),
      ),
    );
  }
}

class Page extends StatefulWidget {
  @override
  _PageState createState() => _PageState();
}

class _PageState extends State<Page> {
  final namecon = TextEditingController();
  final datacon = TextEditingController();
  List<String> member = [];
  List<String> data = [];
  save(String key, List data) async {
    final pref = await SharedPreferences.getInstance();
    pref.setStringList(key, data);
  }
  check() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    if (pref.getStringList("member") == null) {
      print("null");
    } else {
      print("something is there");
      member = pref.getStringList("member");
      setState(() {});
    }
    if (pref.getStringList("data") == null) {
      print("data null");
    } else {
      print("something is there on data");
      data = pref.getStringList("data");
      setState(() {});
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    check();
    setState((){});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8)
            ),
                hintText: "Name",
            labelText: "Name"
          ),
          controller: namecon,
        ),
        SizedBox(height: 10,),
        TextField(
          controller: datacon,
          decoration: InputDecoration(
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8)
              ),
              hintText: "data",
              labelText: "data",
          ),
        ),
        RaisedButton(onPressed: (){
          if(namecon.text.toString().isNotEmpty && datacon.text.toString().isNotEmpty) {
            member.add(namecon.text.toString());
            save("member", member);
            data.add(datacon.text.toString()+ "\n");
            save("data", data);
            print(member);
            print(data);
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => MyApp()));
          }
        },
        child: Text("ADD"),)

      ],
    );
  }
}
