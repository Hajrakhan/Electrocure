import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:electrocure_basic/packages/Drawer.dart';

class connectionList extends StatefulWidget {
  @override
  _connectionListState createState() => _connectionListState();
}

class _connectionListState extends State<connectionList> {
  List<dynamic> _transformer,_tr;
  var total=500;
  var limit=20;
  var PageNo=0;
  var totalPage=4;
  var offset=0;
  var i=1;
  @override

  void initState() {
    setState(() {
      _transformer=[];
      _tr=[];

    });
    super.initState();
  }

  Widget dataBody() {
      return
        DataTable(
            columns: [
              DataColumn(label: Text("Connection ID")),
              DataColumn(label: Text("Name",)),
              DataColumn(label: Text("Description")),
              DataColumn(label: Text("Connection Date")),
              DataColumn(label: Text("Phase")),
            ],
            rows: _tr.isEmpty?[]:_tr
                .map((trans) =>
                DataRow(cells: [
                  DataCell(Text(trans['cid'],),),
                  DataCell(Text(trans['name'],)),
                  DataCell(Text(trans['description'],)),
                  DataCell(Text(trans['datetime'],)),
                  DataCell(Text(trans['description'])),
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
            // color: Colors.blueGrey[400],
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                PageNo>0?FlatButton( minWidth: 10,
                    onPressed: (){
                      setState(() {
                        offset=((PageNo-1)*20);
                        PageNo=PageNo-1;
                      });
                    }, child: Icon(Icons.arrow_back_ios,color: Colors.grey,size: 15,)):Container(),
                Row(
                  children: List.generate(5, (index) {
                    return
                      // ( index==PageNo|| index==0|| index==24|| index==PageNo+1|| index==PageNo-1)?
                      returnButton(index);
                    // :Container();
                  }
                  ),
                ),
                PageNo<4?FlatButton
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
    final routeArgs=ModalRoute.of(context).settings.arguments as Map<String,String>;
    final String dbid=routeArgs['args'];
    Future fetchTransformers() async {
      String url ="http://uetpswr.cisnr.com/electrocure/app/connList.php";
      final response = await http.post(url,body: {
        "id": dbid
      });
      setState(() {
        _transformer = json.decode(response.body);
        _tr=_transformer.length>20?_transformer.sublist(offset,PageNo==totalPage?98:offset+20):_transformer;
      });
    }
    fetchTransformers();
    return Scaffold(
      appBar: AppBar(
          title: Text('Connections List'),
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
                Container(
                  padding: EdgeInsets.fromLTRB(10, 20, 0, 5),
                  child: Text(
                    "All Connections",
                    style:
                    TextStyle(fontWeight: FontWeight.w600,fontSize: 25,letterSpacing: 0),),),
                Container(
                  color: Colors.grey[300],
                  // margin: EdgeInsets.fromLTRB(15, 5, 15, 15),
                  padding: EdgeInsets.all(8),
                  child: Row(
                    children: [
                      Icon(
                        Icons.double_arrow_rounded,
                        size: 20,
                      ),
                      Text("\t\t\tHome\t\t\t>\t\t\t"),
                      Text("Connection List",style: TextStyle(fontWeight: FontWeight.w400),)
                    ],
                  ),),
                Flexible(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: dataBody(),
                  ),
                ),
                _transformer.length>20?Pagination():Container()
              ]),
        ),
      ),
    );
  }
}