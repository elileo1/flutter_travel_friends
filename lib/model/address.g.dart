// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'address.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Address _$AddressFromJson(Map<String, dynamic> json) {
  return Address(
      json['addressId'] as String,
      json['name'] as String,
      json['type'] as int,
      json['parentId'] as String,
      json['sortNum'] as int,
      json['createdTime'] as int,
      json['status'] as int,
      (json['childList'] as List)
          ?.map((e) =>
              e == null ? null : ChildList.fromJson(e as Map<String, dynamic>))
          ?.toList());
}

Map<String, dynamic> _$AddressToJson(Address instance) => <String, dynamic>{
      'addressId': instance.addressId,
      'name': instance.name,
      'type': instance.type,
      'parentId': instance.parentId,
      'sortNum': instance.sortNum,
      'createdTime': instance.createdTime,
      'status': instance.status,
      'childList': instance.childList
    };

ChildList _$ChildListFromJson(Map<String, dynamic> json) {
  return ChildList(
      json['addressId'] as String,
      json['name'] as String,
      json['type'] as int,
      json['parentId'] as String,
      json['sortNum'] as int,
      json['createdTime'] as int,
      json['status'] as int);
}

Map<String, dynamic> _$ChildListToJson(ChildList instance) => <String, dynamic>{
      'addressId': instance.addressId,
      'name': instance.name,
      'type': instance.type,
      'parentId': instance.parentId,
      'sortNum': instance.sortNum,
      'createdTime': instance.createdTime,
      'status': instance.status
    };
