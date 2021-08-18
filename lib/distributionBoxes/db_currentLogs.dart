import 'dart:convert';
import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:electrocure_basic/main.dart';
import 'package:http/http.dart' as http;
import 'package:electrocure_basic/packages/Drawer.dart';

class dbCurrentLogs extends StatefulWidget {
  @override
  _dbCurrentLogsState createState() => _dbCurrentLogsState();
}
class _dbCurrentLogsState extends State<dbCurrentLogs> {
  List<dynamic> _transformer;
  var x;
  Future fetchTransformers() async {
    var x='transformer';
    String url ="http://uetpswr.cisnr.com/electrocure/app/db_current_logs.php";
    final response = await http.post(url,body:{
      "user" : x,
    });
    if(mounted) {
      setState(() {
        _transformer = json.decode(response.body);
      });
    }
  }
  @override
  void initState() {
    setState(() {
      _transformer=[];
    });
    fetchTransformers();
    super.initState();
  }

  Widget dataBody() {
    if(_transformer.isNotEmpty) {
      return
        DataTable(
            columns: [
              DataColumn(label: Text("DB ID",style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold))),
              DataColumn(label: Text("V1",)),
              DataColumn(label: Text("V2",)),
              DataColumn(label: Text("V3",)),
              DataColumn(label: Text("L1C1")),
              DataColumn(label: Text("L1C2")),
              DataColumn(label: Text("L1C3")),
              DataColumn(label: Text("L1Pf1")),
              DataColumn(label: Text("L1Pf2",)),
              DataColumn(label: Text("L1Pf3")),
              DataColumn(label: Text("L2C1", )),
              DataColumn(label: Text("L2C2",)),
              DataColumn(label: Text("L2C3",)),
              DataColumn(label: Text("L2Pf1",)),
              DataColumn(label: Text("L2Pf2",)),
              DataColumn(label: Text("L2Pf3",)),
              DataColumn(label: Text("L3C1",)),
            ],
            rows: _transformer
                .map((trans) =>
                DataRow(cells: [
                  DataCell(Text(trans['dbid']),),
                  DataCell(Text(trans['v1'],)),
                  DataCell(Text(trans['v2'],)),
                  DataCell(Text(trans['v3'],)),
                  DataCell(Text(trans['line1_c1'])),
                  DataCell(Text(trans['line1_c2'])),
                  DataCell(Text(trans['line1_c3'])),
                  DataCell(Text(trans['line1_pf1'])),
                  DataCell(Text(trans['line1_pf2'])),
                  DataCell(Text(trans['line1_pf3'])),
                  DataCell(Text(trans['line2_c1'])),
                  DataCell(Text(trans['line2_c2']),),
                  DataCell(Text(trans['line2_c3'])),
                  DataCell(Text(trans['line2_pf1'])),
                  DataCell(Text(trans['line2_pf2'], )),
                  DataCell(Text(trans['line2_pf3'],)),
                  DataCell(Text(trans['line3_c3'], )),

                ])).toList()
        );
    }
  }
  @override
  Widget build(BuildContext context) {
    fetchTransformers();
    return Scaffold(
      appBar: AppBar(
          title: Text('DB Current Logs'),
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
              ]),
        ),
      ),
    );
  }
}

