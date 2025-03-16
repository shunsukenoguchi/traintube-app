// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'video_record.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$VideoRecordImpl _$$VideoRecordImplFromJson(Map<String, dynamic> json) =>
    _$VideoRecordImpl(
      videoId: json['videoId'] as String,
      title: json['title'] as String,
      channelName: json['channelName'] as String,
      recordedAt: DateTime.parse(json['recordedAt'] as String),
    );

Map<String, dynamic> _$$VideoRecordImplToJson(_$VideoRecordImpl instance) =>
    <String, dynamic>{
      'videoId': instance.videoId,
      'title': instance.title,
      'channelName': instance.channelName,
      'recordedAt': instance.recordedAt.toIso8601String(),
    };
