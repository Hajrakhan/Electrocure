import 'dart:convert';
import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:electrocure_basic/packages/Drawer.dart';

class Ofd_CurrentLogs extends StatefulWidget {
  @override
  _Ofd_CurrentLogsState createState() => _Ofd_CurrentLogsState();
}

class _Ofd_CurrentLogsState extends State<Ofd_CurrentLogs> {
  List<dynamic> _curentLog,_tr;
  var total=500;
  var limit=20;
  var PageNo=0;
  var totalPage=20;
  var offset=0;
  var i=1;
  Future fetchTransformers() async {
    String url = "http://uetpswr.cisnr.com/electrocure/app/outfeeder_current_log.php";
    final response = await http.post(url);
    setState(() {
      _curentLog = json.decode(response.body);
      _tr=_curentLog.sublist(offset,offset+20);
    });

  }
  @override
  void initState() {
    setState(() {
      _curentLog=[];
      _tr=[];
    });
    fetchTransformers();
    super.initState();
  }

  Widget dataBody() {
    if(_curentLog.isNotEmpty) {
      return
        DataTable(
            columns: [
              DataColumn(label: Text("Feeder ID",)),
              DataColumn(label: Text("Feeder Name",)),
              DataColumn(label: Text("V1(KV)",)),
              DataColumn(label: Text("V2(KV)",)),
              DataColumn(label: Text("V3(KV)",)),
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
            rows: _tr.map((trans){
              double v1=(double.parse(trans['v1']))*0.1732;
              double v2=(double.parse(trans['v2']))*0.1732;
              double v3=(double.parse(trans['v3']))*0.1732;
              double KVA1=(double.parse(trans['v1']))*double.parse(trans['B1U']);
              double KVA2=(double.parse(trans['v2']))*double.parse(trans['B1M']);
              double KVA3=(double.parse(trans['v3']))*double.parse(trans['B1L']);
                return DataRow(cells: [
                  DataCell(Text(trans['id']),),
                  DataCell(Text(trans['trid']),),
                  DataCell(Text(v1.toStringAsFixed(4))),
                  DataCell(Text(v2.toStringAsFixed(4))),
                  DataCell(Text(v3.toStringAsFixed(4))),
                  DataCell(Text(trans['B1U'], )),
                  DataCell(Text(trans['B1M'], )),
                  DataCell(Text(trans['B1L'], )),
                  DataCell(Text(trans['pf1'], )),
                  DataCell(Text(trans['pf2'], )),
                  DataCell(Text(trans['pf3'], )),
                  DataCell(Text(KVA1.toStringAsFixed(2))),
                  DataCell(Text(KVA2.toStringAsFixed(2))),
                  DataCell(Text(KVA3.toStringAsFixed(2))),
                  DataCell(Text(trans['datetime'], style: TextStyle(fontSize: 14,color: Colors.grey, fontWeight: FontWeight.bold)))
                ]);}).toList()
        );
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
    print(_curentLog.length);
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
                  children: List.generate(20, (index) {
                    return
                      // ( index==PageNo|| index==0|| index==24|| index==PageNo+1|| index==PageNo-1)?
                      returnButton(index);
                    // :Container();
                  }
                  ),
                ),
                PageNo<19?FlatButton
                  (
                    minWidth: 10,
                    onPressed: (){
                      setState(() {
                        offset=(PageNo+1)*20;
                        PageNo=PageNo+1;
                      });
                    }, child: Icon(Icons.arrow_forward_ios,color: Colors.grey,size: 15,)):Container(),
              ],
            ))
            );
  }
  @override
  Widget build(BuildContext context) {
    fetchTransformers();
    return Scaffold(
      appBar: AppBar(
        title: Text('Outfeeder Current Logs',style: TextStyle(letterSpacing: -1),),
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
                SizedBox(height: 20,),
                Flexible(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: dataBody()
                  ),
                ),
                Pagination()
              ]),
        ),
      ),
    );
  }
}
