// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'verify_code_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$VerifyCodeData {
  int get timerCount => throw _privateConstructorUsedError;
  bool get hasCodeInputError => throw _privateConstructorUsedError;
  String get errorText => throw _privateConstructorUsedError;

  /// Create a copy of VerifyCodeData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $VerifyCodeDataCopyWith<VerifyCodeData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $VerifyCodeDataCopyWith<$Res> {
  factory $VerifyCodeDataCopyWith(
          VerifyCodeData value, $Res Function(VerifyCodeData) then) =
      _$VerifyCodeDataCopyWithImpl<$Res, VerifyCodeData>;
  @useResult
  $Res call({int timerCount, bool hasCodeInputError, String errorText});
}

/// @nodoc
class _$VerifyCodeDataCopyWithImpl<$Res, $Val extends VerifyCodeData>
    implements $VerifyCodeDataCopyWith<$Res> {
  _$VerifyCodeDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of VerifyCodeData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? timerCount = null,
    Object? hasCodeInputError = null,
    Object? errorText = null,
  }) {
    return _then(_value.copyWith(
      timerCount: null == timerCount
          ? _value.timerCount
          : timerCount // ignore: cast_nullable_to_non_nullable
              as int,
      hasCodeInputError: null == hasCodeInputError
          ? _value.hasCodeInputError
          : hasCodeInputError // ignore: cast_nullable_to_non_nullable
              as bool,
      errorText: null == errorText
          ? _value.errorText
          : errorText // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$VerifyCodeDataImplCopyWith<$Res>
    implements $VerifyCodeDataCopyWith<$Res> {
  factory _$$VerifyCodeDataImplCopyWith(_$VerifyCodeDataImpl value,
          $Res Function(_$VerifyCodeDataImpl) then) =
      __$$VerifyCodeDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int timerCount, bool hasCodeInputError, String errorText});
}

/// @nodoc
class __$$VerifyCodeDataImplCopyWithImpl<$Res>
    extends _$VerifyCodeDataCopyWithImpl<$Res, _$VerifyCodeDataImpl>
    implements _$$VerifyCodeDataImplCopyWith<$Res> {
  __$$VerifyCodeDataImplCopyWithImpl(
      _$VerifyCodeDataImpl _value, $Res Function(_$VerifyCodeDataImpl) _then)
      : super(_value, _then);

  /// Create a copy of VerifyCodeData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? timerCount = null,
    Object? hasCodeInputError = null,
    Object? errorText = null,
  }) {
    return _then(_$VerifyCodeDataImpl(
      timerCount: null == timerCount
          ? _value.timerCount
          : timerCount // ignore: cast_nullable_to_non_nullable
              as int,
      hasCodeInputError: null == hasCodeInputError
          ? _value.hasCodeInputError
          : hasCodeInputError // ignore: cast_nullable_to_non_nullable
              as bool,
      errorText: null == errorText
          ? _value.errorText
          : errorText // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$VerifyCodeDataImpl implements _VerifyCodeData {
  const _$VerifyCodeDataImpl(
      {this.timerCount = 30,
      this.hasCodeInputError = false,
      this.errorText = 'Please enter a valid 5 digit code'});

  @override
  @JsonKey()
  final int timerCount;
  @override
  @JsonKey()
  final bool hasCodeInputError;
  @override
  @JsonKey()
  final String errorText;

  @override
  String toString() {
    return 'VerifyCodeData(timerCount: $timerCount, hasCodeInputError: $hasCodeInputError, errorText: $errorText)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$VerifyCodeDataImpl &&
            (identical(other.timerCount, timerCount) ||
                other.timerCount == timerCount) &&
            (identical(other.hasCodeInputError, hasCodeInputError) ||
                other.hasCodeInputError == hasCodeInputError) &&
            (identical(other.errorText, errorText) ||
                other.errorText == errorText));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, timerCount, hasCodeInputError, errorText);

  /// Create a copy of VerifyCodeData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$VerifyCodeDataImplCopyWith<_$VerifyCodeDataImpl> get copyWith =>
      __$$VerifyCodeDataImplCopyWithImpl<_$VerifyCodeDataImpl>(
          this, _$identity);
}

abstract class _VerifyCodeData implements VerifyCodeData {
  const factory _VerifyCodeData(
      {final int timerCount,
      final bool hasCodeInputError,
      final String errorText}) = _$VerifyCodeDataImpl;

  @override
  int get timerCount;
  @override
  bool get hasCodeInputError;
  @override
  String get errorText;

  /// Create a copy of VerifyCodeData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$VerifyCodeDataImplCopyWith<_$VerifyCodeDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$VerifyCodeState<T> {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(VerifyCodeData statesData) initial,
    required TResult Function(VerifyCodeData datstatesDataa) loading,
    required TResult Function(T data, VerifyCodeData statesData) success,
    required TResult Function(GeneralResponse error, VerifyCodeData statesData)
        error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(VerifyCodeData statesData)? initial,
    TResult? Function(VerifyCodeData datstatesDataa)? loading,
    TResult? Function(T data, VerifyCodeData statesData)? success,
    TResult? Function(GeneralResponse error, VerifyCodeData statesData)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(VerifyCodeData statesData)? initial,
    TResult Function(VerifyCodeData datstatesDataa)? loading,
    TResult Function(T data, VerifyCodeData statesData)? success,
    TResult Function(GeneralResponse error, VerifyCodeData statesData)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Initial<T> value) initial,
    required TResult Function(Loading<T> value) loading,
    required TResult Function(Success<T> value) success,
    required TResult Function(Error<T> value) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Initial<T> value)? initial,
    TResult? Function(Loading<T> value)? loading,
    TResult? Function(Success<T> value)? success,
    TResult? Function(Error<T> value)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Initial<T> value)? initial,
    TResult Function(Loading<T> value)? loading,
    TResult Function(Success<T> value)? success,
    TResult Function(Error<T> value)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $VerifyCodeStateCopyWith<T, $Res> {
  factory $VerifyCodeStateCopyWith(
          VerifyCodeState<T> value, $Res Function(VerifyCodeState<T>) then) =
      _$VerifyCodeStateCopyWithImpl<T, $Res, VerifyCodeState<T>>;
}

