import 'package:mycarboot/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

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
          Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => Login()));
            print('Navigation to login page');
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
}