// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'web_view_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$WebViewState {
  String get url => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  bool get isLoading => throw _privateConstructorUsedError;
  bool get hasError => throw _privateConstructorUsedError;
  double get progress => throw _privateConstructorUsedError;

  /// Create a copy of WebViewState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $WebViewStateCopyWith<WebViewState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WebViewStateCopyWith<$Res> {
  factory $WebViewStateCopyWith(
          WebViewState value, $Res Function(WebViewState) then) =
      _$WebViewStateCopyWithImpl<$Res, WebViewState>;
  @useResult
  $Res call(
      {String url,
      String title,
      bool isLoading,
      bool hasError,
      double progress});
}

/// @nodoc
class _$WebViewStateCopyWithImpl<$Res, $Val extends WebViewState>
    implements $WebViewStateCopyWith<$Res> {
  _$WebViewStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of WebViewState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? url = null,
    Object? title = null,
    Object? isLoading = null,
    Object? hasError = null,
    Object? progress = null,
  }) {
    return _then(_value.copyWith(
      url: null == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      hasError: null == hasError
          ? _value.hasError
          : hasError // ignore: cast_nullable_to_non_nullable
              as bool,
      progress: null == progress
          ? _value.progress
          : progress // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$WebViewStateImplCopyWith<$Res>
    implements $WebViewStateCopyWith<$Res> {
  factory _$$WebViewStateImplCopyWith(
          _$WebViewStateImpl value, $Res Function(_$WebViewStateImpl) then) =
      __$$WebViewStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String url,
      String title,
      bool isLoading,
      bool hasError,
      double progress});
}

/// @nodoc
class __$$WebViewStateImplCopyWithImpl<$Res>
    extends _$WebViewStateCopyWithImpl<$Res, _$WebViewStateImpl>
    implements _$$WebViewStateImplCopyWith<$Res> {
  __$$WebViewStateImplCopyWithImpl(
      _$WebViewStateImpl _value, $Res Function(_$WebViewStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of WebViewState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? url = null,
    Object? title = null,
    Object? isLoading = null,
    Object? hasError = null,
    Object? progress = null,
  }) {
    return _then(_$WebViewStateImpl(
      url: null == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      hasError: null == hasError
          ? _value.hasError
          : hasError // ignore: cast_nullable_to_non_nullable
              as bool,
      progress: null == progress
          ? _value.progress
          : progress // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc

class _$WebViewStateImpl implements _WebViewState {
  const _$WebViewStateImpl(
      {this.url = '',
      this.title = '',
      this.isLoading = false,
      this.hasError = false,
      this.progress = 0.0});

  @override
  @JsonKey()
  final String url;
  @override
  @JsonKey()
  final String title;
  @override
  @JsonKey()
  final bool isLoading;
  @override
  @JsonKey()
  final bool hasError;
  @override
  @JsonKey()
  final double progress;

  @override
  String toString() {
    return 'WebViewState(url: $url, title: $title, isLoading: $isLoading, hasError: $hasError, progress: $progress)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WebViewStateImpl &&
            (identical(other.url, url) || other.url == url) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.hasError, hasError) ||
                other.hasError == hasError) &&
            (identical(other.progress, progress) ||
                other.progress == progress));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, url, title, isLoading, hasError, progress);

  /// Create a copy of WebViewState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$WebViewStateImplCopyWith<_$WebViewStateImpl> get copyWith =>
      __$$WebViewStateImplCopyWithImpl<_$WebViewStateImpl>(this, _$identity);
}

abstract class _WebViewState implements WebViewState {
  const factory _WebViewState(
      {final String url,
      final String title,
      final bool isLoading,
      final bool hasError,
      final double progress}) = _$WebViewStateImpl;

  @override
  String get url;
  @override
  String get title;
  @override
  bool get isLoading;
  @override
  bool get hasError;
  @override
  double get progress;

  /// Create a copy of WebViewState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$WebViewStateImplCopyWith<_$WebViewStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
