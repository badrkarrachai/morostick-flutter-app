// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'top_menu_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$TopMenuState {
  bool get isGoogleAuthEnabled => throw _privateConstructorUsedError;
  bool get isFacebookAuthEnabled => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            bool isGoogleAuthEnabled, bool isFacebookAuthEnabled)
        initial,
    required TResult Function(
            bool isGoogleAuthEnabled, bool isFacebookAuthEnabled)
        loading,
    required TResult Function(
            bool isGoogleAuthEnabled, bool isFacebookAuthEnabled)
        success,
    required TResult Function(GeneralResponse error, bool isGoogleAuthEnabled,
            bool isFacebookAuthEnabled)
        error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(bool isGoogleAuthEnabled, bool isFacebookAuthEnabled)?
        initial,
    TResult? Function(bool isGoogleAuthEnabled, bool isFacebookAuthEnabled)?
        loading,
    TResult? Function(bool isGoogleAuthEnabled, bool isFacebookAuthEnabled)?
        success,
    TResult? Function(GeneralResponse error, bool isGoogleAuthEnabled,
            bool isFacebookAuthEnabled)?
        error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(bool isGoogleAuthEnabled, bool isFacebookAuthEnabled)?
        initial,
    TResult Function(bool isGoogleAuthEnabled, bool isFacebookAuthEnabled)?
        loading,
    TResult Function(bool isGoogleAuthEnabled, bool isFacebookAuthEnabled)?
        success,
    TResult Function(GeneralResponse error, bool isGoogleAuthEnabled,
            bool isFacebookAuthEnabled)?
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

  /// Create a copy of TopMenuState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TopMenuStateCopyWith<TopMenuState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TopMenuStateCopyWith<$Res> {
  factory $TopMenuStateCopyWith(
          TopMenuState value, $Res Function(TopMenuState) then) =
      _$TopMenuStateCopyWithImpl<$Res, TopMenuState>;
  @useResult
  $Res call({bool isGoogleAuthEnabled, bool isFacebookAuthEnabled});
}

