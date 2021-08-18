import 'dart:ui';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
class details extends StatefulWidget {
  String trid,voltage,current,KVA,url,type;

  details(this.trid,this.voltage,this.current,this.KVA,this.url,this.type);

  @override
  _detailsState createState() => _detailsState();
}

class _detailsState extends State<details> {
  void initState() {
    super.initState();
    // Enable hybrid composition.
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }
  @override
  Widget build(BuildContext context) {
    var myColor = Colors.blueGrey[400];
    var hex = '#${myColor.value.toRadixString(16)}';
    print(hex);
    Widget show(String trid,String voltage,String current,String KVA,String url,String type){
      return WebView(
        initialUrl:
        Uri.dataFromString('<html>'
            ' <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">'
            '<body>'
            '<div class="column">'
            '<div class="row center" style="width:100%">'
            '<div class="btn col-xs-6" style="padding-left: 15%;margin-top: 30px;"><button style="width:100%; height:8%; color:white; background-color: #49c189" onclick="content1()" type="button" >Volatge \n $voltage</button></div>'
            '<div class="btn col-xs-6" style="padding-right:15%;margin-top: 30px;"><button style="width:100%; height:8%; color:white; background-color: #d66053" onclick="content2()" type="button" >Current \n $current</button></div>'
            // '<button style="background-color: red;" onclick="content2()" type="button" class="btn col-xs-6">Current</button>'
            '</div>'
            '<div class="row"style="width:100%">'
            '<div class="btn col-xs-6" style="padding-left: 15%;margin-top: 5px;"><button style="width:100%; height:8%; color:white; background-color:#2ba1e5" onclick="content3()" type="button" >KVA \n $KVA</button></div>'
            '<div class="btn col-xs-6" style="padding-right:15%;margin-top: 5px;"><button style="width:100%; height:8%; color:white; background-color: #a7bbc6" onclick="content4()" type="button" >kwh Graph</button></div>'
        // '<button style="background-color: green;"onclick="content3()" type="button" class="btn col-xs-6">KVA</button>'
              // '<button style="background-color: grey;" onclick="content4()" type="button" class="btn col-xs-6">KWH</button>'
            '</div>'
            '</div>'
            '<iframe id="screen" src="http://brtpswr.cisnr.com/electrocure_admin/${widget.url}.php?id=${widget.trid}&type=3&name=BS-00&interval=60"'
            'style="line-height: 0; -ms-zoom: 0.68; -moz-transform: scale(0.68);-moz-transform-origin: 0 0; -o-transform: scale(0.68);-o-transform-origin: 0 0; -webkit-transform: scale(0.68); -webkit-transform-origin: 0 0;display: block; margin:20px; position:relative; height:350; width:550px;" width="100%"></iframe><br>'

              '<script>'
            'function content1() {'
            'document.getElementById("screen").src = "http://brtpswr.cisnr.com/electrocure_admin/${widget.url}.php?id=${widget.trid}&type=3&name=BS-00&interval=60"; } '
            'function content2() {'
            'document.getElementById("screen").src = "http://brtpswr.cisnr.com/electrocure_admin/${widget.url}.php?id=${widget.trid}&type=4&name=BS-00&interval=60"; } '
            'function content3() {'
            'document.getElementById("screen").src = "http://brtpswr.cisnr.com/electrocure_admin/${widget.url}.php?id=${widget.trid}&type=2&name=BS-00&interval=60"; } '
            'function content4() {'
            'document.getElementById("screen").src = "http://brtpswr.cisnr.com/electrocure_admin/${widget.url}.php?id=${widget.trid}&type=1&name=BS-00&interval=60"; } '
            '</script>'
            '</body></html>', mimeType: 'text/html').toString(),
        javascriptMode: JavascriptMode.unrestricted,
      );
    }
    print("http://brtpswr.cisnr.com/electrocure_admin/${widget.url}.php?id=${widget.trid}&type=3&name=BS-00&interval=60");
    return  Scaffold(
        appBar: AppBar(
          title: Text("Details"),
        ),
        body: show(widget.trid,widget.voltage,widget.current,widget.KVA,widget.url,widget.type));
  }
}
