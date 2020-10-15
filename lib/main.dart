import 'package:flutter/material.dart';
import 'package:manager/edit_page.dart';
import 'package:manager/list_page.dart';
import 'package:manager/view_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.orangeAccent,
        appBar: AppBar(
          title: Text("Manager"),
          centerTitle: true,
          backgroundColor: Colors.green,
        ),
        body: Builder(
          builder: (context) {
            return Mainbody();
          },
        ),
      ),
    );
  }
}

class Mainbody extends StatefulWidget {
  @override
  _MainbodyState createState() => _MainbodyState();
}

class _MainbodyState extends State<Mainbody> {
  void floatbuttona() {
    print("nav");
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => Listp()));
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
    }
  }
  save(String key, List data) async {
    final pref = await SharedPreferences.getInstance();
    pref.setStringList(key, data);
  }

  List<String> member = [];
  List<String> data = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    check();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: member.length,
            itemBuilder: (BuildContext context, int Index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.lightGreenAccent,
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.all(Radius.circular(12))
                  ),
                  child: ListTile(
                    title: Text(
                      member[Index],
                    ),
                    leading: IconButton(
                      icon: Icon(Icons.clear),
                      onPressed: (){
                        member.remove(member[Index]);
                        setState(() {});
                        save("member",member);
                        setState(() {});
                        data.remove(data[Index]);
                        setState(() {});
                        save("data", data);
                        setState(() {});
                        print(member + data);
                      },
                    ),
                    subtitle: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text("data"),
                            IconButton(icon: Icon(Icons.remove_red_eye), onPressed: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context) => View(
                                index : Index
                              )));
                            })
                          ],
                        ),
                      ],
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => Edit(
                          index: Index
                        )));
                      },
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            //  Expanded(child: TextField(
            //)),
            Card(
              color: Colors.pink,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
              child: IconButton(
                onPressed: () {
                  floatbuttona();
                },
                icon: Icon(Icons.add),
                iconSize: 30,
              ),
            )
          ],
        )
      ],
    );
  }
}
