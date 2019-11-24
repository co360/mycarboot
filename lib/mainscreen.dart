import 'package:flutter/material.dart';
import 'package:mycarboot/login.dart';

void main() => runApp(MainScreenPage());

/*class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MainScreenPage(),
    );
  }
}*/

class MainScreenPage extends StatefulWidget {
  final String email;

  const MainScreenPage({Key key,this.email}) : super(key: key);
  _MainScreenPageState createState() => _MainScreenPageState();
}

class _MainScreenPageState extends State<MainScreenPage> {
  Widget build(BuildContext context) {
    return  Scaffold(
            resizeToAvoidBottomPadding: false,
            appBar: AppBar(
              backgroundColor: Colors.yellow[900],
              centerTitle: true,
              title: Text('Main Screen',
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.w900, color: Colors.deepPurple[900])),
              ),
            body: SingleChildScrollView(
                child: Container()
            )
    );
  }


}