/// @nodoc
class _$TopMenuStateCopyWithImpl<$Res, $Val extends TopMenuState>
    implements $TopMenuStateCopyWith<$Res> {
  _$TopMenuStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TopMenuState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isGoogleAuthEnabled = null,
    Object? isFacebookAuthEnabled = null,
  }) {
    return _then(_value.copyWith(
      isGoogleAuthEnabled: null == isGoogleAuthEnabled
          ? _value.isGoogleAuthEnabled
          : isGoogleAuthEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      isFacebookAuthEnabled: null == isFacebookAuthEnabled
          ? _value.isFacebookAuthEnabled
          : isFacebookAuthEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$InitialImplCopyWith<$Res>
    implements $TopMenuStateCopyWith<$Res> {
  factory _$$InitialImplCopyWith(
          _$InitialImpl value, $Res Function(_$InitialImpl) then) =
      __$$InitialImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool isGoogleAuthEnabled, bool isFacebookAuthEnabled});
}

/// @nodoc
class __$$InitialImplCopyWithImpl<$Res>
    extends _$TopMenuStateCopyWithImpl<$Res, _$InitialImpl>
    implements _$$InitialImplCopyWith<$Res> {
  __$$InitialImplCopyWithImpl(
      _$InitialImpl _value, $Res Function(_$InitialImpl) _then)
      : super(_value, _then);

  /// Create a copy of TopMenuState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isGoogleAuthEnabled = null,
    Object? isFacebookAuthEnabled = null,
  }) {
    return _then(_$InitialImpl(
      isGoogleAuthEnabled: null == isGoogleAuthEnabled
          ? _value.isGoogleAuthEnabled
          : isGoogleAuthEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      isFacebookAuthEnabled: null == isFacebookAuthEnabled
          ? _value.isFacebookAuthEnabled
          : isFacebookAuthEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$InitialImpl implements _Initial {
  const _$InitialImpl(
      {required this.isGoogleAuthEnabled, required this.isFacebookAuthEnabled});

  @override
  final bool isGoogleAuthEnabled;
  @override
  final bool isFacebookAuthEnabled;

  @override
  String toString() {
    return 'TopMenuState.initial(isGoogleAuthEnabled: $isGoogleAuthEnabled, isFacebookAuthEnabled: $isFacebookAuthEnabled)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InitialImpl &&
            (identical(other.isGoogleAuthEnabled, isGoogleAuthEnabled) ||
                other.isGoogleAuthEnabled == isGoogleAuthEnabled) &&
            (identical(other.isFacebookAuthEnabled, isFacebookAuthEnabled) ||
                other.isFacebookAuthEnabled == isFacebookAuthEnabled));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, isGoogleAuthEnabled, isFacebookAuthEnabled);

  /// Create a copy of TopMenuState
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
            bool isGoogleAuthEnabled, bool isFacebookAuthEnabled)
        initial,
    required TResult Function(
            bool isGoogleAuthEnabled, bool isFacebookAuthEnabled)
        loading,
    required TResult Function(
            bool isGoogleAuthEnabled, bool isFacebookAuthEnabled)
        success,
    required TResult Function(GeneralResponse error, bool isGoogleAuthEnabled,
            bool isFacebookAuthEnabled)
        error,
  }) {
    return initial(isGoogleAuthEnabled, isFacebookAuthEnabled);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(bool isGoogleAuthEnabled, bool isFacebookAuthEnabled)?
        initial,
    TResult? Function(bool isGoogleAuthEnabled, bool isFacebookAuthEnabled)?
        loading,
    TResult? Function(bool isGoogleAuthEnabled, bool isFacebookAuthEnabled)?
        success,
    TResult? Function(GeneralResponse error, bool isGoogleAuthEnabled,
            bool isFacebookAuthEnabled)?
        error,
  }) {
    return initial?.call(isGoogleAuthEnabled, isFacebookAuthEnabled);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(bool isGoogleAuthEnabled, bool isFacebookAuthEnabled)?
        initial,
    TResult Function(bool isGoogleAuthEnabled, bool isFacebookAuthEnabled)?
        loading,
    TResult Function(bool isGoogleAuthEnabled, bool isFacebookAuthEnabled)?
        success,
    TResult Function(GeneralResponse error, bool isGoogleAuthEnabled,
            bool isFacebookAuthEnabled)?
        error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(isGoogleAuthEnabled, isFacebookAuthEnabled);
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

abstract class _Initial implements TopMenuState {
  const factory _Initial(
      {required final bool isGoogleAuthEnabled,
      required final bool isFacebookAuthEnabled}) = _$InitialImpl;

  @override
  bool get isGoogleAuthEnabled;
  @override
  bool get isFacebookAuthEnabled;

  /// Create a copy of TopMenuState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$InitialImplCopyWith<_$InitialImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$LoadingImplCopyWith<$Res>
    implements $TopMenuStateCopyWith<$Res> {
  factory _$$LoadingImplCopyWith(
          _$LoadingImpl value, $Res Function(_$LoadingImpl) then) =
      __$$LoadingImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool isGoogleAuthEnabled, bool isFacebookAuthEnabled});
}

