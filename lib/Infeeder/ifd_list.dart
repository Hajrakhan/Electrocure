import 'dart:convert';
import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:electrocure_basic/main.dart';
import 'package:http/http.dart' as http;
import 'package:electrocure_basic/packages/Drawer.dart';

class Ifd_list extends StatefulWidget {
  @override
  _Ifd_listState createState() => _Ifd_listState();
}

class _Ifd_listState extends State<Ifd_list> {
  List<dynamic> _ifds=[];
  var x;
  Future fetchTransformers() async {
    String url ="http://uetpswr.cisnr.com/electrocure/app/infeeder.php";
    final response = await http.post(url);
    if(mounted) {
      setState(() {
        _ifds = json.decode(response.body);
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
            rows: _ifds.isEmpty?[]
        :_ifds
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
    fetchTransformers();
    return Scaffold(
      appBar: AppBar(
        title: Text('In Feeder List'),
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
