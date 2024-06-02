import 'package:json_annotation/json_annotation.dart';

part 'follow_data.g.dart';

@JsonSerializable()
class FollowData {
  int id;
  int uid;
  String title;
  String content;
  String avatar;
  String nickname;
  int fav;
  int like;
  int comment;
  String date;
  String address;
  List<String> images;

  FollowData(this.id, this.uid, this.title, this.content, this.avatar, this.nickname, this.fav,
      this.like, this.comment, this.date, this.address, this.images);

  factory FollowData.fromJson(Map<String, dynamic> srcJson) =>
      _$FollowDataFromJson(srcJson);

  Map<String, dynamic> toJson() => _$FollowDataToJson(this);
}
