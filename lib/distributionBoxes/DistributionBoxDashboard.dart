import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:electrocure_basic/services/db.dart';
import 'package:http/http.dart' as http;
import 'package:electrocure_basic/packages/Drawer.dart';
import 'package:electrocure_basic/distributionBoxes/dbCard.dart';
class DistributionBoxesDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final routeArgs=ModalRoute.of(context).settings.arguments as Map<String,String>;
    final String url1=routeArgs['url1'];
    final String transid=routeArgs['args'];
    Future <List<db>> fetchTransformers() async {
      final response = await http.post(url1, body: {
        "user": transid
      });
      var x = dbFromJson(response.body);
      return x; //TransformersFromJson(response.body);
    }
    String avg_voltage='0',KVA,total_current='0',Status;
    String status;
    Color KVAcolor;
    Size size = MediaQuery
        .of(context)
        .size;
    return Scaffold(
        appBar: AppBar(
          title: Text('DB Dashboard'),
        ),
        drawer: MainDrawer(),
        body: Container(
          height: 1100,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              // scrollDirection: Axis.vertical,
              children: [
                Container(
                  padding: EdgeInsets.fromLTRB(15, 20, 0, 0),
                  child: Text("All Distribution Boxes", style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 25,
                      letterSpacing: -0.5)),),
                SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: FutureBuilder(
                    future: fetchTransformers(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return ListView.builder(
                          physics: NeverScrollableScrollPhysics(),///
                          shrinkWrap: true,///
                          scrollDirection: Axis.vertical,///
                          itemCount: snapshot.data.length,
                          itemBuilder: (BuildContext_context, index) {
                            db transformer = snapshot.data[index];
                            return dbCard(transformer);
                          },
                        );
                      }
                      return CircularProgressIndicator();
                    },
                  ),
                ),
              ],
            ),
          ),
        )
    );
  }
}


