import 'package:flutter/material.dart';
import 'package:manager/list_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class View extends StatefulWidget {
  final index;
  View({Key key, @required this.index}) : super(key: key);
  @override
  _ViewState createState() => _ViewState();
}

class _ViewState extends State<View> {
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

  List<String> member = [];
  List<String> data = [];
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text(member[widget.index]),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                Text(
                  data[widget.index],
                  style: TextStyle(fontSize: 20),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
