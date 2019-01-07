import 'dart:convert';

///create by elileo on 2018/12/21
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travel_friend/api/Api.dart';
import 'package:travel_friend/api/HttpExt.dart';
import 'package:travel_friend/common/Application.dart';
import 'package:travel_friend/common/GlobalConfig.dart';
import 'package:travel_friend/model/address.dart';

typedef void AddressSelect(String addressName, String addressId, int type, bool isSelect);

class AddressDetailPage extends StatefulWidget{
  final int type;
  final AddressSelect addressSelect;

  AddressDetailPage({@required this.type, @required this.addressSelect}):super();

  @override
  _AddressDetailPageState createState() {
    int provinceIndex = (type == 0 ? Application.provinceIndex : Application.seaProvinceIndex);
    int cityIndex = (type == 0 ? Application.cityIndex : Application.seaCityIndex);
    return new _AddressDetailPageState(selectProvinceIndex:  provinceIndex, selectCityIndex: cityIndex);
  }
}

class _AddressDetailPageState extends State<AddressDetailPage> with AutomaticKeepAliveClientMixin{
  List<Address> addressList;
  int selectProvinceIndex;
  int selectCityIndex;

  _AddressDetailPageState({@required this.selectProvinceIndex, @required this.selectCityIndex}):super();

  @override
  void initState() {
    super.initState();
    _getData();
  }

  Widget _buildProvince(context, Address address, index){
    return SizedBox(
      height: 50,
      child: FlatButton(
        onPressed: (){
          if(selectProvinceIndex == index){
            return;
          }
          if(widget.type == 0){
            Application.provinceIndex = index;
          }else{
            Application.seaProvinceIndex = index;
          }
          setState(() {
            selectProvinceIndex = index;
            selectCityIndex = -1;
          });
        },
        child: Text(address.name, style: TextStyle(fontSize: 14, color: selectProvinceIndex == index ? GlobalConfig.colorED9700 : GlobalConfig.color0D0E15)),
      ),
    );
  }

  Widget _buildCity(context, ChildList child, index){
    return SizedBox(
      height: 50,
      child: FlatButton(
        onPressed: (){
          bool isSelect = true;
          if(selectCityIndex == index){
            isSelect = false;
          }
          if(widget.type == 0){
            Application.cityIndex = isSelect ? index : -1;
          }else{
            Application.seaCityIndex = isSelect ? index : -1;
          }
          setState(() {
            selectCityIndex = isSelect ? index : -1;
          });
          widget.addressSelect(child.name, child.addressId, widget.type, isSelect);
          Navigator.of(context).pop();
        },
        padding: EdgeInsets.only(left: 0, right: 0),
        color: GlobalConfig.colorF7F7F7,
        child: Container(
            decoration: BoxDecoration(border: Border(bottom: BorderSide(color: GlobalConfig.colorC0C0C0))),
            alignment: Alignment.centerLeft,
            child: Container(
              padding: EdgeInsets.only(left: 20),
              child: Text(child.name, style: TextStyle(fontSize: 14, color: selectCityIndex == index ? GlobalConfig.colorED9700 : GlobalConfig.color0D0E15)),
            )
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return addressList != null ? Row(
      children: <Widget>[
        Expanded(
          flex: 1,
          child: ListView.builder(
              itemCount: addressList.length,
              itemBuilder: (context, index){
                return _buildProvince(context, addressList[index], index);
              }
          ),
        ),
        Expanded(
          flex: 2,
          child: ListView.builder(
              itemCount: addressList[selectProvinceIndex].childList.length,
              itemBuilder: (context, index){
                return _buildCity(context, addressList[selectProvinceIndex].childList[index], index);
              }
          ),
        )
      ],
    ):
    Container();
  }

  Future<Null> _requestData(isRefresh) async{
    Map<String, Object> params = new Map<String, Object>();
    params["type"] = widget.type.toString();

    await HttpExt.get(Api.homeAddressListUrl, (data){
      List<Address> result = getAddressList(data);
      if(widget.type == 0){
        Application.address = result;
      }else{
        Application.addressSea = result;
      }
      if(isRefresh){
        setState(() {
          addressList = result;
        });
      }
      _saveData(data);
    },params: params, errorCallBack: (errorMsg){
      print(errorMsg);
    });
  }

  void _saveData(data) async{
    String nativeKey = (widget.type == 0 ? "key_address_list" : "key_address_sea_list");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(nativeKey, json.encode(data));
  }

  void _getData() async{
    String nativeKey = (widget.type == 0 ? "key_address_list" : "key_address_sea_list");
    List<Address> result = (widget.type == 0 ? Application.address : Application.addressSea);
    if(result == null){
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String data = prefs.getString(nativeKey);
      if(data == null){
        _requestData(true);
        return;
      }else{
        result = getAddressList(json.decode(data));
      }
    }
    setState(() {
      addressList = result;
    });
    _requestData(false);
  }

  @override
  bool get wantKeepAlive => true;
}

