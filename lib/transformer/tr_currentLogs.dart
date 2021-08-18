import 'dart:convert';
import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:electrocure_basic/main.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:electrocure_basic/packages/Drawer.dart';

class CurrentLogs extends StatefulWidget {
  @override
  _CurrentLogsState createState() => _CurrentLogsState();
}
class _CurrentLogsState extends State<CurrentLogs> {
  List<dynamic> _curentLog=[];
  List<dynamic> _tr=[];
  var limit=20;
  var PageNo=0;
  var totalPage=25;
  var offset=0;
  var i=1;
  Future fetchTransformers() async {
    var x='tr_current_logs';
    // String url = "http://uetpswr.cisnr.com/electrocure/app/current.php";
    String url = "http://uetpswr.cisnr.com/electrocure/app/tr_current.php";
    final response = await http.post(url);
    if(mounted) {
      setState(() {
        _curentLog = json.decode(response.body);
        _tr=_curentLog.sublist(offset,offset+20);
      });
    }
  }
  @override
  void initState() {
    setState(() {
      _curentLog=[];
      _tr=null;
    });
    fetchTransformers();
    super.initState();
  }

  Widget dataBody() {
    if(_tr!=null) {
      return
        DataTable(
            columns: [
              DataColumn(label: Text("id",)),
              DataColumn(label: Text("V1",)),
              DataColumn(label: Text("V2",)),
              DataColumn(label: Text("V3",)),
              DataColumn(label: Text("C1",)),
              DataColumn(label: Text("C2",)),
              DataColumn(label: Text("C3",)),
              DataColumn(label: Text("Pf1",)),
              DataColumn(label: Text("Pf2",)),
              DataColumn(label: Text("Pf3",)),
              DataColumn(label: Text("KVA1",)),
              DataColumn(label: Text("KVA2",)),
              DataColumn(label: Text("KVA3",)),
              DataColumn(label: Text("Date & Time", style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold))),
            ],
            rows: _tr.map((trans) =>
                DataRow(cells: [
                  DataCell(Text(trans['id']),),
                  DataCell(Text(trans['trid']),),
                  DataCell(Text(trans['v1'])),
                  DataCell(Text(trans['v3'], )),
                  DataCell(Text(trans['v1'], )),
                  DataCell(Text(trans['v2'], )),
                  DataCell(Text(trans['v3'], )),
                  DataCell(Text(trans['pf1'], )),
                  DataCell(Text(trans['pf2'], )),
                  DataCell(Text(trans['pf3'], )),
                  DataCell(Text(trans['pf3'], )),
                  DataCell(Text(trans['pf3'], )),
                  DataCell(Text(trans['pf3'], )),
                  DataCell(Text(trans['datetime'], style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)))
                ])).toList()
        );
    }
    else{
      return CircularProgressIndicator();
    }
  }

  Widget returnButton(int i) {
    if(PageNo==i || i==PageNo+1 || i==PageNo+2){
    return
      FlatButton(
        minWidth: 10,
        color: PageNo == i ? Colors.blueGrey : Colors.white,
        onPressed: () {
          setState(() {
            offset = i * 20;
            PageNo = i;
          });
        },
        child: Text((i + 1).toString(), style: TextStyle(
          color: PageNo==i?Colors.white:Colors.grey
        ),),
      );
  }
    else if(i==PageNo+3){
      return FlatButton(
        minWidth: 10,
        color: Colors.white,
        onPressed: () {
          setState(() {
            offset = i * 20;
            PageNo = i;
          });
        },
        child: Text("...", style: TextStyle(
          color: Colors.grey,
        ),),
      );
    }
    else{
      return Container();
    }
  }
  Widget Pagination(){
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10,horizontal: 20),
      child:Card(
        elevation: 5,
        // color: Colors.blueGrey[400],
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              PageNo>0?FlatButton( minWidth: 10,
                  onPressed: (){
                setState(() {
                  offset=(PageNo-1)*20;
                  PageNo=PageNo-1;
                });
              }, child: Icon(Icons.arrow_back_ios,color: Colors.grey,size: 15,)):Container(),
              Row(
                  children: List.generate(25, (index) {
                    return
                    returnButton(index);
                  }
                  ),
              ),
              PageNo<24?FlatButton
                (
                  minWidth: 10,
                  onPressed: (){
                setState(() {
                  offset=(PageNo+1)*20;
                  PageNo=PageNo+1;
                });
              }, child: Icon(Icons.arrow_forward_ios,color: Colors.grey,size: 15,)):Container(),
            ],
           )));
  }
  @override
  Widget build(BuildContext context) {
    fetchTransformers();
    return Scaffold(
      appBar: AppBar(
          title: Text('Transformer Current Logs',style: TextStyle(letterSpacing: -1),),
      ),
      drawer: MainDrawer(),
      body: SingleChildScrollView(
          child: SafeArea(
            child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                verticalDirection: VerticalDirection.down,
                children: <Widget>[
                  Flexible(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: dataBody(),
                    ),
                  ),
                  Pagination()
                ]),
          )
      )
    );
  }
}