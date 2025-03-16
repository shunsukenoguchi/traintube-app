// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'video_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$VideoInfoImpl _$$VideoInfoImplFromJson(Map<String, dynamic> json) =>
    _$VideoInfoImpl(
      url: json['url'] as String,
      title: json['title'] as String,
      channelName: json['channelName'] as String,
      index: (json['index'] as num).toInt(),
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$$VideoInfoImplToJson(_$VideoInfoImpl instance) =>
    <String, dynamic>{
      'url': instance.url,
      'title': instance.title,
      'channelName': instance.channelName,
      'index': instance.index,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };
