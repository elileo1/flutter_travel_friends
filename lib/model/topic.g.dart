// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'topic.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Topic _$TopicFromJson(Map<String, dynamic> json) {
  return Topic(
      json['topicId'] as String,
      json['userId'] as String,
      json['sex'] as int,
      json['headImg'] as String,
      json['age'] as int,
      json['nickname'] as String,
      json['beginTime'] as int,
      json['endTime'] as int,
      json['content'] as String,
      json['addressId'] as String,
      json['addressStr'] as String,
      json['status'] as int,
      json['createdTime'] as int,
      (json['imagesList'] as List)?.map((e) => e as String)?.toList(),
      json['images'] as String,
      json['liked'] as bool,
      json['likeNum'] as int,
      json['commentNum'] as int,
      json['shareNum'] as int,
      json['isOverdue'] as bool,
      json['location'] as String);
}

Map<String, dynamic> _$TopicToJson(Topic instance) => <String, dynamic>{
      'topicId': instance.topicId,
      'userId': instance.userId,
      'sex': instance.sex,
      'headImg': instance.headImg,
      'age': instance.age,
      'nickname': instance.nickname,
      'beginTime': instance.beginTime,
      'endTime': instance.endTime,
      'content': instance.content,
      'addressId': instance.addressId,
      'addressStr': instance.addressStr,
      'status': instance.status,
      'createdTime': instance.createdTime,
      'imagesList': instance.imagesList,
      'images': instance.images,
      'liked': instance.liked,
      'likeNum': instance.likeNum,
      'commentNum': instance.commentNum,
      'shareNum': instance.shareNum,
      'isOverdue': instance.isOverdue,
      'location': instance.location
    };
