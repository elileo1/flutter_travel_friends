import 'package:travel_friend/model/address.dart';
///create by elileo on 2018/12/21
import "package:travel_friend/model/departure.dart";
import 'package:travel_friend/common/TextResources.dart';
class Application{
  static List<Departure> dateList;
  static int selectDateValue = -1;
  static String selectDateStr = TextResources.headerDefaultTips;

  static List<Address> address;
  static List<Address> addressSea;

  static int selectAddressType = 0;
  static int provinceIndex = 0;
  static int cityIndex = -1;

  static int seaProvinceIndex = 0;
  static int seaCityIndex = -1;
}