import 'package:flutter/material.dart';
import 'package:electrocure_basic/services/db.dart';
import 'package:electrocure_basic/packages/calculations.dart';
import 'package:electrocure_basic/packages/details.dart';
class dbCard extends StatelessWidget {
  db transformer;
  dbCard(this.transformer);
  String avgPowerFactor='0',avg_voltage='0',KVA='0',total_current='0';
  String status;
  Color KVAcolor;
  @override
  Widget build(BuildContext context) {
    var mediaquery=MediaQuery.of(context);
    var now = new DateTime.now();
    DateTime lastpulse=transformer.datetime;
    final difference = now.difference(lastpulse).inMinutes;
    //check condition
    if (difference<15) {
      total_current = totalcurrent(
          double.parse('${transformer.c1}'),
          double.parse('${transformer.c2}'),
          double.parse('${transformer.c3}'));
      avg_voltage = avgvoltage(
          double.parse('${transformer.v1}'),
          double.parse('${transformer.v2}'),
          double.parse('${transformer.v3}'));
      KVA=KVA_cal( double.parse(total_current), double.parse(avg_voltage));
      KVAcolor = Colors.green[400];
      status = "Online";
    } else {
      // total_current =avg_voltage= KVA= avgPowerFactor='123';
      status = "Offline";
      KVAcolor = Colors.blue[400];
    }
    return Container(
      padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
      child: Card(
          elevation: 10,
          child: Container(
            height: 190,
            width: 190,
            child: Row(
              children: <Widget>[
                Container(
                    color: KVAcolor,
                    width: 40,
                    height: 190,
                    child: Wrap(
                        alignment: WrapAlignment.center,
                        runAlignment: WrapAlignment
                            .center,
                        direction: Axis.vertical,
                        children: [
                          RotatedBox(quarterTurns: 3,
                              child: Text(status,
                                style: TextStyle(
                                    fontSize: 22,
                                    color: Colors.white,
                                    letterSpacing: 1),)),
                        ]
                    )
                ),
            InkWell(
              onTap: (){
                Navigator.pushNamed(context,'/conn_List',arguments: {
                  'args': transformer.dbid
                });
              },
            child:Container(
                    width: MediaQuery
                        .of(context)
                        .size
                        .width / 3.2,
                    padding: EdgeInsets.symmetric(
                        vertical: 40),
                    color: Colors.blueGrey[50],
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment
                          .center,
                      children: <Widget>[
                        Text("$KVA KVA",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight
                                    .bold,
                                letterSpacing: -1)),
                        SizedBox(height: 5),
                        Text('${transformer.name}',
                          style: TextStyle(
                              fontSize: 12,
                              letterSpacing: -0.6),
                          textAlign: TextAlign.center,

                        ),
                      ],
                    )
                ),),
            Container(
              margin: EdgeInsets.all(10),
              padding: EdgeInsets.symmetric(
                  horizontal: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment
                    .center,
                crossAxisAlignment: CrossAxisAlignment
                    .start,
                children: [
                  Row(
                    children: [
                      Text("Device ID:  ",
                        style: style1,),
                      Text("${transformer.dbid}",
                          style: style2),
                    ],
                  ),
                  SizedBox(height: 5),
                  Row(children: [
                    Text('Avg Voltage:  ',
                        style: style1),
                    Text('$avg_voltage',
                      style: style2,)
                  ]),
                  SizedBox(height: 5),
                  Row(
                    children: [
                      Text('Total Current:  ',
                          style: style1),
                      Text('$total_current',
                          style: style2),
                    ],
                  ),
                  SizedBox(height: 5),
                  Text('Last Pulse: ',
                      style: style1),
                  SizedBox(height: 5,),
                  Text('${transformer.datetime}',
                      style: TextStyle(fontSize: 12,color: Colors.grey,)
                  ),
                  SizedBox(height: 5,),
                  RaisedButton(
                    onPressed: (){
                      Navigator.push(
                          context, MaterialPageRoute(builder: (BuildContext context) => details(transformer.dbid,avg_voltage,total_current,KVA,"load_db_device_graph","3")));
                    },
                    child: Text("Details"),
                  )
                ],

              ),
            )

              ],
            ),
          )
      ),
    );
  }
}
