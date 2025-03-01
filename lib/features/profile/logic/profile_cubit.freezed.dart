// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'profile_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$ProfileState {
  String get name => throw _privateConstructorUsedError;
  String get email => throw _privateConstructorUsedError;
  String? get avatarUrl => throw _privateConstructorUsedError;
  String? get coverImageUrl => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            String name, String email, String? avatarUrl, String? coverImageUrl)
        initial,
    required TResult Function(
            String name, String email, String? avatarUrl, String? coverImageUrl)
        loading,
    required TResult Function(
            String name, String email, String? avatarUrl, String? coverImageUrl)
        success,
    required TResult Function(GeneralResponse error, String name, String email,
            String? avatarUrl, String? coverImageUrl)
        error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String name, String email, String? avatarUrl,
            String? coverImageUrl)?
        initial,
    TResult? Function(String name, String email, String? avatarUrl,
            String? coverImageUrl)?
        loading,
    TResult? Function(String name, String email, String? avatarUrl,
            String? coverImageUrl)?
        success,
    TResult? Function(GeneralResponse error, String name, String email,
            String? avatarUrl, String? coverImageUrl)?
        error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String name, String email, String? avatarUrl,
            String? coverImageUrl)?
        initial,
    TResult Function(String name, String email, String? avatarUrl,
            String? coverImageUrl)?
        loading,
    TResult Function(String name, String email, String? avatarUrl,
            String? coverImageUrl)?
        success,
    TResult Function(GeneralResponse error, String name, String email,
            String? avatarUrl, String? coverImageUrl)?
        error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Success value) success,
    required TResult Function(_Error value) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Success value)? success,
    TResult? Function(_Error value)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Success value)? success,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  /// Create a copy of ProfileState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ProfileStateCopyWith<ProfileState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProfileStateCopyWith<$Res> {
  factory $ProfileStateCopyWith(
          ProfileState value, $Res Function(ProfileState) then) =
      _$ProfileStateCopyWithImpl<$Res, ProfileState>;
  @useResult
  $Res call(
      {String name, String email, String? avatarUrl, String? coverImageUrl});
}

/// @nodoc
class _$ProfileStateCopyWithImpl<$Res, $Val extends ProfileState>
    implements $ProfileStateCopyWith<$Res> {
  _$ProfileStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ProfileState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? email = null,
    Object? avatarUrl = freezed,
    Object? coverImageUrl = freezed,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      avatarUrl: freezed == avatarUrl
          ? _value.avatarUrl
          : avatarUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      coverImageUrl: freezed == coverImageUrl
          ? _value.coverImageUrl
          : coverImageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$InitialImplCopyWith<$Res>
    implements $ProfileStateCopyWith<$Res> {
  factory _$$InitialImplCopyWith(
          _$InitialImpl value, $Res Function(_$InitialImpl) then) =
      __$$InitialImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String name, String email, String? avatarUrl, String? coverImageUrl});
}

