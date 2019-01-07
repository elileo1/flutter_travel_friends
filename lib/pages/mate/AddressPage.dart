///create by elileo on 2018/12/21
import 'package:flutter/material.dart';
import 'package:travel_friend/common/GlobalConfig.dart';
import 'package:travel_friend/widget/AddressTabPage.dart';
import 'package:travel_friend/pages/mate/AddressDetailPage.dart';

class AddressPage extends StatefulWidget{
  final AddressSelect addressSelect;
  AddressPage({this.addressSelect}): super();
  @override
  _AddressPageState createState() => new _AddressPageState();
}

class _AddressPageState extends State<AddressPage> with SingleTickerProviderStateMixin {
  TabController _controller;
  AddressTabPage addressTabPage;
  List<AddressTabPage> addressTab;

  @override
  void initState() {
    super.initState();
    addressTabPage = new AddressTabPage(addressSelect: widget.addressSelect);
    addressTab = addressTabPage.initClassify();
    _controller = new TabController(vsync: this, length: addressTab.length);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Divider(height: 1, color: GlobalConfig.colorC0C0C0),
        SizedBox(
          height: 46,
          child: Container(
            alignment: Alignment.centerLeft,
            child: new TabBar(
              controller: _controller,
              indicatorColor: GlobalConfig.colorED9700,
              isScrollable: true,
              labelColor: GlobalConfig.colorED9700,
              labelStyle: TextStyle(fontSize: 14),
              unselectedLabelColor: GlobalConfig.color606060,
              tabs: addressTab.map((AddressTabPage page) {
                return new Tab(text: page.text);
              }).toList(),
            ),
          ),
        ),
        Divider(height: 1, color: GlobalConfig.colorC0C0C0),
        SizedBox(
          height: MediaQuery.of(context).size.height / 2,
          child: TabBarView(
              controller: _controller,
              children: addressTab.map((AddressTabPage page) {
                return page.detailPage;
              }).toList()
          ),
        ),
      ],
    );
  }

}