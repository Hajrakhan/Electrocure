import 'dart:convert';
import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:electrocure_basic/main.dart';
import 'package:http/http.dart' as http;
import 'package:electrocure_basic/packages/Drawer.dart';

class TransformerList extends StatefulWidget {

  @override
  _TransformerListState createState() => _TransformerListState();
}

class _TransformerListState extends State<TransformerList> {
  List<dynamic> _transformer;
  var x;
  Future fetchTransformers() async {
    var x='transformer';
    String url ="http://uetpswr.cisnr.com/electrocure/app/transformer.php";
    final response = await http.post(url,body:{
    "user" : x,
    });
    // var x = TransformersFromJson(response.body);
    setState(() {
      _transformer = json.decode(response.body);
    });

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
              DataColumn(label: Text("Transformer ID",)),
              DataColumn(label: Text("Transformer Name")),
              DataColumn(label: Text("Capacity(KVA)")),
              DataColumn(label: Text("Description", )),
              DataColumn(label: Text("Connection Date",)),
            ],
            rows: _transformer
                .map((trans) =>
                DataRow(cells: [
                  DataCell(Text(trans['trid']),),
                  DataCell(Text(trans['name'])),
                  DataCell(Text(trans['kva_capacity'])),
                  DataCell(Text(trans['description'])),
                  DataCell(Text(trans['datetime']))
                ])).toList()
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    fetchTransformers();
    return Scaffold(
      appBar: AppBar(
          title: Text('Transformer List'),
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
                // Container(
                //   padding: EdgeInsets.fromLTRB(10, 20, 0, 5),
                //   child: Text(
                //     "All Transformer",
                //     style:
                //     TextStyle(fontWeight: FontWeight.w600,fontSize: 25,letterSpacing: -2),),),
                // Container(
                //   color: Colors.grey[300],
                //   // margin: EdgeInsets.fromLTRB(15, 5, 15, 15),
                //   padding: EdgeInsets.all(8),
                //   child: Row(
                //     children: [
                //       Icon(
                //         Icons.double_arrow_rounded,
                //         size: 20,
                //       ),
                //       Text("\t\t\tHome\t\t\t>\t\t\t"),
                //       Text("Transformer List",style: TextStyle(fontWeight: FontWeight.w400),)
                //     ],
                //   ),),
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
