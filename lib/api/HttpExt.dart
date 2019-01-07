///create by elileo on 2018/12/18
import 'package:dio/dio.dart';
import 'package:travel_friend/common/TextResources.dart';

class HttpExt{
  static const String GET = "get";
  static const String POST = "post";
  static Options _options = new Options(connectTimeout: 5000, receiveTimeout: 5000);
  static Dio _dio = new Dio(_options);

  static Future<Null> get(String url, Function callBack, {Map<String, Object> params, Function errorCallBack}) async{
    await _request(url, callBack,
        method: GET, params: params, errorCallBack: errorCallBack);
  }

  static Future<Null> post(String url, Function callBack, {Map<String, Object> params, Function errorCallBack}) async{
    await _request(url, callBack, method: POST, params: params, errorCallBack: errorCallBack);
  }

  static Future<Null> _request(String url, Function callBack, {String method, Map<String, Object> params, Function errorCallBack}) async{
    String errorMsg = "";
    int statusCode;
    try{
      Response response;
      if(method == GET){
        if(params != null && params.isNotEmpty){
          StringBuffer sb = new StringBuffer("?");
          params.forEach((key, value){
            sb.write("$key" + "=" + "$value" + "&");
          });
          String paramStr = sb.toString();
          paramStr = paramStr.substring(0, paramStr.length - 1);
          url += paramStr;
        }
        response = await _dio.get(url);
      }else{
        if (params != null && params.isNotEmpty) {
          response = await _dio.post(url, data: params);
        } else {
          response = await _dio.post(url);
        }
      }
      statusCode = response.statusCode;
      //处理错误部分
      if (statusCode != 200) {
        errorMsg = TextResources.netErrorMsg + statusCode.toString();
        _handError(errorCallBack, errorMsg);
        return;
      }

      if (callBack != null) {
        callBack(response.data["data"]);
      }
    }catch(exception){
      _handError(errorCallBack, exception.toString());
    }
  }

  static void _handError(Function errorCallBack, String errorMsg){
    if(errorCallBack != null){
      errorCallBack(errorMsg);
    }
  }
}