/// @nodoc
class _$VerifyCodeStateCopyWithImpl<T, $Res, $Val extends VerifyCodeState<T>>
    implements $VerifyCodeStateCopyWith<T, $Res> {
  _$VerifyCodeStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of VerifyCodeState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$InitialImplCopyWith<T, $Res> {
  factory _$$InitialImplCopyWith(
          _$InitialImpl<T> value, $Res Function(_$InitialImpl<T>) then) =
      __$$InitialImplCopyWithImpl<T, $Res>;
  @useResult
  $Res call({VerifyCodeData statesData});

  $VerifyCodeDataCopyWith<$Res> get statesData;
}

/// @nodoc
class __$$InitialImplCopyWithImpl<T, $Res>
    extends _$VerifyCodeStateCopyWithImpl<T, $Res, _$InitialImpl<T>>
    implements _$$InitialImplCopyWith<T, $Res> {
  __$$InitialImplCopyWithImpl(
      _$InitialImpl<T> _value, $Res Function(_$InitialImpl<T>) _then)
      : super(_value, _then);

  /// Create a copy of VerifyCodeState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? statesData = null,
  }) {
    return _then(_$InitialImpl<T>(
      statesData: null == statesData
          ? _value.statesData
          : statesData // ignore: cast_nullable_to_non_nullable
              as VerifyCodeData,
    ));
  }

  /// Create a copy of VerifyCodeState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $VerifyCodeDataCopyWith<$Res> get statesData {
    return $VerifyCodeDataCopyWith<$Res>(_value.statesData, (value) {
      return _then(_value.copyWith(statesData: value));
    });
  }
}

/// @nodoc

class _$InitialImpl<T> implements Initial<T> {
  const _$InitialImpl({this.statesData = const VerifyCodeData()});

  @override
  @JsonKey()
  final VerifyCodeData statesData;

