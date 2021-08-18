import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:electrocure_basic/packages/Drawer.dart';

class Faults extends StatefulWidget {
  @override
  _FaultsState createState() => _FaultsState();
}

class _FaultsState extends State<Faults> {
  List<dynamic> _ifds=[],_tr;
  var limit=20;
  var PageNo=0;
  var totalPage=5;
  var offset=0;
  var i=1;
  Future fetchTransformers() async {
  String url ="http://uetpswr.cisnr.com/electrocure/app/faults.php";
  final response = await http.post(url);
  if(mounted) {
  setState(() {
  _ifds = json.decode(response.body);
  _tr=_ifds.sublist(offset,offset+20);
  });
  }
  }

  @override
  void initState() {
    setState(() {
      _ifds=[];
      _tr=null;
    });
    fetchTransformers();
    super.initState();
  }

  Widget dataBody() {
    return DataTable(
        columns: [
          DataColumn(label: Text("Transformer ID",)),
          DataColumn(label: Text("Fault Type")),
          DataColumn(label: Text("v1",)),
          DataColumn(label: Text("v2",)),
          DataColumn(label: Text("v3",)),
          DataColumn(label: Text("c1",)),
          DataColumn(label: Text("c2",)),
          DataColumn(label: Text("c3",)),
          DataColumn(label: Text("status",)),
          DataColumn(label: Text("Report Date & Time",)),
          DataColumn(label: Text("Resolve Date & Time",)),
        ],
        rows: _tr.isEmpty ? []
            : _tr
            .map((trans) =>
            DataRow(cells: [
              DataCell(Text(trans['trid'])),
              DataCell(Text(trans['type'])),
              DataCell(Text(trans['v1'])),
              DataCell(Text(trans['v2'])),
              DataCell(Text(trans['v3'])),
              DataCell(Text(trans['c1'])),
              DataCell(Text(trans['c2'])),
              DataCell(Text(trans['c3'])),
              DataCell(Text(trans['status'])),
              DataCell(Text(trans['datetime'])),
              DataCell(Text(trans['resolvedatetime']))
            ])).toList()
    );
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
                  children: List.generate(5, (index) {
                    return
                      returnButton(index);
                  }
                  ),
                ),
                PageNo<totalPage-1?FlatButton
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
  title: Text('Faults'),
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
