import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mycarboot/user.dart';
import 'package:mycarboot/tabscreen.dart';
import 'package:mycarboot/tabscreen2.dart';
import 'package:mycarboot/tabscreen3.dart';
import 'package:mycarboot/tabscreen4.dart';

void main() => runApp(MainScreenPage());

class MainScreenPage extends StatefulWidget {
  final User user;

  const MainScreenPage({Key key,this.user}) : super(key: key);
  _MainScreenPageState createState() => _MainScreenPageState();
}

class _MainScreenPageState extends State<MainScreenPage> {
  List<Widget> tabs;

  int currentTabIndex = 0;

  @override
  void initState() {
    super.initState();
    tabs = [
      TabScreenPage(user: widget.user),
      TabScreenPage2(user: widget.user),
      TabScreenPage3(user: widget.user),
      TabScreenPage4(user: widget.user),
    ];
  }

  String $pagetitle = "My Helper";

  onTapped(int index) {
    setState(() {
      currentTabIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    //SystemChrome.setEnabledSystemUIOverlays([]);
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.blue[900]));
    return Scaffold(
      body: tabs[currentTabIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTapped,
        currentIndex: currentTabIndex,
        //backgroundColor: Colors.blueGrey,
        type: BottomNavigationBarType.fixed,

        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            title: Text("Jobs"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list, ),
            title: Text("Posted Jobs"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.event, ),
            title: Text("My Jobs"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person, ),
            title: Text("Profile"),
          )
        ],
      ),
    );
  }
}