import 'package:mycarboot/login.dart';
import 'package:mycarboot/user.dart';
import 'package:mycarboot/mainscreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;


String _email, _password;
String urlAccess = "http://myondb.com/myCarBootAdmin/php/login.php";

void main() => runApp(MyCarBoot());
 
class MyCarBoot extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyCarBootSplash(),
    );
  }
}
      
      
class MyCarBootSplash extends StatefulWidget{
  _MyCarBootSplashState createState() => _MyCarBootSplashState(); 
}

class _MyCarBootSplashState extends State<MyCarBootSplash>{
  @override
  void initState(){
    super.initState();
    Future.delayed(
      Duration(seconds: 5),() {
        setState(() {
          //Navigator.pushReplacement(
            //context, MaterialPageRoute(builder: (context) => Login()));
            _loadpref();
            print('Navigation to mainscreen page');
        });
      });
  }

  Widget build(BuildContext context){
    return Scaffold(
        body: Container(
          width: 420,
          height: 690,
          decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Colors.yellow[50], Colors.yellow[300], Colors.yellow[100]],
                      stops: [0.3, 0.75, 1])),

          child: Column(
            
            children: <Widget>[
              //logo
              Padding(
                padding: EdgeInsets.fromLTRB(50, 200, 50, 0),
                child: Container(
                  width: 250,
                  height: 250,
                  child: Image.asset("assets/images/myCarBoot.png"),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.yellow[800],
                      width: 10
                    )
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
                child: Text("Admin", style: TextStyle(color: Colors.blue[900], fontSize: 30, fontWeight: FontWeight.bold))
              ),

              //loading bar
              SpinKitThreeBounce(
                size: 30,
                color: Colors.deepOrange,
              ),

            ]
          ),
        )
      );
  }

  void _loadpref() async{
    SharedPreferences sharedPref = await SharedPreferences.getInstance();

    _email = (sharedPref.getString('email')??'');
    _password = (sharedPref.getString('password')??'');
    print(_email);
    print(_password);
    if (_isEmailValid(_email)){
      http.post(urlAccess, body: {
        "email" : _email,
        "password" : _password
      }).then((res){
        print(res.statusCode);
        var string = res.body;
        List userInfo = string.split(",");
        print(userInfo);
        if (userInfo[0] == "success"){
          User user = new User(
            name: userInfo[1],
            email: userInfo[2],
            phone: userInfo[3],
            radius: userInfo[4],
            credit: userInfo[5],
            rating: userInfo[6],
          );
          Navigator.push(context, MaterialPageRoute(builder: (context) => MainScreenPage(user: user)));
        }
        else{
          User user = new User(
            name: "not register",
            email: "user@noregister",
            phone: "not register",
            radius: "15",
            credit: "0",
            rating: "0"
          );
          Navigator.push(context, MaterialPageRoute(builder: (context) => MainScreenPage(user: user)));
        }
      }).catchError((err) {
        print(err);
      });
    }
  }

  bool _isEmailValid(String email) {
    return RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email);
  }

}