/// @nodoc
class __$$InitialImplCopyWithImpl<$Res>
    extends _$ProfileStateCopyWithImpl<$Res, _$InitialImpl>
    implements _$$InitialImplCopyWith<$Res> {
  __$$InitialImplCopyWithImpl(
      _$InitialImpl _value, $Res Function(_$InitialImpl) _then)
      : super(_value, _then);

  /// Create a copy of ProfileState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? email = null,
    Object? avatarUrl = freezed,
    Object? coverImageUrl = freezed,
  }) {
    return _then(_$InitialImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      avatarUrl: freezed == avatarUrl
          ? _value.avatarUrl
          : avatarUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      coverImageUrl: freezed == coverImageUrl
          ? _value.coverImageUrl
          : coverImageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$InitialImpl implements _Initial {
  const _$InitialImpl(
      {required this.name,
      required this.email,
      required this.avatarUrl,
      required this.coverImageUrl});

  @override
  final String name;
  @override
  final String email;
  @override
  final String? avatarUrl;
  @override
  final String? coverImageUrl;

  @override
  String toString() {
    return 'ProfileState.initial(name: $name, email: $email, avatarUrl: $avatarUrl, coverImageUrl: $coverImageUrl)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InitialImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.avatarUrl, avatarUrl) ||
                other.avatarUrl == avatarUrl) &&
            (identical(other.coverImageUrl, coverImageUrl) ||
                other.coverImageUrl == coverImageUrl));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, name, email, avatarUrl, coverImageUrl);

  /// Create a copy of ProfileState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$InitialImplCopyWith<_$InitialImpl> get copyWith =>
      __$$InitialImplCopyWithImpl<_$InitialImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            String name, String email, String? avatarUrl, String? coverImageUrl)
        initial,
    required TResult Function(
            String name, String email, String? avatarUrl, String? coverImageUrl)
        loading,
    required TResult Function(
            String name, String email, String? avatarUrl, String? coverImageUrl)
        success,
    required TResult Function(GeneralResponse error, String name, String email,
            String? avatarUrl, String? coverImageUrl)
        error,
  }) {
    return initial(name, email, avatarUrl, coverImageUrl);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String name, String email, String? avatarUrl,
            String? coverImageUrl)?
        initial,
    TResult? Function(String name, String email, String? avatarUrl,
            String? coverImageUrl)?
        loading,
    TResult? Function(String name, String email, String? avatarUrl,
            String? coverImageUrl)?
        success,
    TResult? Function(GeneralResponse error, String name, String email,
            String? avatarUrl, String? coverImageUrl)?
        error,
  }) {
    return initial?.call(name, email, avatarUrl, coverImageUrl);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String name, String email, String? avatarUrl,
            String? coverImageUrl)?
        initial,
    TResult Function(String name, String email, String? avatarUrl,
            String? coverImageUrl)?
        loading,
    TResult Function(String name, String email, String? avatarUrl,
            String? coverImageUrl)?
        success,
    TResult Function(GeneralResponse error, String name, String email,
            String? avatarUrl, String? coverImageUrl)?
        error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(name, email, avatarUrl, coverImageUrl);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Success value) success,
    required TResult Function(_Error value) error,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Success value)? success,
    TResult? Function(_Error value)? error,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Success value)? success,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class _Initial implements ProfileState {
  const factory _Initial(
      {required final String name,
      required final String email,
      required final String? avatarUrl,
      required final String? coverImageUrl}) = _$InitialImpl;

  @override
  String get name;
  @override
  String get email;
  @override
  String? get avatarUrl;
  @override
  String? get coverImageUrl;

  /// Create a copy of ProfileState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$InitialImplCopyWith<_$InitialImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$LoadingImplCopyWith<$Res>
    implements $ProfileStateCopyWith<$Res> {
  factory _$$LoadingImplCopyWith(
          _$LoadingImpl value, $Res Function(_$LoadingImpl) then) =
      __$$LoadingImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String name, String email, String? avatarUrl, String? coverImageUrl});
}

/// @nodoc
class __$$LoadingImplCopyWithImpl<$Res>
    extends _$ProfileStateCopyWithImpl<$Res, _$LoadingImpl>
    implements _$$LoadingImplCopyWith<$Res> {
  __$$LoadingImplCopyWithImpl(
      _$LoadingImpl _value, $Res Function(_$LoadingImpl) _then)
      : super(_value, _then);

  /// Create a copy of ProfileState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? email = null,
    Object? avatarUrl = freezed,
    Object? coverImageUrl = freezed,
  }) {
    return _then(_$LoadingImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      avatarUrl: freezed == avatarUrl
          ? _value.avatarUrl
          : avatarUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      coverImageUrl: freezed == coverImageUrl
          ? _value.coverImageUrl
          : coverImageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$LoadingImpl implements _Loading {
  const _$LoadingImpl(
      {required this.name,
      required this.email,
      required this.avatarUrl,
      required this.coverImageUrl});

  @override
  final String name;
  @override
  final String email;
  @override
  final String? avatarUrl;
  @override
  final String? coverImageUrl;

  @override
  String toString() {
    return 'ProfileState.loading(name: $name, email: $email, avatarUrl: $avatarUrl, coverImageUrl: $coverImageUrl)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadingImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.avatarUrl, avatarUrl) ||
                other.avatarUrl == avatarUrl) &&
            (identical(other.coverImageUrl, coverImageUrl) ||
                other.coverImageUrl == coverImageUrl));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, name, email, avatarUrl, coverImageUrl);

  /// Create a copy of ProfileState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LoadingImplCopyWith<_$LoadingImpl> get copyWith =>
      __$$LoadingImplCopyWithImpl<_$LoadingImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            String name, String email, String? avatarUrl, String? coverImageUrl)
        initial,
    required TResult Function(
            String name, String email, String? avatarUrl, String? coverImageUrl)
        loading,
    required TResult Function(
            String name, String email, String? avatarUrl, String? coverImageUrl)
        success,
    required TResult Function(GeneralResponse error, String name, String email,
            String? avatarUrl, String? coverImageUrl)
        error,
  }) {
    return loading(name, email, avatarUrl, coverImageUrl);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String name, String email, String? avatarUrl,
            String? coverImageUrl)?
        initial,
    TResult? Function(String name, String email, String? avatarUrl,
            String? coverImageUrl)?
        loading,
    TResult? Function(String name, String email, String? avatarUrl,
            String? coverImageUrl)?
        success,
    TResult? Function(GeneralResponse error, String name, String email,
            String? avatarUrl, String? coverImageUrl)?
        error,
  }) {
    return loading?.call(name, email, avatarUrl, coverImageUrl);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String name, String email, String? avatarUrl,
            String? coverImageUrl)?
        initial,
    TResult Function(String name, String email, String? avatarUrl,
            String? coverImageUrl)?
        loading,
    TResult Function(String name, String email, String? avatarUrl,
            String? coverImageUrl)?
        success,
    TResult Function(GeneralResponse error, String name, String email,
            String? avatarUrl, String? coverImageUrl)?
        error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(name, email, avatarUrl, coverImageUrl);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Success value) success,
    required TResult Function(_Error value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Success value)? success,
    TResult? Function(_Error value)? error,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Success value)? success,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class _Loading implements ProfileState {
  const factory _Loading(
      {required final String name,
      required final String email,
      required final String? avatarUrl,
      required final String? coverImageUrl}) = _$LoadingImpl;

  @override
  String get name;
  @override
  String get email;
  @override
  String? get avatarUrl;
  @override
  String? get coverImageUrl;

  /// Create a copy of ProfileState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LoadingImplCopyWith<_$LoadingImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SuccessImplCopyWith<$Res>
    implements $ProfileStateCopyWith<$Res> {
  factory _$$SuccessImplCopyWith(
          _$SuccessImpl value, $Res Function(_$SuccessImpl) then) =
      __$$SuccessImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String name, String email, String? avatarUrl, String? coverImageUrl});
}

