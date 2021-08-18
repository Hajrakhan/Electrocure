import 'package:flutter/material.dart';
import 'package:electrocure_basic/packages/Drawer.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:electrocure_basic/packages/calculations.dart';
class conConsumptionLogs extends StatefulWidget {
  @override
  _conConsumptionLogsState createState() => _conConsumptionLogsState();
}
class _conConsumptionLogsState extends State<conConsumptionLogs> {
  List<dynamic> _conn,_tr;
  var total=500;
  var limit=20;
  var PageNo=0;
  var totalPage=25;
  var offset=0;
  Future fetchTransformers() async {
    var x='transformer';
    String url ="http://uetpswr.cisnr.com/electrocure/app/conn_consumption_logs.php";
    final response = await http.post(url);
    if(mounted) {
      setState(() {
        _conn = json.decode(response.body);
        _tr=_conn.sublist(offset,offset+20);
      });
    }
  }
  Widget fun(double offpeak,double peak){
    double result=offpeak+peak;
    print(peak);
    print(offpeak);
    return Text(result.toString());
  }
  @override
  void initState() {
    setState(() {
      _conn=[];
    });
    fetchTransformers();
    super.initState();
  }

  Widget dataBody() {
    double result;
    if(_tr.isNotEmpty) {
      return
        DataTable(
            columns: [
              DataColumn(label: Text("Connection ID",)),
              DataColumn(label: Container(child: FittedBox(child: Text("Name")))),
              DataColumn(label: Container(child: FittedBox(child: Text("Consumed Units")))),
              DataColumn(label: Container(child: FittedBox(child: Text("Current Load")))),
              DataColumn(label: Container(child: FittedBox(child: Text("Date & Time")))),
            ],
            rows: _tr
                .map((Data){
                  result=double.parse(Data["offpeak"])+(double.parse(Data["peak"]));
                  return DataRow(cells: [
                  DataCell(Text(Data['cid'], ),),
                  DataCell(Text(Data["id"],)),
                  DataCell(Text(result.toString())),
                  DataCell(Text(Data["offpkunits"],)),
                  DataCell(Text(Data["datetime"])),
                ]);}).toList()
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
          title: Text('Connection Consumption Logs',style: TextStyle(fontSize: 18,letterSpacing: -1),),
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