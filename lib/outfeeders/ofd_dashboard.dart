import 'package:flutter/material.dart';
import 'package:electrocure_basic/services/outfeeders.dart';
import 'package:electrocure_basic/packages/Drawer.dart';
import 'package:http/http.dart' as http;
import 'package:electrocure_basic/outfeeders/outfeederCard.dart';

class ofd_dashboard extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    Future <List<outfeeder>> fetchofd() async{
      final routeArgs=ModalRoute.of(context).settings.arguments as Map<String,String>;
      final String url1=routeArgs['url1'];
      final String fdid=routeArgs['args'];
      print(fdid);
      final response = await http.post(url1,body: {
        "id": fdid
      });
      print(response.body);
      return outfeederFromJson(response.body);
    }

    var mediaquery=MediaQuery.of(context);
    return Scaffold(
        appBar: AppBar(
          title: Text('Outfeeder Dashboard'),
        ),
        drawer: MainDrawer(),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            // scrollDirection: Axis.vertical,
            children: [
              Container(
                padding: EdgeInsets.fromLTRB(15, 20, 0, 0),
                child: Text("All Out Feeders",style: TextStyle(fontWeight: FontWeight.w700,fontSize: 25,letterSpacing: -0.7)),),
              FutureBuilder(
                future: fetchofd(),
                builder: (context,snapshot){
                  if(snapshot.hasData){
                    return ListView.builder(
                      physics: NeverScrollableScrollPhysics(), ///
                      shrinkWrap: true, ///
                      scrollDirection: Axis.vertical, ///
                      itemCount:snapshot.data.length,
                      itemBuilder: (BuildContext_context,index ){
                        outfeeder ofd=snapshot.data[index];
                        return Ofd_Card(ofd);
                      },
                    );
                  }
                  return CircularProgressIndicator();
                },
              ),
            ],
          ),
        )
    );
  }
}
