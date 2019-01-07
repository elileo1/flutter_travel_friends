import 'package:dio/dio.dart';
///create by elileo on 2018/12/18
import 'package:flutter/material.dart';
import 'package:travel_friend/api/HttpExt.dart';
import 'package:travel_friend/api/Api.dart';
import 'package:travel_friend/model/topic.dart';
import 'package:travel_friend/common/constants.dart';
import 'package:travel_friend/common/GlobalConfig.dart';
import 'package:travel_friend/common/TextResources.dart';
import 'package:travel_friend/pages/mate/AddressPage.dart';
import 'package:travel_friend/pages/mate/DepartureTimePage.dart';
import 'package:travel_friend/pages/mate/homeWidget.dart';
import 'package:travel_friend/widget/PopupWindow.dart';
import 'package:travel_friend/common/Application.dart';
import 'package:travel_friend/model/departure.dart';

class HomePage extends StatefulWidget{
  @override
  _HomePageState createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> with AutomaticKeepAliveClientMixin{
  ScrollController _scrollController = ScrollController();

  GlobalKey<RefreshIndicatorState> refreshIndicatorKey = new GlobalKey<RefreshIndicatorState>();

  int currentPage = 1;
  int pageSize = 30;
  bool isFirstLoad = true;
  bool isLoadingData = false;
  bool isRequestError = false;
  bool hasMoreData = false;
  List listData;

  int whichHeaderSelect = -1;
  String dateSelectStr;

  String addressSelectStr;

  Departure dateParam;
  String paramAddressId = "";

  _HomePageState():
        dateSelectStr = Application.selectDateStr,
        addressSelectStr = TextResources.headerDefaultTips;

  @override
  void initState() {
    super.initState();
    _requestData();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        if(hasMoreData && !isLoadingData){
          isLoadingData = true;
          _getMore();
        }
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  Future<Null> _getMore() async{
    currentPage ++;
    _requestData();
  }

  Future<Null> _requestData() async{
    Map<String, Object> params = new Map<String, Object>();
    params["currentPage"] = currentPage.toString();
    params["pageSize"] = pageSize.toString();
    if(dateParam != null){
      FormData formData = new FormData.from(dateParam.toJson());
      params["date"] = formData;
    }
    if(paramAddressId != ""){
      params["addressId"] = paramAddressId;
    }

    await HttpExt.post(Api.homeMateUrl, (data){
      if(!mounted){
        return;
      }
      setState(() {
        isFirstLoad = false;
        isRequestError = false;
        List<Topic> result = new List();
        if(data != null){
          result = getTopicList(data);
        }
        if(result != null && result.isNotEmpty && result.length == pageSize){
          hasMoreData = true;
        }else{
          hasMoreData = false;
        }
        if(currentPage == 1){
          listData = result;
        }else{
          List list = new List();
          list.addAll(listData);
          list.addAll(result);
          listData = list;
        }
      });
      isLoadingData = false;
    }, params: params, errorCallBack: (errorMsg){
      isLoadingData = false;
      if(currentPage > 1){
        currentPage -= 1;
        showToast(TextResources.checkNet);
      }else if(isFirstLoad){
        setState(() {
          isRequestError = true;
          isFirstLoad = false;
        });
      }else{
        showToast(TextResources.checkNet);
      }
    });
  }

  Future<Null> _refresh() async{
    if(!isLoadingData){
      isLoadingData = true;
      currentPage = 1;
      await _requestData();
      setState(() {
        dateSelectStr = Application.selectDateStr;
      });
    }
  }

  Future<Null> _retry() async{
    setState(() {
      isFirstLoad = true;
      isRequestError = false;
    });
    _requestData();
  }

  void _goTimeHeadClick(){
    setState(() {
      whichHeaderSelect = 0;
    });

    _showPopup(0);
  }

  void _refreshAddressHeader(String addressName, String addressId, int type, bool isSelect){
    String result;
    if(isSelect){
      paramAddressId = addressId;
      result = addressName;
      if(type == 0 && addressId == "0"){
        result = TextResources.addressTabChina;
      }else if(type == 1 && addressId == "1"){
        result = TextResources.addressTabSea;
      }
    }else{
      paramAddressId = "";
      result = TextResources.headerDefaultTips;
    }
    setState(() {
      addressSelectStr = result;
      isFirstLoad = true;
      isLoadingData = false;
      isRequestError = false;
      hasMoreData = false;
      listData = null;
    });
    _requestData();
  }

  void _refreshTimeHeader(Departure bean){
    if(dateSelectStr == bean.dateStr){
      return;
    }

    setState(() {
      dateSelectStr = bean.dateStr;
      isFirstLoad = true;
      isLoadingData = false;
      isRequestError = false;
      hasMoreData = false;
      listData = null;
    });
    currentPage = 1;
    if(bean.dateValue == -1 && bean.dateStr == TextResources.headerDefaultTips){
      dateParam = null;
    }else{
      dateParam = bean;
    }
    _requestData();
  }

  void _showPopup(index){
    final RenderBox button = context.findRenderObject();
    final RenderBox overlay = Overlay.of(context).context.findRenderObject();
    final RelativeRect position = RelativeRect.fromRect(
      Rect.fromPoints(button.localToGlobal(Offset(0,46), ancestor: overlay),
        button.localToGlobal(button.size.bottomRight(Offset(0, 0)),
            ancestor: overlay),
      ),
      Offset.zero & overlay.size,
    );
    showPopupWindow(context: context,
        child: index == 0 ? DepartureTimePage(timeSelect:_refreshTimeHeader) : AddressPage(addressSelect: _refreshAddressHeader),
        fullWidth: true,
        position: position,
        elevation: 20.0
    ).then((result){
      setState(() {
        whichHeaderSelect = -1;
      });
    });
  }

  void _targetHeaderClick(){
    setState(() {
      whichHeaderSelect = 1;
    });
    _showPopup(1);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        _buildHeader(context),
        Expanded(
          child: _buildList(context)
        )
      ],
    );
  }

