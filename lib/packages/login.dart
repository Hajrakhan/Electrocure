
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../main.dart';
void main()=> runApp(MaterialApp(
  home: Login(),
));

class  Login extends StatefulWidget {
//var pref
// Login(this.pref);
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController username,password;
  String msg='';
  Future<List> _Login() async{
    // final reponse = awit http.post("http://uetpswr.cisnr.com/$pref/app/login.php")
      final response =await http.post("http://uetpswr.cisnr.com/electrocure/app/login.php",body:{
        "user" :username.text,
        "pass": password.text,
        // "pref": pref,
      });
      // print(username.text);
      print(response.body);
      var result=response.body.toString();
      // print(response.body);
      if(response.body == "true"){
        Navigator.pushReplacementNamed(context, '/infeeder');
      }
      else{
        setState(() {
          msg="INCORRECT USERNAME OR PASSWORD";
          print(msg);
        });
      }
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    username = new TextEditingController();
    password = new TextEditingController();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold( //different properties
      backgroundColor:Colors.grey[300],
      body:SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Center(
          child: Padding(
            padding: EdgeInsets.fromLTRB(0, 90, 0, 10),
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Image.asset("assets/logo.png",width: 150,height: 150,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("ELECTRO",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 24),),
                    Text("CURE",style: TextStyle(fontSize: 24,fontWeight: FontWeight.w300),),
                  ],
                ),
               Container(
                 margin: EdgeInsets.fromLTRB(18,35,18,25),
                 padding: EdgeInsets.fromLTRB(15,15,15,0),
                 color: Colors.white,
                 child: Column(
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children: [
                     Container(padding:EdgeInsets.fromLTRB(0, 5, 0, 5),
                         child: Text("Enter your Username and password!",style:TextStyle(fontSize: 15,letterSpacing: 0.5),)),
                     Container(
                       margin: EdgeInsets.fromLTRB(0,20, 0, 5),
                       height: 40,
                       child: TextField(
                         controller: username,
                         decoration: InputDecoration(
                           hintText: "username",
                           contentPadding: const EdgeInsets.symmetric(vertical:2,horizontal: 10),
                           enabledBorder: OutlineInputBorder(
                             borderSide: BorderSide(color: Colors.black26, width: 1),
                           ),
                           focusedBorder: OutlineInputBorder(
                             borderSide: BorderSide(color: Colors.black38),
                           ),
                         ),
                       ),
                     ),
                     Container(
                       margin: EdgeInsets.fromLTRB(0,10, 0, 15),
                       height: 40,
                       child: TextField(
                         controller: password,
                         obscureText: true,
                         decoration: InputDecoration(
                           contentPadding: const EdgeInsets.symmetric(vertical:2,horizontal: 10),
                           hintText: "Password",
                           enabledBorder: OutlineInputBorder(
                             borderSide: BorderSide(color: Colors.black26, width: 1),
                           ),
                           focusedBorder: OutlineInputBorder(
                             borderSide: BorderSide(color: Colors.black38),
                           ),
                         ),
                       ),
                     ),
                     ButtonTheme(
                       minWidth: 100.0,
                       height: 40.0,
                       child: FlatButton(
                         color: Colors.blue[700],
                         onPressed: (){
                           _Login();
                         },
                         child: Text(
                           'log In',
                           style: TextStyle(
                               color:Colors.white,
                               fontSize: 18,
                               fontWeight: FontWeight.bold
                           ),
                         ),
                       ),
                     ),
                     Text(
                       msg,
                       style: TextStyle(
                         fontSize: 15.0,
                         color: Colors.red,
                         letterSpacing: 0.5,
                       ),

                     )
                   ],
                 ),
               )
              ],

            ),
          ),
        ),
      ),

    );
  }
}