  @override
  String toString() {
    return 'VerifyCodeState<$T>.initial(statesData: $statesData)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InitialImpl<T> &&
            (identical(other.statesData, statesData) ||
                other.statesData == statesData));
  }

  @override
  int get hashCode => Object.hash(runtimeType, statesData);

  /// Create a copy of VerifyCodeState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$InitialImplCopyWith<T, _$InitialImpl<T>> get copyWith =>
      __$$InitialImplCopyWithImpl<T, _$InitialImpl<T>>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(VerifyCodeData statesData) initial,
    required TResult Function(VerifyCodeData datstatesDataa) loading,
    required TResult Function(T data, VerifyCodeData statesData) success,
    required TResult Function(GeneralResponse error, VerifyCodeData statesData)
        error,
  }) {
    return initial(statesData);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(VerifyCodeData statesData)? initial,
    TResult? Function(VerifyCodeData datstatesDataa)? loading,
    TResult? Function(T data, VerifyCodeData statesData)? success,
    TResult? Function(GeneralResponse error, VerifyCodeData statesData)? error,
  }) {
    return initial?.call(statesData);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(VerifyCodeData statesData)? initial,
    TResult Function(VerifyCodeData datstatesDataa)? loading,
    TResult Function(T data, VerifyCodeData statesData)? success,
    TResult Function(GeneralResponse error, VerifyCodeData statesData)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(statesData);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Initial<T> value) initial,
    required TResult Function(Loading<T> value) loading,
    required TResult Function(Success<T> value) success,
    required TResult Function(Error<T> value) error,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Initial<T> value)? initial,
    TResult? Function(Loading<T> value)? loading,
    TResult? Function(Success<T> value)? success,
    TResult? Function(Error<T> value)? error,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Initial<T> value)? initial,
    TResult Function(Loading<T> value)? loading,
    TResult Function(Success<T> value)? success,
    TResult Function(Error<T> value)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class Initial<T> implements VerifyCodeState<T> {
  const factory Initial({final VerifyCodeData statesData}) = _$InitialImpl<T>;

  VerifyCodeData get statesData;

  /// Create a copy of VerifyCodeState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$InitialImplCopyWith<T, _$InitialImpl<T>> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$LoadingImplCopyWith<T, $Res> {
  factory _$$LoadingImplCopyWith(
          _$LoadingImpl<T> value, $Res Function(_$LoadingImpl<T>) then) =
      __$$LoadingImplCopyWithImpl<T, $Res>;
  @useResult
  $Res call({VerifyCodeData datstatesDataa});

  $VerifyCodeDataCopyWith<$Res> get datstatesDataa;
}

/// @nodoc
class __$$LoadingImplCopyWithImpl<T, $Res>
    extends _$VerifyCodeStateCopyWithImpl<T, $Res, _$LoadingImpl<T>>
    implements _$$LoadingImplCopyWith<T, $Res> {
  __$$LoadingImplCopyWithImpl(
      _$LoadingImpl<T> _value, $Res Function(_$LoadingImpl<T>) _then)
      : super(_value, _then);

  /// Create a copy of VerifyCodeState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? datstatesDataa = null,
  }) {
    return _then(_$LoadingImpl<T>(
      datstatesDataa: null == datstatesDataa
          ? _value.datstatesDataa
          : datstatesDataa // ignore: cast_nullable_to_non_nullable
              as VerifyCodeData,
    ));
  }

  /// Create a copy of VerifyCodeState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $VerifyCodeDataCopyWith<$Res> get datstatesDataa {
    return $VerifyCodeDataCopyWith<$Res>(_value.datstatesDataa, (value) {
      return _then(_value.copyWith(datstatesDataa: value));
    });
  }
}

/// @nodoc

class _$LoadingImpl<T> implements Loading<T> {
  const _$LoadingImpl({required this.datstatesDataa});

  @override
  final VerifyCodeData datstatesDataa;

  @override
  String toString() {
    return 'VerifyCodeState<$T>.loading(datstatesDataa: $datstatesDataa)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadingImpl<T> &&
            (identical(other.datstatesDataa, datstatesDataa) ||
                other.datstatesDataa == datstatesDataa));
  }

  @override
  int get hashCode => Object.hash(runtimeType, datstatesDataa);

  /// Create a copy of VerifyCodeState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LoadingImplCopyWith<T, _$LoadingImpl<T>> get copyWith =>
      __$$LoadingImplCopyWithImpl<T, _$LoadingImpl<T>>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(VerifyCodeData statesData) initial,
    required TResult Function(VerifyCodeData datstatesDataa) loading,
    required TResult Function(T data, VerifyCodeData statesData) success,
    required TResult Function(GeneralResponse error, VerifyCodeData statesData)
        error,
  }) {
    return loading(datstatesDataa);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(VerifyCodeData statesData)? initial,
    TResult? Function(VerifyCodeData datstatesDataa)? loading,
    TResult? Function(T data, VerifyCodeData statesData)? success,
    TResult? Function(GeneralResponse error, VerifyCodeData statesData)? error,
  }) {
    return loading?.call(datstatesDataa);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(VerifyCodeData statesData)? initial,
    TResult Function(VerifyCodeData datstatesDataa)? loading,
    TResult Function(T data, VerifyCodeData statesData)? success,
    TResult Function(GeneralResponse error, VerifyCodeData statesData)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(datstatesDataa);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Initial<T> value) initial,
    required TResult Function(Loading<T> value) loading,
    required TResult Function(Success<T> value) success,
    required TResult Function(Error<T> value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Initial<T> value)? initial,
    TResult? Function(Loading<T> value)? loading,
    TResult? Function(Success<T> value)? success,
    TResult? Function(Error<T> value)? error,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Initial<T> value)? initial,
    TResult Function(Loading<T> value)? loading,
    TResult Function(Success<T> value)? success,
    TResult Function(Error<T> value)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class Loading<T> implements VerifyCodeState<T> {
  const factory Loading({required final VerifyCodeData datstatesDataa}) =
      _$LoadingImpl<T>;

  VerifyCodeData get datstatesDataa;

  /// Create a copy of VerifyCodeState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LoadingImplCopyWith<T, _$LoadingImpl<T>> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SuccessImplCopyWith<T, $Res> {
  factory _$$SuccessImplCopyWith(
          _$SuccessImpl<T> value, $Res Function(_$SuccessImpl<T>) then) =
      __$$SuccessImplCopyWithImpl<T, $Res>;
  @useResult
  $Res call({T data, VerifyCodeData statesData});

  $VerifyCodeDataCopyWith<$Res> get statesData;
}

