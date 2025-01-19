// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'search_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$SearchState {
// Trending Searches
  bool get isLoadingTrendingSearches => throw _privateConstructorUsedError;
  List<TrendingSearchItem> get trendingSearches =>
      throw _privateConstructorUsedError;
  bool get hasErrorTrendingSearches => throw _privateConstructorUsedError;
  GeneralResponse? get error =>
      throw _privateConstructorUsedError; // Recent Searches
  List<String> get recentSearches => throw _privateConstructorUsedError;

  /// Create a copy of SearchState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SearchStateCopyWith<SearchState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SearchStateCopyWith<$Res> {
  factory $SearchStateCopyWith(
          SearchState value, $Res Function(SearchState) then) =
      _$SearchStateCopyWithImpl<$Res, SearchState>;
  @useResult
  $Res call(
      {bool isLoadingTrendingSearches,
      List<TrendingSearchItem> trendingSearches,
      bool hasErrorTrendingSearches,
      GeneralResponse? error,
      List<String> recentSearches});
}

/// @nodoc
class _$SearchStateCopyWithImpl<$Res, $Val extends SearchState>
    implements $SearchStateCopyWith<$Res> {
  _$SearchStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SearchState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoadingTrendingSearches = null,
    Object? trendingSearches = null,
    Object? hasErrorTrendingSearches = null,
    Object? error = freezed,
    Object? recentSearches = null,
  }) {
    return _then(_value.copyWith(
      isLoadingTrendingSearches: null == isLoadingTrendingSearches
          ? _value.isLoadingTrendingSearches
          : isLoadingTrendingSearches // ignore: cast_nullable_to_non_nullable
              as bool,
      trendingSearches: null == trendingSearches
          ? _value.trendingSearches
          : trendingSearches // ignore: cast_nullable_to_non_nullable
              as List<TrendingSearchItem>,
      hasErrorTrendingSearches: null == hasErrorTrendingSearches
          ? _value.hasErrorTrendingSearches
          : hasErrorTrendingSearches // ignore: cast_nullable_to_non_nullable
              as bool,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as GeneralResponse?,
      recentSearches: null == recentSearches
          ? _value.recentSearches
          : recentSearches // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SearchStateImplCopyWith<$Res>
    implements $SearchStateCopyWith<$Res> {
  factory _$$SearchStateImplCopyWith(
          _$SearchStateImpl value, $Res Function(_$SearchStateImpl) then) =
      __$$SearchStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool isLoadingTrendingSearches,
      List<TrendingSearchItem> trendingSearches,
      bool hasErrorTrendingSearches,
      GeneralResponse? error,
      List<String> recentSearches});
}

/// @nodoc
class __$$SearchStateImplCopyWithImpl<$Res>
    extends _$SearchStateCopyWithImpl<$Res, _$SearchStateImpl>
    implements _$$SearchStateImplCopyWith<$Res> {
  __$$SearchStateImplCopyWithImpl(
      _$SearchStateImpl _value, $Res Function(_$SearchStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of SearchState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoadingTrendingSearches = null,
    Object? trendingSearches = null,
    Object? hasErrorTrendingSearches = null,
    Object? error = freezed,
    Object? recentSearches = null,
  }) {
    return _then(_$SearchStateImpl(
      isLoadingTrendingSearches: null == isLoadingTrendingSearches
          ? _value.isLoadingTrendingSearches
          : isLoadingTrendingSearches // ignore: cast_nullable_to_non_nullable
              as bool,
      trendingSearches: null == trendingSearches
          ? _value._trendingSearches
          : trendingSearches // ignore: cast_nullable_to_non_nullable
              as List<TrendingSearchItem>,
      hasErrorTrendingSearches: null == hasErrorTrendingSearches
          ? _value.hasErrorTrendingSearches
          : hasErrorTrendingSearches // ignore: cast_nullable_to_non_nullable
              as bool,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as GeneralResponse?,
      recentSearches: null == recentSearches
          ? _value._recentSearches
          : recentSearches // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc

class _$SearchStateImpl implements _SearchState {
  const _$SearchStateImpl(
      {this.isLoadingTrendingSearches = false,
      final List<TrendingSearchItem> trendingSearches = const [],
      this.hasErrorTrendingSearches = false,
      this.error,
      final List<String> recentSearches = const []})
      : _trendingSearches = trendingSearches,
        _recentSearches = recentSearches;

// Trending Searches
  @override
  @JsonKey()
  final bool isLoadingTrendingSearches;
  final List<TrendingSearchItem> _trendingSearches;
  @override
  @JsonKey()
  List<TrendingSearchItem> get trendingSearches {
    if (_trendingSearches is EqualUnmodifiableListView)
      return _trendingSearches;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_trendingSearches);
  }

  @override
  @JsonKey()
  final bool hasErrorTrendingSearches;
  @override
  final GeneralResponse? error;
// Recent Searches
  final List<String> _recentSearches;
// Recent Searches
  @override
  @JsonKey()
  List<String> get recentSearches {
    if (_recentSearches is EqualUnmodifiableListView) return _recentSearches;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_recentSearches);
  }

  @override
  String toString() {
    return 'SearchState(isLoadingTrendingSearches: $isLoadingTrendingSearches, trendingSearches: $trendingSearches, hasErrorTrendingSearches: $hasErrorTrendingSearches, error: $error, recentSearches: $recentSearches)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SearchStateImpl &&
            (identical(other.isLoadingTrendingSearches,
                    isLoadingTrendingSearches) ||
                other.isLoadingTrendingSearches == isLoadingTrendingSearches) &&
            const DeepCollectionEquality()
                .equals(other._trendingSearches, _trendingSearches) &&
            (identical(
                    other.hasErrorTrendingSearches, hasErrorTrendingSearches) ||
                other.hasErrorTrendingSearches == hasErrorTrendingSearches) &&
            (identical(other.error, error) || other.error == error) &&
            const DeepCollectionEquality()
                .equals(other._recentSearches, _recentSearches));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      isLoadingTrendingSearches,
      const DeepCollectionEquality().hash(_trendingSearches),
      hasErrorTrendingSearches,
      error,
      const DeepCollectionEquality().hash(_recentSearches));

  /// Create a copy of SearchState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SearchStateImplCopyWith<_$SearchStateImpl> get copyWith =>
      __$$SearchStateImplCopyWithImpl<_$SearchStateImpl>(this, _$identity);
}

abstract class _SearchState implements SearchState {
  const factory _SearchState(
      {final bool isLoadingTrendingSearches,
      final List<TrendingSearchItem> trendingSearches,
      final bool hasErrorTrendingSearches,
      final GeneralResponse? error,
      final List<String> recentSearches}) = _$SearchStateImpl;

// Trending Searches
  @override
  bool get isLoadingTrendingSearches;
  @override
  List<TrendingSearchItem> get trendingSearches;
  @override
  bool get hasErrorTrendingSearches;
  @override
  GeneralResponse? get error; // Recent Searches
  @override
  List<String> get recentSearches;

  /// Create a copy of SearchState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SearchStateImplCopyWith<_$SearchStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
