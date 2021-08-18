import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:electrocure_basic/packages/Drawer.dart';
import 'dart:convert';

class connCurrentLogs extends StatefulWidget {
  @override
  _connCurrentLogsState createState() => _connCurrentLogsState();
}

class _connCurrentLogsState extends State<connCurrentLogs> {
  List<dynamic> _transformer,_tr;
  var total=500;
  var limit=20;
  var PageNo=0;
  var totalPage=50;
  var offset=0;
  var i=1;
  Future fetchTransformers() async {
    var x='transformer';
    String url ="http://uetpswr.cisnr.com/electrocure/app/conn_current_logs.php";
    final response = await http.post(url);
    if(mounted){
    setState(() {
      _transformer = json.decode(response.body);
      _tr=_transformer.sublist(offset,offset+20);
    });
    }
  }
  @override
  void initState() {
    setState(() {
      _transformer=[];
      _tr=[];
    });
    fetchTransformers();
    super.initState();
  }

  Widget dataBody() {
    if(_tr.isNotEmpty) {
      return
        DataTable(
            columns: [
              DataColumn(label: Text("Connection ID",
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold))),
              DataColumn(label: Container(child: FittedBox(child: Text("Connection Name", style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold))))),
              DataColumn(label: Text("v1")),
              DataColumn(label: Text("v2")),
              DataColumn(label: Text("v3")),
              DataColumn(label: Text("c1")),
              DataColumn(label: Text("c2")),
              DataColumn(label: Text("c3")),
              DataColumn(label: Text("pf1")),
              DataColumn(label: Text("pf2")),
              DataColumn(label: Text("pf3")),
            ],
            rows: _tr
                .map((trans) =>
                DataRow(cells: [
                  DataCell(Text(trans['id'],),),
                  DataCell(Text(trans['cid'],)),
                  DataCell(Text(trans['v1'],)),
                  DataCell(Text(trans['v2'],)),
                  DataCell(Text(trans['v3'],)),
                  DataCell(Text(trans['c1'])),
                  DataCell(Text(trans['c2'])),
                  DataCell(Text(trans['c3'])),
                  DataCell(Text(trans['pf1'],)),
                  DataCell(Text(trans['pf2'],)),
                  DataCell(Text(trans['pf3'],)),
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
                  children: List.generate(50, (index) {
                    return
                      returnButton(index);
                  }
                  ),
                ),
                PageNo<49?FlatButton
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
          title: Text('Connection Current Logs'),
      ),
      drawer: MainDrawer(),
      body:
      SingleChildScrollView(
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
        ),
      ),
    );
  }
}