/// @nodoc
class __$$SuccessImplCopyWithImpl<T, $Res>
    extends _$VerifyCodeStateCopyWithImpl<T, $Res, _$SuccessImpl<T>>
    implements _$$SuccessImplCopyWith<T, $Res> {
  __$$SuccessImplCopyWithImpl(
      _$SuccessImpl<T> _value, $Res Function(_$SuccessImpl<T>) _then)
      : super(_value, _then);

  /// Create a copy of VerifyCodeState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = freezed,
    Object? statesData = null,
  }) {
    return _then(_$SuccessImpl<T>(
      freezed == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as T,
      statesData: null == statesData
          ? _value.statesData
          : statesData // ignore: cast_nullable_to_non_nullable
              as VerifyCodeData,
    ));
  }

  /// Create a copy of VerifyCodeState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $VerifyCodeDataCopyWith<$Res> get statesData {
    return $VerifyCodeDataCopyWith<$Res>(_value.statesData, (value) {
      return _then(_value.copyWith(statesData: value));
    });
  }
}

/// @nodoc

class _$SuccessImpl<T> implements Success<T> {
  const _$SuccessImpl(this.data, {required this.statesData});

  @override
  final T data;
  @override
  final VerifyCodeData statesData;

  @override
  String toString() {
    return 'VerifyCodeState<$T>.success(data: $data, statesData: $statesData)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SuccessImpl<T> &&
            const DeepCollectionEquality().equals(other.data, data) &&
            (identical(other.statesData, statesData) ||
                other.statesData == statesData));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(data), statesData);

  /// Create a copy of VerifyCodeState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SuccessImplCopyWith<T, _$SuccessImpl<T>> get copyWith =>
      __$$SuccessImplCopyWithImpl<T, _$SuccessImpl<T>>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(VerifyCodeData statesData) initial,
    required TResult Function(VerifyCodeData datstatesDataa) loading,
    required TResult Function(T data, VerifyCodeData statesData) success,
    required TResult Function(GeneralResponse error, VerifyCodeData statesData)
        error,
  }) {
    return success(data, statesData);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(VerifyCodeData statesData)? initial,
    TResult? Function(VerifyCodeData datstatesDataa)? loading,
    TResult? Function(T data, VerifyCodeData statesData)? success,
    TResult? Function(GeneralResponse error, VerifyCodeData statesData)? error,
  }) {
    return success?.call(data, statesData);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(VerifyCodeData statesData)? initial,
    TResult Function(VerifyCodeData datstatesDataa)? loading,
    TResult Function(T data, VerifyCodeData statesData)? success,
    TResult Function(GeneralResponse error, VerifyCodeData statesData)? error,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(data, statesData);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Initial<T> value) initial,
    required TResult Function(Loading<T> value) loading,
    required TResult Function(Success<T> value) success,
    required TResult Function(Error<T> value) error,
  }) {
    return success(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Initial<T> value)? initial,
    TResult? Function(Loading<T> value)? loading,
    TResult? Function(Success<T> value)? success,
    TResult? Function(Error<T> value)? error,
  }) {
    return success?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Initial<T> value)? initial,
    TResult Function(Loading<T> value)? loading,
    TResult Function(Success<T> value)? success,
    TResult Function(Error<T> value)? error,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(this);
    }
    return orElse();
  }
}

