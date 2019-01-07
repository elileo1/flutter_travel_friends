import 'package:json_annotation/json_annotation.dart';

part 'topic.g.dart';


List<Topic> getTopicList(List<dynamic> list){
  List<Topic> result = [];
  list.forEach((item){
    result.add(Topic.fromJson(item));
  });
  return result;
}
@JsonSerializable()
class Topic extends Object {

  @JsonKey(name: 'topicId')
  String topicId;

  @JsonKey(name: 'userId')
  String userId;

  @JsonKey(name: 'sex')
  int sex;

  @JsonKey(name: 'headImg')
  String headImg;

  @JsonKey(name: 'age')
  int age;

  @JsonKey(name: 'nickname')
  String nickname;

  @JsonKey(name: 'beginTime')
  int beginTime;

  @JsonKey(name: 'endTime')
  int endTime;

  @JsonKey(name: 'content')
  String content;

  @JsonKey(name: 'addressId')
  String addressId;

  @JsonKey(name: 'addressStr')
  String addressStr;

  @JsonKey(name: 'status')
  int status;

  @JsonKey(name: 'createdTime')
  int createdTime;

  @JsonKey(name: 'imagesList')
  List<String> imagesList;

  @JsonKey(name: 'images')
  String images;

  @JsonKey(name: 'liked')
  bool liked;

  @JsonKey(name: 'likeNum')
  int likeNum;

  @JsonKey(name: 'commentNum')
  int commentNum;

  @JsonKey(name: 'shareNum')
  int shareNum;

  @JsonKey(name: 'isOverdue')
  bool isOverdue;

  @JsonKey(name: 'location')
  String location;

  Topic(this.topicId,this.userId,this.sex,this.headImg,this.age,this.nickname,this.beginTime,this.endTime,this.content,this.addressId,this.addressStr,this.status,this.createdTime,this.imagesList,this.images,this.liked,this.likeNum,this.commentNum,this.shareNum,this.isOverdue,this.location,);

  factory Topic.fromJson(Map<String, dynamic> srcJson) => _$TopicFromJson(srcJson);

  Map<String, dynamic> toJson() => _$TopicToJson(this);

}
