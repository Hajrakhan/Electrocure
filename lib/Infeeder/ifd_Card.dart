import 'package:flutter/material.dart';
import 'package:electrocure_basic/packages/details.dart';
import 'package:electrocure_basic/services/outfeeders.dart';
import 'package:electrocure_basic/packages/calculations.dart';
class ifd_Card extends StatelessWidget {
  outfeeder _ifd;
  ifd_Card(this._ifd);
  String avgPowerFactor='0',avg_voltage='0',KVA='0',total_current='0';
  String status;
  Color KVAcolor;
  @override
  Widget build(BuildContext context) {
    var mediaquery=MediaQuery.of(context);
    var now = new DateTime.now();
    DateTime lastpulse=_ifd.datetime;
    final difference = now.difference(lastpulse).inMinutes;
    //check condition
    if (difference<15) {
      total_current = totalcurrent(
          double.parse('${_ifd.c1}'),
          double.parse('${_ifd.c2}'),
          double.parse('${_ifd.c3}'));
      avg_voltage = avgvoltage(
          double.parse('${_ifd.v1}'),
          double.parse('${_ifd.v2}'),
          double.parse('${_ifd.v3}'));
      KVA=KVA_cal( double.parse(total_current), double.parse(avg_voltage));
      avgPowerFactor = avgvoltage(
          double.parse('${_ifd.pf1}'),
          double.parse('${_ifd.pf2}'),
          double.parse('${_ifd.pf3}'));
      KVAcolor = Colors.green[400];
      status = "Online";
    } else {
      // total_current =avg_voltage= KVA= avgPowerFactor='123';
      status = "Offline";
      KVAcolor = Colors.blue[400];
    }
    return Container(
      padding: EdgeInsets.fromLTRB(10, 10, 10, 5),
      child: Card(
          elevation: 10,
          child: Container(
            height: mediaquery.size.height*0.25,
            width: mediaquery.size.width,
            child: Row(
              children: <Widget>[
                Container(
                    color: KVAcolor,
                    width: mediaquery.size.width*0.1,
                    height: mediaquery.size.height*0.25,
                    child: Wrap(
                        alignment: WrapAlignment.center,
                        runAlignment: WrapAlignment.center,
                        direction: Axis.vertical,
                        children: [
                          RotatedBox(quarterTurns: 3,child: Text(status,style: TextStyle(fontSize: 22,color: Colors.white,letterSpacing: 1),)),
                        ]
                    )
                ),
                InkWell(
                  onTap: (){
                    Navigator.pushNamed(context,'/outfeeder',arguments: {
                      'url1': "http://uetpswr.cisnr.com/electrocure/app/outfeeder.php",
                      'args': ""
                    });
                  },
                  child: Container(
                      width: MediaQuery.of(context).size.width*0.3,
                      padding: EdgeInsets.symmetric(vertical: 40),
                      color: Colors.blueGrey[50],
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text("$KVA KVA",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,letterSpacing:-1 )),
                          SizedBox(height:5),
                          Text('(${_ifd.name})',
                              style: TextStyle(fontSize: 12,letterSpacing: -0.6)),
                          SizedBox(height: 10,),
                          Text('${_ifd.kvaCapacity} KVA',style: TextStyle(fontSize: 14)),

                        ],
                      )
                  ),
                ),

                Container(
                  width: mediaquery.size.width*0.4,
                  margin: EdgeInsets.all(10),
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text("Device ID:  ",style: style1,),
                          Text("${_ifd.fdid}",style:style2),
                        ],
                      ),
                      SizedBox(height:5),
                      Row( children: [
                        Text('Avg Voltage:  ',style: style1),
                        Text('$avg_voltage',style: style2)
                      ]),
                      SizedBox(height:5),
                      Row(
                        children: [
                          Text('Total Current:  ',style: style1),
                          Text('$total_current',style: style2),
                        ],
                      )  ,
                      SizedBox(height:5),
                      Row(
                        children: [
                          Text("Avg Power Factor:  ",style: style1),
                          Text("$avgPowerFactor",style: style2),

                        ],
                      ),
                      SizedBox(height:5),
                      Text('Last Pulse: ',style:style1,),
                      Text('${_ifd.datetime}',style: TextStyle(fontSize:12,color: Colors.grey)),
                      SizedBox(height: 5,),
                      RaisedButton(
                        color: Colors.grey[200],
                        onPressed: (){
                          print(KVA);
                          KVA=='0'?null:
                          Navigator.push(
                              context, MaterialPageRoute(
                              builder: (BuildContext context) => details(_ifd.fdid,avg_voltage,total_current,KVA,"load_device_graph","3")));
                        },
                        child: Text("Details",),
                      )
                    ],
                  ),
                ),
              ],
            ),
          )
      ),
    );

  }
}