  Widget _buildHeader(BuildContext context){
    return SizedBox(
      height: 46,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: GestureDetector(
                onTap: _goTimeHeadClick,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(TextResources.goTimeTips, style: TextStyle(fontSize: 14, color: whichHeaderSelect == 0 ? GlobalConfig.colorED9700 : GlobalConfig.color606060)),
                      Padding(
                          padding: const EdgeInsets.only(left: 6)
                      ),
                      Container(
                        constraints: BoxConstraints(
                            maxWidth: MediaQuery.of(context).size.width / 2 - 108
                        ),
                        child:  Text(dateSelectStr,style: TextStyle(fontSize: 14, color: whichHeaderSelect == 0 ? GlobalConfig.colorED9700 : GlobalConfig.color606060), maxLines: 1, overflow: TextOverflow.ellipsis),
                      ),
                      Padding(
                          padding: const EdgeInsets.only(left: 8)
                      ),
                      Image.asset(whichHeaderSelect == 0 ? "images/icon_arrow_up.png" : "images/icon_arrow_down.png", width: 10, height: 7,)
                    ]
                )
              )
            ),
            Expanded(
              child: GestureDetector(
                onTap: _targetHeaderClick,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(TextResources.targetDes, style: TextStyle(fontSize: 14, color: whichHeaderSelect == 1 ? GlobalConfig.colorED9700 : GlobalConfig.color606060)),
                      Padding(
                          padding: const EdgeInsets.only(left: 6)
                      ),
                      Container(
                        constraints: BoxConstraints(
                            maxWidth: MediaQuery.of(context).size.width / 2 - 84
                        ),
                        child:  Text(addressSelectStr, style: TextStyle(fontSize: 14, color: whichHeaderSelect == 1 ? GlobalConfig.colorED9700 : GlobalConfig.color606060), maxLines: 1, overflow: TextOverflow.ellipsis),
                      ),
                      Padding(
                          padding: const EdgeInsets.only(left: 8)
                      ),
                      Image.asset(whichHeaderSelect == 1 ? "images/icon_arrow_up.png" : "images/icon_arrow_down.png", width: 10, height: 7,)
                    ]
                )
              )
            )
          ],
        ),
      ),
    );
  }

  Widget _buildList(BuildContext context){
    if(isFirstLoad){
      return buildLoadingIndicator();
    }
    if(isRequestError){
      return buildNetBroken(TextResources.netBrokenTips, _retry);
    }
    if(listData != null && listData.length > 0){
      return RefreshIndicator(
        key: refreshIndicatorKey,
        color: GlobalConfig.colorFFB600,
        child: new ListView.builder(
            controller: _scrollController,
            physics: const AlwaysScrollableScrollPhysics(),
            itemCount: hasMoreData ? listData.length + 1 : listData.length,
            itemBuilder: (context, index){
              if(index < listData.length){
                return buildMateItem(context, index, listData[index]);
              }
              return buildLoadMore();
            }
        ),
        onRefresh: _refresh,
      );
    }
    return buildNetBroken(TextResources.noData, _retry);
  }

  @override
  bool get wantKeepAlive => true;
}

