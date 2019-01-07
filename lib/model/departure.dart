import 'package:json_annotation/json_annotation.dart';

part 'departure.g.dart';


List<Departure> getDepartureList(List<dynamic> list){
  List<Departure> result = [];
  list.forEach((item){
    result.add(Departure.fromJson(item));
  });
  return result;
}
@JsonSerializable()
class Departure extends Object {

  @JsonKey(name: 'dateStr')
  String dateStr;

  @JsonKey(name: 'dateValue')
  int dateValue;

  @JsonKey(name: 'condition')
  String condition;

  Departure(this.dateStr,this.dateValue,this.condition,);

  factory Departure.fromJson(Map<String, dynamic> srcJson) => _$DepartureFromJson(srcJson);

  Map<String, dynamic> toJson() => _$DepartureToJson(this);


}