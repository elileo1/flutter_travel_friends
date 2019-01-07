import 'package:json_annotation/json_annotation.dart';

part 'address.g.dart';


List<Address> getAddressList(List<dynamic> list){
  List<Address> result = [];
  list.forEach((item){
    result.add(Address.fromJson(item));
  });
  return result;
}
@JsonSerializable()
class Address extends Object {

  @JsonKey(name: 'addressId')
  String addressId;

  @JsonKey(name: 'name')
  String name;

  @JsonKey(name: 'type')
  int type;

  @JsonKey(name: 'parentId')
  String parentId;

  @JsonKey(name: 'sortNum')
  int sortNum;

  @JsonKey(name: 'createdTime')
  int createdTime;

  @JsonKey(name: 'status')
  int status;

  @JsonKey(name: 'childList')
  List<ChildList> childList;

  Address(this.addressId,this.name,this.type,this.parentId,this.sortNum,this.createdTime,this.status,this.childList,);

  factory Address.fromJson(Map<String, dynamic> srcJson) => _$AddressFromJson(srcJson);

  Map<String, dynamic> toJson() => _$AddressToJson(this);

}


@JsonSerializable()
class ChildList extends Object {

  @JsonKey(name: 'addressId')
  String addressId;

  @JsonKey(name: 'name')
  String name;

  @JsonKey(name: 'type')
  int type;

  @JsonKey(name: 'parentId')
  String parentId;

  @JsonKey(name: 'sortNum')
  int sortNum;

  @JsonKey(name: 'createdTime')
  int createdTime;

  @JsonKey(name: 'status')
  int status;

  ChildList(this.addressId,this.name,this.type,this.parentId,this.sortNum,this.createdTime,this.status,);

  factory ChildList.fromJson(Map<String, dynamic> srcJson) => _$ChildListFromJson(srcJson);

  Map<String, dynamic> toJson() => _$ChildListToJson(this);

}