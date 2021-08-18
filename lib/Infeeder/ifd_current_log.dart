import 'dart:convert';
import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:electrocure_basic/packages/Drawer.dart';

class Ifd_CurrentLogs extends StatefulWidget {
  @override
  _Ifd_CurrentLogsState createState() => _Ifd_CurrentLogsState();
}

class _Ifd_CurrentLogsState extends State<Ifd_CurrentLogs> {
  List<dynamic> _curentLog;
  var x;
  Future fetchTransformers() async {
    var x='tr_current_logs';
    String url = "http://uetpswr.cisnr.com/electrocure/app/Infeeder_current_log.php";
    final response = await http.post(url);
    // var x = TransformersFromJson(response.body);
    setState(() {
      _curentLog = json.decode(response.body);
    });

  }
  @override
  void initState() {
    setState(() {
      _curentLog=[];
    });
    fetchTransformers();
    super.initState();
  }

  Widget dataBody() {
      return
        DataTable(
            columns: [
              DataColumn(label: Text("Transformer ID",)),
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
        rows: _curentLog.isEmpty?[]:
        _curentLog.map((trans) =>
                DataRow(cells: [
                  DataCell(Text(trans['trid']),),
                  DataCell(Text(trans['v1'])),
                  DataCell(Text(trans['v2'], )),
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

  @override
  Widget build(BuildContext context) {
    fetchTransformers();
    return Scaffold(
      appBar: AppBar(
        title: Text('Infeeder Current Logs',style: TextStyle(letterSpacing: -1),),
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
                    child: dataBody(),
                  ),
                ),
              ]),
        ),
      ),
    );
  }
}
