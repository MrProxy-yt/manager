import 'package:flutter/material.dart';
import 'package:manager/list_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Edit extends StatefulWidget {
  final index;
  Edit({Key key ,@required this.index}) : super(key: key);
  @override
  _EditState createState() => _EditState();
}

class _EditState extends State<Edit> {
  void initState() {
    // TODO: implement initState
    super.initState();
    check();
    setState(() {});
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
  final datacon = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Add Data for " + member[widget.index]),
              centerTitle: true,
        ),
        body: Column(
          children: [
            SizedBox(height: 20,),
            Row(
              children: [

                Expanded(
                  child: TextField(
                    controller: datacon,
                    decoration: InputDecoration(
                      hintText: "data",
                      labelText: "data",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8)
                      )
                    ),
                  ),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RaisedButton(onPressed: (){
                  if(datacon.text.toString().isNotEmpty) {
                    data[widget.index] =
                        data[widget.index] + datacon.text.toString() + "\n";
                    setState(() {});
                    save("data", data);
                    datacon.clear();

                  }
                },
                child: Text("Add Data"),)
              ],
            )
          ],
        ),
      ),
    );
  }
}
