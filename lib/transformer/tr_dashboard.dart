import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:electrocure_basic/services/AllTransformer.dart';
import 'package:http/http.dart' as http;
import 'package:electrocure_basic/packages/Drawer.dart';
import 'package:electrocure_basic/transformer/tr_Dashboard_Card.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final routeArgs=ModalRoute.of(context).settings.arguments as Map<String,String>;
    final String url1="http://uetpswr.cisnr.com/electrocure/app/transformer.php";
    final String fdid=routeArgs==null?"":routeArgs['args'];
    Future <List<Transformers>> fetchTransformers() async{
      final response = await http.post(url1, body: {
        "id": fdid
      });
      return TransformersFromJson(response.body);
    }
    var mediaquery=MediaQuery.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Transformer Dashboard'),
      ),
      drawer: MainDrawer(),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            // scrollDirection: Axis.vertical,
            children: [
              Container(
                padding: EdgeInsets.fromLTRB(15, 20, 0, 0),
                child: Text("All Transformers",style: TextStyle(fontWeight: FontWeight.w700,fontSize: 25,letterSpacing: -0.7)),),
              FutureBuilder(
                future: fetchTransformers(),
                builder: (context,snapshot){
                  if(snapshot.hasData){
                    return ListView.builder(
                      physics: NeverScrollableScrollPhysics(), ///
                      shrinkWrap: true, ///
                      scrollDirection: Axis.vertical, ///
                      itemCount:snapshot.data.length,
                      itemBuilder: (BuildContext_context,index ){
                        Transformers transformer=snapshot.data[index];
                        return TransformerCard(transformer);
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