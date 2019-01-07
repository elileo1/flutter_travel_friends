import 'package:flutter/gestures.dart';

///create by elileo on 2018/12/20
import 'package:flutter/material.dart';
import 'package:travel_friend/common/TextResources.dart';
import 'package:travel_friend/common/GlobalConfig.dart';
import 'package:travel_friend/widget/AgreementDialog.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TapGestureRecognizer recognizer = new TapGestureRecognizer();

  @override
  void initState() {
    super.initState();
    recognizer.onTap = () {
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (_) => AgreementDialog());
    };
  }

  @override
  void dispose() {
    super.dispose();
    recognizer.dispose();
  }

  void _weChatLogin() {}

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          body: SafeArea(
              child: Container(
                  child: Column(
        children: <Widget>[
          GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Container(
                alignment: Alignment.topLeft,
                padding: const EdgeInsets.only(left: 10),
                child: Image.asset("images/icon_close.png",
                    width: 18, height: 18)),
          ),
          Container(
            alignment: Alignment.topCenter,
            padding: const EdgeInsets.only(top: 80),
            child: Image.asset("images/icon_logo.png", width: 130, height: 130),
          ),
          Container(
            margin: const EdgeInsets.only(left: 20, right: 20, top: 100),
            child: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 50,
                child: FlatButton(
                    onPressed: () {},
                    splashColor: Colors.transparent,
                    color: GlobalConfig.colorFFB600,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25.0)),
                    child: Text(TextResources.phoneLoginTip,
                        style: TextStyle(color: Colors.white, fontSize: 16)))),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.only(left: 20, right: 20, bottom: 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Expanded(
                          child: Divider(
                        height: 1,
                        color: GlobalConfig.color999999,
                      )),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 25),
                        child: Text(TextResources.thirdLoginTip,
                            style: TextStyle(
                                fontSize: 16, color: GlobalConfig.color999999)),
                      ),
                      Expanded(
                          child: Divider(
                        height: 1,
                        color: GlobalConfig.color999999,
                      ))
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 30),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      GestureDetector(
                          onTap: _weChatLogin,
                          child: Image.asset("images/icon_weixin.png",
                              width: 58, height: 58)),
                      Container(
                        padding: const EdgeInsets.only(top: 10),
                        child: Text(TextResources.weChatLoginTip,
                            style: TextStyle(
                                fontSize: 14, color: GlobalConfig.color999999)),
                      )
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.only(top: 30),
                    alignment: Alignment.center,
                    child: RichText(
                        text: TextSpan(
                            text: TextResources.registerWarnTip,
                            style: TextStyle(
                                fontSize: 12, color: GlobalConfig.color717171),
                            children: <TextSpan>[
                              new TextSpan(
                                  text: TextResources.agreementTitle,
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: GlobalConfig.color1F98FD),
                                  recognizer: recognizer)
                            ]
                        )
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      )))),
    );
  }
}
