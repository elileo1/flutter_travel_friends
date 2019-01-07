///create by elileo on 2018/12/18
import 'package:flutter/material.dart';
import 'package:travel_friend/common/TextResources.dart';
import 'package:travel_friend/common/GlobalConfig.dart';
import 'package:travel_friend/pages/mate/HomePage.dart';
import 'package:travel_friend/pages/mine/MyPage.dart';
import 'package:travel_friend/pages/chat/ChatPage.dart';
import 'package:travel_friend/pages/login/LoginPage.dart';

class ApplicationPage extends StatefulWidget{
  @override
  _ApplicationPageState createState() => new _ApplicationPageState();
}

class _ApplicationPageState extends State<ApplicationPage>{
  String title = TextResources.homeMateTitle;
  int pageIndex = 0;
  var tabImages;
  PageController pageController;
  List<Widget> pageList;

  void initData(){
    pageList = [
      HomePage(),
      ChatPage(),
      MyPage()
    ];
    tabImages = [
      [getTabImage("images/icon_mate_nor.png"), getTabImage("images/icon_mate_selected.png")],
      [getTabImage("images/icon_chat_nor.png"), getTabImage("images/icon_chat_selected.png")],
      [getTabImage("images/icon_mine_nor.png"), getTabImage("images/icon_mine_selected.png")],
    ];
  }

  Image getTabImage(path) {
    return new Image.asset(path, width: 34.0, height: 34.0);
  }


  Image getTabIcon(int curIndex) {
    if (curIndex == pageIndex) {
      return tabImages[curIndex][1];
    }
    return tabImages[curIndex][0];
  }

  @override
  void initState() {
    super.initState();
    initData();
    pageController = new PageController(initialPage: this.pageIndex);
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(pageIndex == 2 ? 0.0 : 50.0), // here the desired height
            child: AppBar(
              elevation: 0.0,
              centerTitle: true, // 标题居中
              title: Text(title, style: TextStyle(color: GlobalConfig.colorTitle, fontSize: 18.0)),
              backgroundColor: Colors.white,
            )
        ),
        body: new PageView(
          physics: NeverScrollableScrollPhysics(),
          children: pageList.map((widget){
            return widget;
          }).toList(),//<Widget>[HomePage(), ChatPage(), MyPage()],
          controller: pageController,
          onPageChanged: onPageChanged,
        ),
        bottomNavigationBar: new BottomNavigationBar(
            items: <BottomNavigationBarItem>[
              new BottomNavigationBarItem(
                  icon: getTabIcon(0),
                  title: Text(TextResources.homeTabMate),
                  backgroundColor: GlobalConfig.colorPrimary),
              new BottomNavigationBarItem(
                  icon: getTabIcon(1),
                  title: Text(TextResources.homeTabChat),
                  backgroundColor: GlobalConfig.colorPrimary),
              new BottomNavigationBarItem(
                  icon:  getTabIcon(2),
                  title: Text(TextResources.homeTabMy),
                  backgroundColor: GlobalConfig.colorPrimary),
            ],
            currentIndex: pageIndex,
            fixedColor: Colors.black,
            type: BottomNavigationBarType.fixed,
            onTap: onTap),
      ),
    );
  }

  void onTap(int index) {
    pageController.jumpToPage(index);
  }

  void onPageChanged(int page) {
    setState(() {
      this.pageIndex = page;
      switch (page) {
        case 0:
          title = TextResources.homeMateTitle;
          break;
        case 1:
          title = TextResources.homeChatTitle;
          break;
        case 2:
          title = TextResources.homeMyTitle;
          break;
      }
    });
    if(page == 1 || page == 2){
      Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage())).then((result){
        if(result == null){
          pageController.jumpToPage(0);
        }
      });
    }
  }
}