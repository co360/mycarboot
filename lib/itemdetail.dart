/*import 'dart:async';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mycarboot/user.dart';
import 'package:toast/toast.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'item.dart';
import 'mainscreen.dart';

class ItemDetail extends StatefulWidget {
  final Item item;
  final User user;

  const ItemDetail({Key key, this.item, this.user}) : super(key: key);

  @override
  _ItemDetailState createState() => _ItemDetailState();
}

class _ItemDetailState extends State<ItemDetail> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.deepOrange));
    return WillPopScope(
      onWillPop: _onBackPressAppBar,
      child: Scaffold(
          resizeToAvoidBottomPadding: false,
          appBar: AppBar(
              title: Text(
                "Item Detail",
                style: TextStyle(fontSize: 24),
              ),
              flexibleSpace: Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: <Color>[
                      Colors.blueAccent,
                      Colors.lightBlue,
                      Colors.blue[900],
                    ])),
              ),
            ),
          body: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.fromLTRB(40, 20, 40, 20),
              child: DetailInterface(
                item: widget.item,
                user: widget.user,
              ),
            ),
          )),
    );
  }

  Future<bool> _onBackPressAppBar() async {
    Navigator.pop(
        context,
        MaterialPageRoute(
          builder: (context) => MainScreenPage(
            user: widget.user,
          ),
        ));
    return Future.value(false);
  }
}

class DetailInterface extends StatefulWidget {
  final Item item;
  final User user;
  DetailInterface({this.item, this.user});

  @override
  _DetailInterfaceState createState() => _DetailInterfaceState();
}

class _DetailInterfaceState extends State<DetailInterface> {
  Completer<GoogleMapController> _controller = Completer();
  CameraPosition _myLocation;

  @override
  void initState() {
    super.initState();
    _myLocation = CameraPosition(
      target: LatLng(
          double.parse(widget.item.itemlat), double.parse(widget.item.itemlon)),
      zoom: 17,
    );
    print(_myLocation.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Center(),
        Container(
          width: 280,
          height: 200,
          child: Image.network(
              "http://myondb.com/myCarBootAdmin/images/${widget.item.itemimage}",
              fit: BoxFit.fill),
        ),
        SizedBox(
          height: 10,
        ),
        Text(widget.item.itemtitle.toUpperCase(),
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            )),
        Text(widget.item.itemtime),
        Container(
          alignment: Alignment.topLeft,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 5,
              ),
              Table(children: [
                TableRow(children: [
                  Text("Item Owner",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
                  Text(widget.item.itemowner, style: TextStyle(fontSize: 17),),
                ]),
                TableRow(children: [
                  Text("Owner Contact",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
                  Text(widget.item.ownercontact, style: TextStyle(fontSize: 17),),
                ]),
                TableRow(children: [
                  Text("Item Description",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
                  Text(widget.item.itemdes, style: TextStyle(fontSize: 17)),
                ]),
                TableRow(children: [
                  Text("Item Price",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
                  Text("RM" + widget.item.itemprice, style: TextStyle(fontSize: 17)),
                ]),
                TableRow(children: [
                  Text("Item Location",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
                  Text("")
                ]),
              ]),
              SizedBox(
                height: 10,
              ),
              Container(
                height: 120,
                width: 340,
                decoration: BoxDecoration(border: Border.all(color: Colors.black)),
                child: GoogleMap(
                  // 2
                  initialCameraPosition: _myLocation,
                  // 3
                  mapType: MapType.normal,
                  // 4

                  onMapCreated: (GoogleMapController controller) {
                    _controller.complete(controller);
                  },
                ),
              ),
              SizedBox(height: 5,),
              Container(
                width: 350,
                child: MaterialButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0)),
                  height: 40,
                  child: Text(
                    'SELL ITEM',
                    style: TextStyle(fontSize: 20 ),
                  ),
                  color: Colors.blue[900],
                  textColor: Colors.white,
                  elevation: 5,
                  onPressed: _onAcceptItem,
                ),
                //MapSample(),
              )
            ],
          ),
        ),
      ],
    );
  }

  void _onAcceptItem() {
     if (widget.user.email=="user@noregister"){
      Toast.show("Please register to view sell items", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      return;
    }else{
      _showDialog();
    }
    print("Sell Item");
    
  }

  void _showDialog() {
    // flutter defined function
    if (int.parse(widget.user.credit)<1){
        Toast.show("Credit not enough ", context,
            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
            return;
    }
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Accept " + widget.item.itemtitle),
          content: new Text("Are your sure?"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Yes"),
              onPressed: () {
                Navigator.of(context).pop();
                acceptRequest();
              },
            ),
            new FlatButton(
              child: new Text("No"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<String> acceptRequest() async {
    String urlLoadItems = "http://myondb.com/myCarBootAdmin/php/accept_item.php";
    ProgressDialog pr = new ProgressDialog(context,
        type: ProgressDialogType.Normal, isDismissible: false);
    pr.style(message: "Sell Item");
    pr.show();
    http.post(urlLoadItems, body: {
      "itemid": widget.item.itemid,
      "email": widget.user.email,
      "credit": widget.user.credit,
    }).then((res) {
      print(res.body);
      if (res.body == "success") {
        Toast.show("Success", context,
            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
            pr.dismiss();
            _onLogin(widget.user.email, context);
      } else {
        Toast.show("Failed", context,
            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
            pr.dismiss();
      }
    }).catchError((err) {
      print(err);
      pr.dismiss();
    });
    return null;
  }

   void _onLogin(String email, BuildContext ctx) {
     String urlgetuser = "http://myondb.com/myCarBootAdmin/php/get_user.php";

    http.post(urlgetuser, body: {
      "email": email,
    }).then((res) {
      print(res.statusCode);
      var string = res.body;
      List dres = string.split(",");
      print(dres);
      if (dres[0] == "success") {
        User user = new User(
            name: dres[1],
            email: dres[2],
            phone: dres[3],
            radius: dres[4],
            credit: dres[5],
            rating: dres[6]);
        Navigator.push(ctx,
            MaterialPageRoute(builder: (context) => MainScreenPage(user: user)));
      }
    }).catchError((err) {
      print(err);
    });
  }
}*/