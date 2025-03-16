// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'video_info.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

VideoInfo _$VideoInfoFromJson(Map<String, dynamic> json) {
  return _VideoInfo.fromJson(json);
}

/// @nodoc
mixin _$VideoInfo {
  String get id => throw _privateConstructorUsedError;
  String get url => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get channelName => throw _privateConstructorUsedError;
  int get index => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime get updatedAt => throw _privateConstructorUsedError;
  String? get categoryId => throw _privateConstructorUsedError;

  /// Serializes this VideoInfo to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of VideoInfo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $VideoInfoCopyWith<VideoInfo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $VideoInfoCopyWith<$Res> {
  factory $VideoInfoCopyWith(VideoInfo value, $Res Function(VideoInfo) then) =
      _$VideoInfoCopyWithImpl<$Res, VideoInfo>;
  @useResult
  $Res call({
    String id,
    String url,
    String title,
    String channelName,
    int index,
    DateTime createdAt,
    DateTime updatedAt,
    String? categoryId,
  });
}

/// @nodoc
class _$VideoInfoCopyWithImpl<$Res, $Val extends VideoInfo>
    implements $VideoInfoCopyWith<$Res> {
  _$VideoInfoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of VideoInfo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? url = null,
    Object? title = null,
    Object? channelName = null,
    Object? index = null,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? categoryId = freezed,
  }) {
    return _then(
      _value.copyWith(
            id:
                null == id
                    ? _value.id
                    : id // ignore: cast_nullable_to_non_nullable
                        as String,
            url:
                null == url
                    ? _value.url
                    : url // ignore: cast_nullable_to_non_nullable
                        as String,
            title:
                null == title
                    ? _value.title
                    : title // ignore: cast_nullable_to_non_nullable
                        as String,
            channelName:
                null == channelName
                    ? _value.channelName
                    : channelName // ignore: cast_nullable_to_non_nullable
                        as String,
            index:
                null == index
                    ? _value.index
                    : index // ignore: cast_nullable_to_non_nullable
                        as int,
            createdAt:
                null == createdAt
                    ? _value.createdAt
                    : createdAt // ignore: cast_nullable_to_non_nullable
                        as DateTime,
            updatedAt:
                null == updatedAt
                    ? _value.updatedAt
                    : updatedAt // ignore: cast_nullable_to_non_nullable
                        as DateTime,
            categoryId:
                freezed == categoryId
                    ? _value.categoryId
                    : categoryId // ignore: cast_nullable_to_non_nullable
                        as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$VideoInfoImplCopyWith<$Res>
    implements $VideoInfoCopyWith<$Res> {
  factory _$$VideoInfoImplCopyWith(
    _$VideoInfoImpl value,
    $Res Function(_$VideoInfoImpl) then,
  ) = __$$VideoInfoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String url,
    String title,
    String channelName,
    int index,
    DateTime createdAt,
    DateTime updatedAt,
    String? categoryId,
  });
}

/// @nodoc
class __$$VideoInfoImplCopyWithImpl<$Res>
    extends _$VideoInfoCopyWithImpl<$Res, _$VideoInfoImpl>
    implements _$$VideoInfoImplCopyWith<$Res> {
  __$$VideoInfoImplCopyWithImpl(
    _$VideoInfoImpl _value,
    $Res Function(_$VideoInfoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of VideoInfo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? url = null,
    Object? title = null,
    Object? channelName = null,
    Object? index = null,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? categoryId = freezed,
  }) {
    return _then(
      _$VideoInfoImpl(
        id:
            null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                    as String,
        url:
            null == url
                ? _value.url
                : url // ignore: cast_nullable_to_non_nullable
                    as String,
        title:
            null == title
                ? _value.title
                : title // ignore: cast_nullable_to_non_nullable
                    as String,
        channelName:
            null == channelName
                ? _value.channelName
                : channelName // ignore: cast_nullable_to_non_nullable
                    as String,
        index:
            null == index
                ? _value.index
                : index // ignore: cast_nullable_to_non_nullable
                    as int,
        createdAt:
            null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                    as DateTime,
        updatedAt:
            null == updatedAt
                ? _value.updatedAt
                : updatedAt // ignore: cast_nullable_to_non_nullable
                    as DateTime,
        categoryId:
            freezed == categoryId
                ? _value.categoryId
                : categoryId // ignore: cast_nullable_to_non_nullable
                    as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$VideoInfoImpl implements _VideoInfo {
  const _$VideoInfoImpl({
    this.id = '',
    required this.url,
    required this.title,
    required this.channelName,
    required this.index,
    required this.createdAt,
    required this.updatedAt,
    this.categoryId,
  });

  factory _$VideoInfoImpl.fromJson(Map<String, dynamic> json) =>
      _$$VideoInfoImplFromJson(json);

  @override
  @JsonKey()
  final String id;
  @override
  final String url;
  @override
  final String title;
  @override
  final String channelName;
  @override
  final int index;
  @override
  final DateTime createdAt;
  @override
  final DateTime updatedAt;
  @override
  final String? categoryId;

  @override
  String toString() {
    return 'VideoInfo(id: $id, url: $url, title: $title, channelName: $channelName, index: $index, createdAt: $createdAt, updatedAt: $updatedAt, categoryId: $categoryId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$VideoInfoImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.url, url) || other.url == url) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.channelName, channelName) ||
                other.channelName == channelName) &&
            (identical(other.index, index) || other.index == index) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.categoryId, categoryId) ||
                other.categoryId == categoryId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    url,
    title,
    channelName,
    index,
    createdAt,
    updatedAt,
    categoryId,
  );

  /// Create a copy of VideoInfo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$VideoInfoImplCopyWith<_$VideoInfoImpl> get copyWith =>
      __$$VideoInfoImplCopyWithImpl<_$VideoInfoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$VideoInfoImplToJson(this);
  }
}

abstract class _VideoInfo implements VideoInfo {
  const factory _VideoInfo({
    final String id,
    required final String url,
    required final String title,
    required final String channelName,
    required final int index,
    required final DateTime createdAt,
    required final DateTime updatedAt,
    final String? categoryId,
  }) = _$VideoInfoImpl;

  factory _VideoInfo.fromJson(Map<String, dynamic> json) =
      _$VideoInfoImpl.fromJson;

  @override
  String get id;
  @override
  String get url;
  @override
  String get title;
  @override
  String get channelName;
  @override
  int get index;
  @override
  DateTime get createdAt;
  @override
  DateTime get updatedAt;
  @override
  String? get categoryId;

  /// Create a copy of VideoInfo
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$VideoInfoImplCopyWith<_$VideoInfoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
