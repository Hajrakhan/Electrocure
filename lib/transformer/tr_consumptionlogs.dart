import 'dart:convert';
import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:electrocure_basic/main.dart';
import 'package:http/http.dart' as http;
import 'package:electrocure_basic/packages/Drawer.dart';


class ConsumptionLogs extends StatefulWidget {
  @override
  _ConsumptionLogsState createState() => _ConsumptionLogsState();
}

class _ConsumptionLogsState extends State<ConsumptionLogs> {
  List<dynamic> _transformer;
  var x;
  Future fetch() async {
    var x='transformer';
    String url ="http://uetpswr.cisnr.com/electrocure/app/consumption.php";
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
    fetch();
    super.initState();
  }

  Widget dataBody() {
    return
      DataTable(
        columnSpacing: 25,
          columns: [
            DataColumn(label: Text("ID",)),
            DataColumn(label: Text("Transformer \nName",)),
            DataColumn(label: Text("Peak Time\nUnits", )),
            DataColumn(label: Text("Off Peak Time Units", )),
            DataColumn(label: Text("Total Consumed Units",)),
            DataColumn(label: Text("Date & Time", style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold))),
          ],
          rows: _transformer
              .map((trans) =>
              DataRow(cells: [
                DataCell(Text(trans['id'],),),
                DataCell(Text(trans['trid'],)),
                DataCell(Text(trans['pkunits'],)),
                DataCell(Text(trans['offpkunits'], )),
                DataCell(Text(trans['offpkunits'],)),
                DataCell(Text(trans['Datetime'],))
              ])).toList()

      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
          title: Text('Transformer Consumption Logs'),
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