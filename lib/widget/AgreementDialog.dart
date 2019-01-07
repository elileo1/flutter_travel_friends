///create by elileo on 2018/12/20
import 'package:flutter/material.dart';
import 'package:flutter_html_view/flutter_html_view.dart';
import 'package:travel_friend/common/TextResources.dart';
import 'package:travel_friend/common/GlobalConfig.dart';

class AgreementDialog extends Dialog {
  AgreementDialog({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: DefaultAssetBundle.of(context).loadString("resource/friends_agreement.html"),
      builder: (context, snapshot){
        return Padding(
          padding: const EdgeInsets.all(12),
          child: Material(
            type: MaterialType.transparency,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: ShapeDecoration(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(8.0),
                          ))
                  ),
                  margin: const EdgeInsets.all(30.0),
                  child: Column(
                    children: <Widget>[
                      Container(
                        height: 50,
                        alignment: Alignment.center,
                        child: Text(TextResources.agreementTitle, style: TextStyle(fontSize: 18, color: GlobalConfig.color282828)),
                      ),
                      Divider(height: 1.0, color: GlobalConfig.colorE5E5E5),
                      SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height * 0.65,
                          child: Scrollbar(
                            child: SingleChildScrollView(
                              child: HtmlView(
                                data: snapshot.hasData ? snapshot.data.toString() : "",
                              ),
                            ),
                          )
                      ),
                      Divider(height: 1.0, color: GlobalConfig.colorE5E5E5),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child:  FlatButton(
                          onPressed: (){
                            Navigator.of(context).pop();
                          },
                          splashColor: Colors.transparent,
                          highlightColor: GlobalConfig.colorF7F7F7,
                          child: Text(TextResources.closeTips, style: TextStyle(fontSize: 18, color: GlobalConfig.colorFF9900)),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      }
    );
  }
}