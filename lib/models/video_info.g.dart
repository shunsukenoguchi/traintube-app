// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'video_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$VideoInfoImpl _$$VideoInfoImplFromJson(Map<String, dynamic> json) =>
    _$VideoInfoImpl(
      id: json['id'] as String? ?? '',
      url: json['url'] as String,
      title: json['title'] as String,
      channelName: json['channelName'] as String,
      index: (json['index'] as num).toInt(),
      categoryIndex: (json['categoryIndex'] as num?)?.toInt() ?? 0,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      categoryId: json['categoryId'] as String?,
    );

Map<String, dynamic> _$$VideoInfoImplToJson(_$VideoInfoImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'url': instance.url,
      'title': instance.title,
      'channelName': instance.channelName,
      'index': instance.index,
      'categoryIndex': instance.categoryIndex,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      'categoryId': instance.categoryId,
    };
