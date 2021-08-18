import 'package:flutter/material.dart';
import 'package:electrocure_basic/services/outfeeders.dart';
import 'package:electrocure_basic/packages/Drawer.dart';
import 'package:http/http.dart' as http;
import 'package:electrocure_basic/Infeeder/ifd_Card.dart';


class ifd_dashboard extends StatelessWidget {
  Future <List<outfeeder>> fetchofd() async{
    String url="http://uetpswr.cisnr.com/electrocure/app/infeeder.php";
    final response = await http.post(url);
    return outfeederFromJson(response.body);
  }

  @override
  Widget build(BuildContext context) {
    var mediaquery=MediaQuery.of(context);
    return Scaffold(
        appBar: AppBar(
          title: Text('Infeeder Dashboard'),
        ),
        drawer: MainDrawer(),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            // scrollDirection: Axis.vertical,
            children: [
              Container(
                padding: EdgeInsets.fromLTRB(15, 20, 0, 0),
                child: Text("All In Feeders",style: TextStyle(fontWeight: FontWeight.w700,fontSize: 25,letterSpacing: -0.7)),),
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
                        return ifd_Card(ofd);
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