/// @nodoc
class __$$SuccessImplCopyWithImpl<$Res>
    extends _$ProfileStateCopyWithImpl<$Res, _$SuccessImpl>
    implements _$$SuccessImplCopyWith<$Res> {
  __$$SuccessImplCopyWithImpl(
      _$SuccessImpl _value, $Res Function(_$SuccessImpl) _then)
      : super(_value, _then);

  /// Create a copy of ProfileState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? email = null,
    Object? avatarUrl = freezed,
    Object? coverImageUrl = freezed,
  }) {
    return _then(_$SuccessImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      avatarUrl: freezed == avatarUrl
          ? _value.avatarUrl
          : avatarUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      coverImageUrl: freezed == coverImageUrl
          ? _value.coverImageUrl
          : coverImageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$SuccessImpl implements _Success {
  const _$SuccessImpl(
      {required this.name,
      required this.email,
      required this.avatarUrl,
      required this.coverImageUrl});

  @override
  final String name;
  @override
  final String email;
  @override
  final String? avatarUrl;
  @override
  final String? coverImageUrl;

  @override
  String toString() {
    return 'ProfileState.success(name: $name, email: $email, avatarUrl: $avatarUrl, coverImageUrl: $coverImageUrl)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SuccessImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.avatarUrl, avatarUrl) ||
                other.avatarUrl == avatarUrl) &&
            (identical(other.coverImageUrl, coverImageUrl) ||
                other.coverImageUrl == coverImageUrl));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, name, email, avatarUrl, coverImageUrl);

  /// Create a copy of ProfileState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SuccessImplCopyWith<_$SuccessImpl> get copyWith =>
      __$$SuccessImplCopyWithImpl<_$SuccessImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            String name, String email, String? avatarUrl, String? coverImageUrl)
        initial,
    required TResult Function(
            String name, String email, String? avatarUrl, String? coverImageUrl)
        loading,
    required TResult Function(
            String name, String email, String? avatarUrl, String? coverImageUrl)
        success,
    required TResult Function(GeneralResponse error, String name, String email,
            String? avatarUrl, String? coverImageUrl)
        error,
  }) {
    return success(name, email, avatarUrl, coverImageUrl);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String name, String email, String? avatarUrl,
            String? coverImageUrl)?
        initial,
    TResult? Function(String name, String email, String? avatarUrl,
            String? coverImageUrl)?
        loading,
    TResult? Function(String name, String email, String? avatarUrl,
            String? coverImageUrl)?
        success,
    TResult? Function(GeneralResponse error, String name, String email,
            String? avatarUrl, String? coverImageUrl)?
        error,
  }) {
    return success?.call(name, email, avatarUrl, coverImageUrl);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String name, String email, String? avatarUrl,
            String? coverImageUrl)?
        initial,
    TResult Function(String name, String email, String? avatarUrl,
            String? coverImageUrl)?
        loading,
    TResult Function(String name, String email, String? avatarUrl,
            String? coverImageUrl)?
        success,
    TResult Function(GeneralResponse error, String name, String email,
            String? avatarUrl, String? coverImageUrl)?
        error,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(name, email, avatarUrl, coverImageUrl);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Success value) success,
    required TResult Function(_Error value) error,
  }) {
    return success(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Success value)? success,
    TResult? Function(_Error value)? error,
  }) {
    return success?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Success value)? success,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(this);
    }
    return orElse();
  }
}