abstract class Success<T> implements VerifyCodeState<T> {
  const factory Success(final T data,
      {required final VerifyCodeData statesData}) = _$SuccessImpl<T>;

  T get data;
  VerifyCodeData get statesData;

  /// Create a copy of VerifyCodeState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SuccessImplCopyWith<T, _$SuccessImpl<T>> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ErrorImplCopyWith<T, $Res> {
  factory _$$ErrorImplCopyWith(
          _$ErrorImpl<T> value, $Res Function(_$ErrorImpl<T>) then) =
      __$$ErrorImplCopyWithImpl<T, $Res>;
  @useResult
  $Res call({GeneralResponse error, VerifyCodeData statesData});

  $VerifyCodeDataCopyWith<$Res> get statesData;
}

/// @nodoc
class __$$ErrorImplCopyWithImpl<T, $Res>
    extends _$VerifyCodeStateCopyWithImpl<T, $Res, _$ErrorImpl<T>>
    implements _$$ErrorImplCopyWith<T, $Res> {
  __$$ErrorImplCopyWithImpl(
      _$ErrorImpl<T> _value, $Res Function(_$ErrorImpl<T>) _then)
      : super(_value, _then);

  /// Create a copy of VerifyCodeState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? error = null,
    Object? statesData = null,
  }) {
    return _then(_$ErrorImpl<T>(
      error: null == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as GeneralResponse,
      statesData: null == statesData
          ? _value.statesData
          : statesData // ignore: cast_nullable_to_non_nullable
              as VerifyCodeData,
    ));
  }

  /// Create a copy of VerifyCodeState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $VerifyCodeDataCopyWith<$Res> get statesData {
    return $VerifyCodeDataCopyWith<$Res>(_value.statesData, (value) {
      return _then(_value.copyWith(statesData: value));
    });
  }
}

/// @nodoc

class _$ErrorImpl<T> implements Error<T> {
  const _$ErrorImpl({required this.error, required this.statesData});

  @override
  final GeneralResponse error;
  @override
  final VerifyCodeData statesData;

  @override
  String toString() {
    return 'VerifyCodeState<$T>.error(error: $error, statesData: $statesData)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ErrorImpl<T> &&
            (identical(other.error, error) || other.error == error) &&
            (identical(other.statesData, statesData) ||
                other.statesData == statesData));
  }

  @override
  int get hashCode => Object.hash(runtimeType, error, statesData);

  /// Create a copy of VerifyCodeState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ErrorImplCopyWith<T, _$ErrorImpl<T>> get copyWith =>
      __$$ErrorImplCopyWithImpl<T, _$ErrorImpl<T>>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(VerifyCodeData statesData) initial,
    required TResult Function(VerifyCodeData datstatesDataa) loading,
    required TResult Function(T data, VerifyCodeData statesData) success,
    required TResult Function(GeneralResponse error, VerifyCodeData statesData)
        error,
  }) {
    return error(this.error, statesData);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(VerifyCodeData statesData)? initial,
    TResult? Function(VerifyCodeData datstatesDataa)? loading,
    TResult? Function(T data, VerifyCodeData statesData)? success,
    TResult? Function(GeneralResponse error, VerifyCodeData statesData)? error,
  }) {
    return error?.call(this.error, statesData);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(VerifyCodeData statesData)? initial,
    TResult Function(VerifyCodeData datstatesDataa)? loading,
    TResult Function(T data, VerifyCodeData statesData)? success,
    TResult Function(GeneralResponse error, VerifyCodeData statesData)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this.error, statesData);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Initial<T> value) initial,
    required TResult Function(Loading<T> value) loading,
    required TResult Function(Success<T> value) success,
    required TResult Function(Error<T> value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Initial<T> value)? initial,
    TResult? Function(Loading<T> value)? loading,
    TResult? Function(Success<T> value)? success,
    TResult? Function(Error<T> value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Initial<T> value)? initial,
    TResult Function(Loading<T> value)? loading,
    TResult Function(Success<T> value)? success,
    TResult Function(Error<T> value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class Error<T> implements VerifyCodeState<T> {
  const factory Error(
      {required final GeneralResponse error,
      required final VerifyCodeData statesData}) = _$ErrorImpl<T>;

  GeneralResponse get error;
  VerifyCodeData get statesData;

  /// Create a copy of VerifyCodeState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ErrorImplCopyWith<T, _$ErrorImpl<T>> get copyWith =>
      throw _privateConstructorUsedError;
}
