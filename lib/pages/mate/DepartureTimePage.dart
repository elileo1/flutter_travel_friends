///create by elileo on 2018/12/21
import 'package:flutter/material.dart';
import 'package:travel_friend/api/Api.dart';
import 'package:travel_friend/api/HttpExt.dart';
import 'package:travel_friend/common/GlobalConfig.dart';
import 'package:travel_friend/common/TextResources.dart';
import 'package:travel_friend/model/departure.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:travel_friend/common/Application.dart';

typedef void TimeSelect(Departure bean);

class DepartureTimePage extends StatefulWidget{
  final TimeSelect timeSelect;

  DepartureTimePage({Key key, this.timeSelect}): super(key: key);

  @override
  _DepartureTimePageState createState() => new _DepartureTimePageState();
}

class _DepartureTimePageState extends State<DepartureTimePage>{
  List<Departure> dateList;
  int dateValue = -1;
  List<Departure> unLimitList;
  final Departure bean = new Departure(TextResources.headerDefaultTips, -1, "");

  _DepartureTimePageState(): 
        dateValue = Application.selectDateValue, 
        unLimitList = new List();

  @override
  void initState() {
    super.initState();
    _getData();
  }

  @override
  Widget build(BuildContext context) {
    unLimitList.clear();
    unLimitList.add(bean);
    return dateList != null && dateList.isNotEmpty ?
    Column(
      children: <Widget>[
        Divider(height: 1, color: GlobalConfig.colorC0C0C0),
        Container(
            padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 20),
            child: Column(
              children: <Widget>[
                GridView.count(
                    physics: new NeverScrollableScrollPhysics(),
                    crossAxisCount: 3,
                    childAspectRatio: 3,
                    shrinkWrap: true,
                    mainAxisSpacing: 22.0,
                    crossAxisSpacing: 10.0,
                    children: _buildItemList(context, unLimitList))
              ],
            )
        ),
        Divider(height: 1, color: GlobalConfig.colorC0C0C0),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 20),
          child: Column(
            children: <Widget>[
              GridView.count(
                  physics: new NeverScrollableScrollPhysics(),
                  crossAxisCount: 3,
                  childAspectRatio: 3,
                  shrinkWrap: true,
                  mainAxisSpacing: 22.0,
                  crossAxisSpacing: 10.0,
                  children: _buildItemList(context, dateList))
            ],
          )
        )
      ],
    ): Container(

    );
  }

  List<Container> _buildItemList(context, List<Departure> listData) {
    return new List<Container>.generate(
        listData.length,
            (int index) => new Container(
            child: _buildItem(listData[index])
        ));
  }

  Widget _buildItem(Departure departure){
    return GestureDetector(
        onTap: () {
          Application.selectDateValue = departure.dateValue;
          Application.selectDateStr = departure.dateStr;
          widget.timeSelect(departure);
          Navigator.of(context).pop();
        },
        child: Container(
          alignment: Alignment.center,
          child: Text(departure.dateStr, style: TextStyle(fontSize: 14, color: dateValue == departure.dateValue ? GlobalConfig.colorPrimary : GlobalConfig.color0D0E15)),
          decoration: BoxDecoration(
            border: new Border.all(
                width: 1.0,
                color: dateValue == departure.dateValue ? GlobalConfig.colorFFB600 : GlobalConfig.colorC0C0C0),
            color: dateValue == departure.dateValue ? GlobalConfig.colorFFB600 : Colors.white,
            borderRadius:
            new BorderRadius.all(new Radius.circular(20.0)),
          ),
        )
    );
  }

  Future<Null> _requestData(isRefresh) async{
    await HttpExt.get(Api.homeDateListUrl, (data){
      List<Departure> result = getDepartureList(data);
      Application.dateList = result;
      if(isRefresh){
        setState(() {
          dateList = result;
        });
      }
      _saveData(data);
    },errorCallBack: (errorMsg){

    });
  }

  void _saveData(data) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("key_date_list", json.encode(data));
  }

  void _getData() async{
    List<Departure> result = Application.dateList;
    if(result == null || result.isEmpty){
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String data = prefs.getString("key_date_list");
      if(data == null || data.isEmpty){
        _requestData(true);
        return;
      }else{
        result = getDepartureList(json.decode(data));
      }
    }
    setState(() {
      dateList = result;
    });
    _requestData(false);
  }
}