abstract class _Success implements ProfileState {
  const factory _Success(
      {required final String name,
      required final String email,
      required final String? avatarUrl,
      required final String? coverImageUrl}) = _$SuccessImpl;

  @override
  String get name;
  @override
  String get email;
  @override
  String? get avatarUrl;
  @override
  String? get coverImageUrl;

  /// Create a copy of ProfileState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SuccessImplCopyWith<_$SuccessImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ErrorImplCopyWith<$Res>
    implements $ProfileStateCopyWith<$Res> {
  factory _$$ErrorImplCopyWith(
          _$ErrorImpl value, $Res Function(_$ErrorImpl) then) =
      __$$ErrorImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {GeneralResponse error,
      String name,
      String email,
      String? avatarUrl,
      String? coverImageUrl});
}

/// @nodoc
class __$$ErrorImplCopyWithImpl<$Res>
    extends _$ProfileStateCopyWithImpl<$Res, _$ErrorImpl>
    implements _$$ErrorImplCopyWith<$Res> {
  __$$ErrorImplCopyWithImpl(
      _$ErrorImpl _value, $Res Function(_$ErrorImpl) _then)
      : super(_value, _then);

  /// Create a copy of ProfileState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? error = null,
    Object? name = null,
    Object? email = null,
    Object? avatarUrl = freezed,
    Object? coverImageUrl = freezed,
  }) {
    return _then(_$ErrorImpl(
      error: null == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as GeneralResponse,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      avatarUrl: freezed == avatarUrl
          ? _value.avatarUrl
          : avatarUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      coverImageUrl: freezed == coverImageUrl
          ? _value.coverImageUrl
          : coverImageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$ErrorImpl implements _Error {
  const _$ErrorImpl(
      {required this.error,
      required this.name,
      required this.email,
      required this.avatarUrl,
      required this.coverImageUrl});

  @override
  final GeneralResponse error;
  @override
  final String name;
  @override
  final String email;
  @override
  final String? avatarUrl;
  @override
  final String? coverImageUrl;

  @override
  String toString() {
    return 'ProfileState.error(error: $error, name: $name, email: $email, avatarUrl: $avatarUrl, coverImageUrl: $coverImageUrl)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ErrorImpl &&
            (identical(other.error, error) || other.error == error) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.avatarUrl, avatarUrl) ||
                other.avatarUrl == avatarUrl) &&
            (identical(other.coverImageUrl, coverImageUrl) ||
                other.coverImageUrl == coverImageUrl));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, error, name, email, avatarUrl, coverImageUrl);

  /// Create a copy of ProfileState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ErrorImplCopyWith<_$ErrorImpl> get copyWith =>
      __$$ErrorImplCopyWithImpl<_$ErrorImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            String name, String email, String? avatarUrl, String? coverImageUrl)
        initial,
    required TResult Function(
            String name, String email, String? avatarUrl, String? coverImageUrl)
        loading,
    required TResult Function(
            String name, String email, String? avatarUrl, String? coverImageUrl)
        success,
    required TResult Function(GeneralResponse error, String name, String email,
            String? avatarUrl, String? coverImageUrl)
        error,
  }) {
    return error(this.error, name, email, avatarUrl, coverImageUrl);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String name, String email, String? avatarUrl,
            String? coverImageUrl)?
        initial,
    TResult? Function(String name, String email, String? avatarUrl,
            String? coverImageUrl)?
        loading,
    TResult? Function(String name, String email, String? avatarUrl,
            String? coverImageUrl)?
        success,
    TResult? Function(GeneralResponse error, String name, String email,
            String? avatarUrl, String? coverImageUrl)?
        error,
  }) {
    return error?.call(this.error, name, email, avatarUrl, coverImageUrl);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String name, String email, String? avatarUrl,
            String? coverImageUrl)?
        initial,
    TResult Function(String name, String email, String? avatarUrl,
            String? coverImageUrl)?
        loading,
    TResult Function(String name, String email, String? avatarUrl,
            String? coverImageUrl)?
        success,
    TResult Function(GeneralResponse error, String name, String email,
            String? avatarUrl, String? coverImageUrl)?
        error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this.error, name, email, avatarUrl, coverImageUrl);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Success value) success,
    required TResult Function(_Error value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Success value)? success,
    TResult? Function(_Error value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Success value)? success,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class _Error implements ProfileState {
  const factory _Error(
      {required final GeneralResponse error,
      required final String name,
      required final String email,
      required final String? avatarUrl,
      required final String? coverImageUrl}) = _$ErrorImpl;

  GeneralResponse get error;
  @override
  String get name;
  @override
  String get email;
  @override
  String? get avatarUrl;
  @override
  String? get coverImageUrl;

  /// Create a copy of ProfileState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ErrorImplCopyWith<_$ErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