/// @nodoc
class __$$LoadingImplCopyWithImpl<$Res>
    extends _$TopMenuStateCopyWithImpl<$Res, _$LoadingImpl>
    implements _$$LoadingImplCopyWith<$Res> {
  __$$LoadingImplCopyWithImpl(
      _$LoadingImpl _value, $Res Function(_$LoadingImpl) _then)
      : super(_value, _then);

  /// Create a copy of TopMenuState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isGoogleAuthEnabled = null,
    Object? isFacebookAuthEnabled = null,
  }) {
    return _then(_$LoadingImpl(
      isGoogleAuthEnabled: null == isGoogleAuthEnabled
          ? _value.isGoogleAuthEnabled
          : isGoogleAuthEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      isFacebookAuthEnabled: null == isFacebookAuthEnabled
          ? _value.isFacebookAuthEnabled
          : isFacebookAuthEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$LoadingImpl implements _Loading {
  const _$LoadingImpl(
      {required this.isGoogleAuthEnabled, required this.isFacebookAuthEnabled});

  @override
  final bool isGoogleAuthEnabled;
  @override
  final bool isFacebookAuthEnabled;

  @override
  String toString() {
    return 'TopMenuState.loading(isGoogleAuthEnabled: $isGoogleAuthEnabled, isFacebookAuthEnabled: $isFacebookAuthEnabled)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadingImpl &&
            (identical(other.isGoogleAuthEnabled, isGoogleAuthEnabled) ||
                other.isGoogleAuthEnabled == isGoogleAuthEnabled) &&
            (identical(other.isFacebookAuthEnabled, isFacebookAuthEnabled) ||
                other.isFacebookAuthEnabled == isFacebookAuthEnabled));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, isGoogleAuthEnabled, isFacebookAuthEnabled);

  /// Create a copy of TopMenuState
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
            bool isGoogleAuthEnabled, bool isFacebookAuthEnabled)
        initial,
    required TResult Function(
            bool isGoogleAuthEnabled, bool isFacebookAuthEnabled)
        loading,
    required TResult Function(
            bool isGoogleAuthEnabled, bool isFacebookAuthEnabled)
        success,
    required TResult Function(GeneralResponse error, bool isGoogleAuthEnabled,
            bool isFacebookAuthEnabled)
        error,
  }) {
    return loading(isGoogleAuthEnabled, isFacebookAuthEnabled);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(bool isGoogleAuthEnabled, bool isFacebookAuthEnabled)?
        initial,
    TResult? Function(bool isGoogleAuthEnabled, bool isFacebookAuthEnabled)?
        loading,
    TResult? Function(bool isGoogleAuthEnabled, bool isFacebookAuthEnabled)?
        success,
    TResult? Function(GeneralResponse error, bool isGoogleAuthEnabled,
            bool isFacebookAuthEnabled)?
        error,
  }) {
    return loading?.call(isGoogleAuthEnabled, isFacebookAuthEnabled);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(bool isGoogleAuthEnabled, bool isFacebookAuthEnabled)?
        initial,
    TResult Function(bool isGoogleAuthEnabled, bool isFacebookAuthEnabled)?
        loading,
    TResult Function(bool isGoogleAuthEnabled, bool isFacebookAuthEnabled)?
        success,
    TResult Function(GeneralResponse error, bool isGoogleAuthEnabled,
            bool isFacebookAuthEnabled)?
        error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(isGoogleAuthEnabled, isFacebookAuthEnabled);
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

abstract class _Loading implements TopMenuState {
  const factory _Loading(
      {required final bool isGoogleAuthEnabled,
      required final bool isFacebookAuthEnabled}) = _$LoadingImpl;

  @override
  bool get isGoogleAuthEnabled;
  @override
  bool get isFacebookAuthEnabled;

  /// Create a copy of TopMenuState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LoadingImplCopyWith<_$LoadingImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SuccessImplCopyWith<$Res>
    implements $TopMenuStateCopyWith<$Res> {
  factory _$$SuccessImplCopyWith(
          _$SuccessImpl value, $Res Function(_$SuccessImpl) then) =
      __$$SuccessImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool isGoogleAuthEnabled, bool isFacebookAuthEnabled});
}

