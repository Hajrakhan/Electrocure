import 'dart:convert';
import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:electrocure_basic/main.dart';
import 'package:http/http.dart' as http;
import 'package:electrocure_basic/packages/Drawer.dart';

class Ofd_list extends StatefulWidget {
  @override
  _Ofd_listState createState() => _Ofd_listState();
}

class _Ofd_listState extends State<Ofd_list> {
  List<dynamic> _ofds=[];
  var x;
  Future fetchTransformers() async {
    String url ="http://uetpswr.cisnr.com/electrocure/app/outfeeder.php";
    final response = await http.post(url,body: {
      "id": ""
    });
    if(mounted) {
      setState(() {
        _ofds = json.decode(response.body);
      });
    }
  }
  @override
  void initState() {
    fetchTransformers();
    super.initState();
  }

  Widget dataBody() {
    return
        DataTable(
            columns: [
              DataColumn(label: Text("Feeder ID",)),
              DataColumn(label: Text("Feeder Name")),
              DataColumn(label: Text("Capacity")),
              DataColumn(label: Text("Description", )),
              DataColumn(label: Text("Connection Date",)),
            ],
            rows: _ofds.isEmpty?[]
      :_ofds
                .map((trans) =>
                DataRow(cells: [
                  DataCell(Text(trans['fdid']),),
                  DataCell(Text(trans['name'])),
                  DataCell(Text(trans['kva_capacity'])),
                  DataCell(Text(trans['description'])),
                  DataCell(Text(trans['datetime']))
                ])).toList()
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Out Feeder List'),
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
                    child: dataBody()
                  ),
                ),
              ]),
        ),
      ),
    );
  }
}

