// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'follow_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FollowData _$FollowDataFromJson(Map<String, dynamic> json) =>
    FollowData(
      json['id'] as int,
      json['uid'] as int,
      json['title'] as String,
      json['content'] as String,
      json['avatar'] as String,
      json['nickname'] as String,
      json['fav'] as int,
      json['like'] as int,
      json['comment'] as int,
      json['date'] as String,
      json['address'] as String,
      (json['images'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$FollowDataToJson(FollowData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'uid': instance.uid,
      'title': instance.title,
      'content': instance.content,
      'avatar': instance.avatar,
      'nickname': instance.nickname,
      'fav': instance.fav,
      'like': instance.like,
      'comment': instance.comment,
      'date': instance.date,
      'address': instance.address,
      'images': instance.images,
    };