/// @nodoc
class __$$SuccessImplCopyWithImpl<$Res>
    extends _$TopMenuStateCopyWithImpl<$Res, _$SuccessImpl>
    implements _$$SuccessImplCopyWith<$Res> {
  __$$SuccessImplCopyWithImpl(
      _$SuccessImpl _value, $Res Function(_$SuccessImpl) _then)
      : super(_value, _then);

  /// Create a copy of TopMenuState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isGoogleAuthEnabled = null,
    Object? isFacebookAuthEnabled = null,
  }) {
    return _then(_$SuccessImpl(
      isGoogleAuthEnabled: null == isGoogleAuthEnabled
          ? _value.isGoogleAuthEnabled
          : isGoogleAuthEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      isFacebookAuthEnabled: null == isFacebookAuthEnabled
          ? _value.isFacebookAuthEnabled
          : isFacebookAuthEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$SuccessImpl implements _Success {
  const _$SuccessImpl(
      {required this.isGoogleAuthEnabled, required this.isFacebookAuthEnabled});

  @override
  final bool isGoogleAuthEnabled;
  @override
  final bool isFacebookAuthEnabled;

  @override
  String toString() {
    return 'TopMenuState.success(isGoogleAuthEnabled: $isGoogleAuthEnabled, isFacebookAuthEnabled: $isFacebookAuthEnabled)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SuccessImpl &&
            (identical(other.isGoogleAuthEnabled, isGoogleAuthEnabled) ||
                other.isGoogleAuthEnabled == isGoogleAuthEnabled) &&
            (identical(other.isFacebookAuthEnabled, isFacebookAuthEnabled) ||
                other.isFacebookAuthEnabled == isFacebookAuthEnabled));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, isGoogleAuthEnabled, isFacebookAuthEnabled);

  /// Create a copy of TopMenuState
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
            bool isGoogleAuthEnabled, bool isFacebookAuthEnabled)
        initial,
    required TResult Function(
            bool isGoogleAuthEnabled, bool isFacebookAuthEnabled)
        loading,
    required TResult Function(
            bool isGoogleAuthEnabled, bool isFacebookAuthEnabled)
        success,
    required TResult Function(GeneralResponse error, bool isGoogleAuthEnabled,
            bool isFacebookAuthEnabled)
        error,
  }) {
    return success(isGoogleAuthEnabled, isFacebookAuthEnabled);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(bool isGoogleAuthEnabled, bool isFacebookAuthEnabled)?
        initial,
    TResult? Function(bool isGoogleAuthEnabled, bool isFacebookAuthEnabled)?
        loading,
    TResult? Function(bool isGoogleAuthEnabled, bool isFacebookAuthEnabled)?
        success,
    TResult? Function(GeneralResponse error, bool isGoogleAuthEnabled,
            bool isFacebookAuthEnabled)?
        error,
  }) {
    return success?.call(isGoogleAuthEnabled, isFacebookAuthEnabled);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(bool isGoogleAuthEnabled, bool isFacebookAuthEnabled)?
        initial,
    TResult Function(bool isGoogleAuthEnabled, bool isFacebookAuthEnabled)?
        loading,
    TResult Function(bool isGoogleAuthEnabled, bool isFacebookAuthEnabled)?
        success,
    TResult Function(GeneralResponse error, bool isGoogleAuthEnabled,
            bool isFacebookAuthEnabled)?
        error,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(isGoogleAuthEnabled, isFacebookAuthEnabled);
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

abstract class _Success implements TopMenuState {
  const factory _Success(
      {required final bool isGoogleAuthEnabled,
      required final bool isFacebookAuthEnabled}) = _$SuccessImpl;

  @override
  bool get isGoogleAuthEnabled;
  @override
  bool get isFacebookAuthEnabled;

  /// Create a copy of TopMenuState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SuccessImplCopyWith<_$SuccessImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ErrorImplCopyWith<$Res>
    implements $TopMenuStateCopyWith<$Res> {
  factory _$$ErrorImplCopyWith(
          _$ErrorImpl value, $Res Function(_$ErrorImpl) then) =
      __$$ErrorImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {GeneralResponse error,
      bool isGoogleAuthEnabled,
      bool isFacebookAuthEnabled});
}

/// @nodoc
class __$$ErrorImplCopyWithImpl<$Res>
    extends _$TopMenuStateCopyWithImpl<$Res, _$ErrorImpl>
    implements _$$ErrorImplCopyWith<$Res> {
  __$$ErrorImplCopyWithImpl(
      _$ErrorImpl _value, $Res Function(_$ErrorImpl) _then)
      : super(_value, _then);

  /// Create a copy of TopMenuState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? error = null,
    Object? isGoogleAuthEnabled = null,
    Object? isFacebookAuthEnabled = null,
  }) {
    return _then(_$ErrorImpl(
      error: null == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as GeneralResponse,
      isGoogleAuthEnabled: null == isGoogleAuthEnabled
          ? _value.isGoogleAuthEnabled
          : isGoogleAuthEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      isFacebookAuthEnabled: null == isFacebookAuthEnabled
          ? _value.isFacebookAuthEnabled
          : isFacebookAuthEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$ErrorImpl implements _Error {
  const _$ErrorImpl(
      {required this.error,
      required this.isGoogleAuthEnabled,
      required this.isFacebookAuthEnabled});

  @override
  final GeneralResponse error;
  @override
  final bool isGoogleAuthEnabled;
  @override
  final bool isFacebookAuthEnabled;

  @override
  String toString() {
    return 'TopMenuState.error(error: $error, isGoogleAuthEnabled: $isGoogleAuthEnabled, isFacebookAuthEnabled: $isFacebookAuthEnabled)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ErrorImpl &&
            (identical(other.error, error) || other.error == error) &&
            (identical(other.isGoogleAuthEnabled, isGoogleAuthEnabled) ||
                other.isGoogleAuthEnabled == isGoogleAuthEnabled) &&
            (identical(other.isFacebookAuthEnabled, isFacebookAuthEnabled) ||
                other.isFacebookAuthEnabled == isFacebookAuthEnabled));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, error, isGoogleAuthEnabled, isFacebookAuthEnabled);

  /// Create a copy of TopMenuState
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
            bool isGoogleAuthEnabled, bool isFacebookAuthEnabled)
        initial,
    required TResult Function(
            bool isGoogleAuthEnabled, bool isFacebookAuthEnabled)
        loading,
    required TResult Function(
            bool isGoogleAuthEnabled, bool isFacebookAuthEnabled)
        success,
    required TResult Function(GeneralResponse error, bool isGoogleAuthEnabled,
            bool isFacebookAuthEnabled)
        error,
  }) {
    return error(this.error, isGoogleAuthEnabled, isFacebookAuthEnabled);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(bool isGoogleAuthEnabled, bool isFacebookAuthEnabled)?
        initial,
    TResult? Function(bool isGoogleAuthEnabled, bool isFacebookAuthEnabled)?
        loading,
    TResult? Function(bool isGoogleAuthEnabled, bool isFacebookAuthEnabled)?
        success,
    TResult? Function(GeneralResponse error, bool isGoogleAuthEnabled,
            bool isFacebookAuthEnabled)?
        error,
  }) {
    return error?.call(this.error, isGoogleAuthEnabled, isFacebookAuthEnabled);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(bool isGoogleAuthEnabled, bool isFacebookAuthEnabled)?
        initial,
    TResult Function(bool isGoogleAuthEnabled, bool isFacebookAuthEnabled)?
        loading,
    TResult Function(bool isGoogleAuthEnabled, bool isFacebookAuthEnabled)?
        success,
    TResult Function(GeneralResponse error, bool isGoogleAuthEnabled,
            bool isFacebookAuthEnabled)?
        error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this.error, isGoogleAuthEnabled, isFacebookAuthEnabled);
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

abstract class _Error implements TopMenuState {
  const factory _Error(
      {required final GeneralResponse error,
      required final bool isGoogleAuthEnabled,
      required final bool isFacebookAuthEnabled}) = _$ErrorImpl;

  GeneralResponse get error;
  @override
  bool get isGoogleAuthEnabled;
  @override
  bool get isFacebookAuthEnabled;

  /// Create a copy of TopMenuState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ErrorImplCopyWith<_$ErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
