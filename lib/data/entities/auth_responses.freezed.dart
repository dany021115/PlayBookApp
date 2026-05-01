// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'auth_responses.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

TokenResponse _$TokenResponseFromJson(Map<String, dynamic> json) {
  return _TokenResponse.fromJson(json);
}

/// @nodoc
mixin _$TokenResponse {
  String get access => throw _privateConstructorUsedError;
  String get refresh => throw _privateConstructorUsedError;
  UserDto? get user => throw _privateConstructorUsedError;

  /// Serializes this TokenResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TokenResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TokenResponseCopyWith<TokenResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TokenResponseCopyWith<$Res> {
  factory $TokenResponseCopyWith(
    TokenResponse value,
    $Res Function(TokenResponse) then,
  ) = _$TokenResponseCopyWithImpl<$Res, TokenResponse>;
  @useResult
  $Res call({String access, String refresh, UserDto? user});

  $UserDtoCopyWith<$Res>? get user;
}

/// @nodoc
class _$TokenResponseCopyWithImpl<$Res, $Val extends TokenResponse>
    implements $TokenResponseCopyWith<$Res> {
  _$TokenResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TokenResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? access = null,
    Object? refresh = null,
    Object? user = freezed,
  }) {
    return _then(
      _value.copyWith(
            access: null == access
                ? _value.access
                : access // ignore: cast_nullable_to_non_nullable
                      as String,
            refresh: null == refresh
                ? _value.refresh
                : refresh // ignore: cast_nullable_to_non_nullable
                      as String,
            user: freezed == user
                ? _value.user
                : user // ignore: cast_nullable_to_non_nullable
                      as UserDto?,
          )
          as $Val,
    );
  }

  /// Create a copy of TokenResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $UserDtoCopyWith<$Res>? get user {
    if (_value.user == null) {
      return null;
    }

    return $UserDtoCopyWith<$Res>(_value.user!, (value) {
      return _then(_value.copyWith(user: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$TokenResponseImplCopyWith<$Res>
    implements $TokenResponseCopyWith<$Res> {
  factory _$$TokenResponseImplCopyWith(
    _$TokenResponseImpl value,
    $Res Function(_$TokenResponseImpl) then,
  ) = __$$TokenResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String access, String refresh, UserDto? user});

  @override
  $UserDtoCopyWith<$Res>? get user;
}

/// @nodoc
class __$$TokenResponseImplCopyWithImpl<$Res>
    extends _$TokenResponseCopyWithImpl<$Res, _$TokenResponseImpl>
    implements _$$TokenResponseImplCopyWith<$Res> {
  __$$TokenResponseImplCopyWithImpl(
    _$TokenResponseImpl _value,
    $Res Function(_$TokenResponseImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TokenResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? access = null,
    Object? refresh = null,
    Object? user = freezed,
  }) {
    return _then(
      _$TokenResponseImpl(
        access: null == access
            ? _value.access
            : access // ignore: cast_nullable_to_non_nullable
                  as String,
        refresh: null == refresh
            ? _value.refresh
            : refresh // ignore: cast_nullable_to_non_nullable
                  as String,
        user: freezed == user
            ? _value.user
            : user // ignore: cast_nullable_to_non_nullable
                  as UserDto?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$TokenResponseImpl implements _TokenResponse {
  const _$TokenResponseImpl({
    required this.access,
    required this.refresh,
    this.user,
  });

  factory _$TokenResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$TokenResponseImplFromJson(json);

  @override
  final String access;
  @override
  final String refresh;
  @override
  final UserDto? user;

  @override
  String toString() {
    return 'TokenResponse(access: $access, refresh: $refresh, user: $user)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TokenResponseImpl &&
            (identical(other.access, access) || other.access == access) &&
            (identical(other.refresh, refresh) || other.refresh == refresh) &&
            (identical(other.user, user) || other.user == user));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, access, refresh, user);

  /// Create a copy of TokenResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TokenResponseImplCopyWith<_$TokenResponseImpl> get copyWith =>
      __$$TokenResponseImplCopyWithImpl<_$TokenResponseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TokenResponseImplToJson(this);
  }
}

abstract class _TokenResponse implements TokenResponse {
  const factory _TokenResponse({
    required final String access,
    required final String refresh,
    final UserDto? user,
  }) = _$TokenResponseImpl;

  factory _TokenResponse.fromJson(Map<String, dynamic> json) =
      _$TokenResponseImpl.fromJson;

  @override
  String get access;
  @override
  String get refresh;
  @override
  UserDto? get user;

  /// Create a copy of TokenResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TokenResponseImplCopyWith<_$TokenResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

TokenRefreshResponse _$TokenRefreshResponseFromJson(Map<String, dynamic> json) {
  return _TokenRefreshResponse.fromJson(json);
}

/// @nodoc
mixin _$TokenRefreshResponse {
  String get access => throw _privateConstructorUsedError;
  String? get refresh => throw _privateConstructorUsedError;

  /// Serializes this TokenRefreshResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TokenRefreshResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TokenRefreshResponseCopyWith<TokenRefreshResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TokenRefreshResponseCopyWith<$Res> {
  factory $TokenRefreshResponseCopyWith(
    TokenRefreshResponse value,
    $Res Function(TokenRefreshResponse) then,
  ) = _$TokenRefreshResponseCopyWithImpl<$Res, TokenRefreshResponse>;
  @useResult
  $Res call({String access, String? refresh});
}

/// @nodoc
class _$TokenRefreshResponseCopyWithImpl<
  $Res,
  $Val extends TokenRefreshResponse
>
    implements $TokenRefreshResponseCopyWith<$Res> {
  _$TokenRefreshResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TokenRefreshResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? access = null, Object? refresh = freezed}) {
    return _then(
      _value.copyWith(
            access: null == access
                ? _value.access
                : access // ignore: cast_nullable_to_non_nullable
                      as String,
            refresh: freezed == refresh
                ? _value.refresh
                : refresh // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$TokenRefreshResponseImplCopyWith<$Res>
    implements $TokenRefreshResponseCopyWith<$Res> {
  factory _$$TokenRefreshResponseImplCopyWith(
    _$TokenRefreshResponseImpl value,
    $Res Function(_$TokenRefreshResponseImpl) then,
  ) = __$$TokenRefreshResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String access, String? refresh});
}

/// @nodoc
class __$$TokenRefreshResponseImplCopyWithImpl<$Res>
    extends _$TokenRefreshResponseCopyWithImpl<$Res, _$TokenRefreshResponseImpl>
    implements _$$TokenRefreshResponseImplCopyWith<$Res> {
  __$$TokenRefreshResponseImplCopyWithImpl(
    _$TokenRefreshResponseImpl _value,
    $Res Function(_$TokenRefreshResponseImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TokenRefreshResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? access = null, Object? refresh = freezed}) {
    return _then(
      _$TokenRefreshResponseImpl(
        access: null == access
            ? _value.access
            : access // ignore: cast_nullable_to_non_nullable
                  as String,
        refresh: freezed == refresh
            ? _value.refresh
            : refresh // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$TokenRefreshResponseImpl implements _TokenRefreshResponse {
  const _$TokenRefreshResponseImpl({required this.access, this.refresh});

  factory _$TokenRefreshResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$TokenRefreshResponseImplFromJson(json);

  @override
  final String access;
  @override
  final String? refresh;

  @override
  String toString() {
    return 'TokenRefreshResponse(access: $access, refresh: $refresh)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TokenRefreshResponseImpl &&
            (identical(other.access, access) || other.access == access) &&
            (identical(other.refresh, refresh) || other.refresh == refresh));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, access, refresh);

  /// Create a copy of TokenRefreshResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TokenRefreshResponseImplCopyWith<_$TokenRefreshResponseImpl>
  get copyWith =>
      __$$TokenRefreshResponseImplCopyWithImpl<_$TokenRefreshResponseImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$TokenRefreshResponseImplToJson(this);
  }
}

abstract class _TokenRefreshResponse implements TokenRefreshResponse {
  const factory _TokenRefreshResponse({
    required final String access,
    final String? refresh,
  }) = _$TokenRefreshResponseImpl;

  factory _TokenRefreshResponse.fromJson(Map<String, dynamic> json) =
      _$TokenRefreshResponseImpl.fromJson;

  @override
  String get access;
  @override
  String? get refresh;

  /// Create a copy of TokenRefreshResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TokenRefreshResponseImplCopyWith<_$TokenRefreshResponseImpl>
  get copyWith => throw _privateConstructorUsedError;
}

TokenObtainRequest _$TokenObtainRequestFromJson(Map<String, dynamic> json) {
  return _TokenObtainRequest.fromJson(json);
}

/// @nodoc
mixin _$TokenObtainRequest {
  String get username => throw _privateConstructorUsedError;
  String get password => throw _privateConstructorUsedError;
  String get provider => throw _privateConstructorUsedError;
  String get platform => throw _privateConstructorUsedError;

  /// Serializes this TokenObtainRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TokenObtainRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TokenObtainRequestCopyWith<TokenObtainRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TokenObtainRequestCopyWith<$Res> {
  factory $TokenObtainRequestCopyWith(
    TokenObtainRequest value,
    $Res Function(TokenObtainRequest) then,
  ) = _$TokenObtainRequestCopyWithImpl<$Res, TokenObtainRequest>;
  @useResult
  $Res call({
    String username,
    String password,
    String provider,
    String platform,
  });
}

/// @nodoc
class _$TokenObtainRequestCopyWithImpl<$Res, $Val extends TokenObtainRequest>
    implements $TokenObtainRequestCopyWith<$Res> {
  _$TokenObtainRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TokenObtainRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? username = null,
    Object? password = null,
    Object? provider = null,
    Object? platform = null,
  }) {
    return _then(
      _value.copyWith(
            username: null == username
                ? _value.username
                : username // ignore: cast_nullable_to_non_nullable
                      as String,
            password: null == password
                ? _value.password
                : password // ignore: cast_nullable_to_non_nullable
                      as String,
            provider: null == provider
                ? _value.provider
                : provider // ignore: cast_nullable_to_non_nullable
                      as String,
            platform: null == platform
                ? _value.platform
                : platform // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$TokenObtainRequestImplCopyWith<$Res>
    implements $TokenObtainRequestCopyWith<$Res> {
  factory _$$TokenObtainRequestImplCopyWith(
    _$TokenObtainRequestImpl value,
    $Res Function(_$TokenObtainRequestImpl) then,
  ) = __$$TokenObtainRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String username,
    String password,
    String provider,
    String platform,
  });
}

/// @nodoc
class __$$TokenObtainRequestImplCopyWithImpl<$Res>
    extends _$TokenObtainRequestCopyWithImpl<$Res, _$TokenObtainRequestImpl>
    implements _$$TokenObtainRequestImplCopyWith<$Res> {
  __$$TokenObtainRequestImplCopyWithImpl(
    _$TokenObtainRequestImpl _value,
    $Res Function(_$TokenObtainRequestImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TokenObtainRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? username = null,
    Object? password = null,
    Object? provider = null,
    Object? platform = null,
  }) {
    return _then(
      _$TokenObtainRequestImpl(
        username: null == username
            ? _value.username
            : username // ignore: cast_nullable_to_non_nullable
                  as String,
        password: null == password
            ? _value.password
            : password // ignore: cast_nullable_to_non_nullable
                  as String,
        provider: null == provider
            ? _value.provider
            : provider // ignore: cast_nullable_to_non_nullable
                  as String,
        platform: null == platform
            ? _value.platform
            : platform // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$TokenObtainRequestImpl implements _TokenObtainRequest {
  const _$TokenObtainRequestImpl({
    this.username = '',
    required this.password,
    this.provider = 'password',
    this.platform = 'unknown',
  });

  factory _$TokenObtainRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$TokenObtainRequestImplFromJson(json);

  @override
  @JsonKey()
  final String username;
  @override
  final String password;
  @override
  @JsonKey()
  final String provider;
  @override
  @JsonKey()
  final String platform;

  @override
  String toString() {
    return 'TokenObtainRequest(username: $username, password: $password, provider: $provider, platform: $platform)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TokenObtainRequestImpl &&
            (identical(other.username, username) ||
                other.username == username) &&
            (identical(other.password, password) ||
                other.password == password) &&
            (identical(other.provider, provider) ||
                other.provider == provider) &&
            (identical(other.platform, platform) ||
                other.platform == platform));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, username, password, provider, platform);

  /// Create a copy of TokenObtainRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TokenObtainRequestImplCopyWith<_$TokenObtainRequestImpl> get copyWith =>
      __$$TokenObtainRequestImplCopyWithImpl<_$TokenObtainRequestImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$TokenObtainRequestImplToJson(this);
  }
}

abstract class _TokenObtainRequest implements TokenObtainRequest {
  const factory _TokenObtainRequest({
    final String username,
    required final String password,
    final String provider,
    final String platform,
  }) = _$TokenObtainRequestImpl;

  factory _TokenObtainRequest.fromJson(Map<String, dynamic> json) =
      _$TokenObtainRequestImpl.fromJson;

  @override
  String get username;
  @override
  String get password;
  @override
  String get provider;
  @override
  String get platform;

  /// Create a copy of TokenObtainRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TokenObtainRequestImplCopyWith<_$TokenObtainRequestImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

AccountCreateRequest _$AccountCreateRequestFromJson(Map<String, dynamic> json) {
  return _AccountCreateRequest.fromJson(json);
}

/// @nodoc
mixin _$AccountCreateRequest {
  String get username => throw _privateConstructorUsedError;
  String get email => throw _privateConstructorUsedError;
  String get password => throw _privateConstructorUsedError;
  @JsonKey(name: 'first_name')
  String get firstName => throw _privateConstructorUsedError;
  @JsonKey(name: 'last_name')
  String get lastName => throw _privateConstructorUsedError;
  String get provider => throw _privateConstructorUsedError;

  /// Serializes this AccountCreateRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AccountCreateRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AccountCreateRequestCopyWith<AccountCreateRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AccountCreateRequestCopyWith<$Res> {
  factory $AccountCreateRequestCopyWith(
    AccountCreateRequest value,
    $Res Function(AccountCreateRequest) then,
  ) = _$AccountCreateRequestCopyWithImpl<$Res, AccountCreateRequest>;
  @useResult
  $Res call({
    String username,
    String email,
    String password,
    @JsonKey(name: 'first_name') String firstName,
    @JsonKey(name: 'last_name') String lastName,
    String provider,
  });
}

/// @nodoc
class _$AccountCreateRequestCopyWithImpl<
  $Res,
  $Val extends AccountCreateRequest
>
    implements $AccountCreateRequestCopyWith<$Res> {
  _$AccountCreateRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AccountCreateRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? username = null,
    Object? email = null,
    Object? password = null,
    Object? firstName = null,
    Object? lastName = null,
    Object? provider = null,
  }) {
    return _then(
      _value.copyWith(
            username: null == username
                ? _value.username
                : username // ignore: cast_nullable_to_non_nullable
                      as String,
            email: null == email
                ? _value.email
                : email // ignore: cast_nullable_to_non_nullable
                      as String,
            password: null == password
                ? _value.password
                : password // ignore: cast_nullable_to_non_nullable
                      as String,
            firstName: null == firstName
                ? _value.firstName
                : firstName // ignore: cast_nullable_to_non_nullable
                      as String,
            lastName: null == lastName
                ? _value.lastName
                : lastName // ignore: cast_nullable_to_non_nullable
                      as String,
            provider: null == provider
                ? _value.provider
                : provider // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$AccountCreateRequestImplCopyWith<$Res>
    implements $AccountCreateRequestCopyWith<$Res> {
  factory _$$AccountCreateRequestImplCopyWith(
    _$AccountCreateRequestImpl value,
    $Res Function(_$AccountCreateRequestImpl) then,
  ) = __$$AccountCreateRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String username,
    String email,
    String password,
    @JsonKey(name: 'first_name') String firstName,
    @JsonKey(name: 'last_name') String lastName,
    String provider,
  });
}

/// @nodoc
class __$$AccountCreateRequestImplCopyWithImpl<$Res>
    extends _$AccountCreateRequestCopyWithImpl<$Res, _$AccountCreateRequestImpl>
    implements _$$AccountCreateRequestImplCopyWith<$Res> {
  __$$AccountCreateRequestImplCopyWithImpl(
    _$AccountCreateRequestImpl _value,
    $Res Function(_$AccountCreateRequestImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AccountCreateRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? username = null,
    Object? email = null,
    Object? password = null,
    Object? firstName = null,
    Object? lastName = null,
    Object? provider = null,
  }) {
    return _then(
      _$AccountCreateRequestImpl(
        username: null == username
            ? _value.username
            : username // ignore: cast_nullable_to_non_nullable
                  as String,
        email: null == email
            ? _value.email
            : email // ignore: cast_nullable_to_non_nullable
                  as String,
        password: null == password
            ? _value.password
            : password // ignore: cast_nullable_to_non_nullable
                  as String,
        firstName: null == firstName
            ? _value.firstName
            : firstName // ignore: cast_nullable_to_non_nullable
                  as String,
        lastName: null == lastName
            ? _value.lastName
            : lastName // ignore: cast_nullable_to_non_nullable
                  as String,
        provider: null == provider
            ? _value.provider
            : provider // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$AccountCreateRequestImpl implements _AccountCreateRequest {
  const _$AccountCreateRequestImpl({
    required this.username,
    required this.email,
    required this.password,
    @JsonKey(name: 'first_name') this.firstName = '',
    @JsonKey(name: 'last_name') this.lastName = '',
    this.provider = 'password',
  });

  factory _$AccountCreateRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$AccountCreateRequestImplFromJson(json);

  @override
  final String username;
  @override
  final String email;
  @override
  final String password;
  @override
  @JsonKey(name: 'first_name')
  final String firstName;
  @override
  @JsonKey(name: 'last_name')
  final String lastName;
  @override
  @JsonKey()
  final String provider;

  @override
  String toString() {
    return 'AccountCreateRequest(username: $username, email: $email, password: $password, firstName: $firstName, lastName: $lastName, provider: $provider)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AccountCreateRequestImpl &&
            (identical(other.username, username) ||
                other.username == username) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.password, password) ||
                other.password == password) &&
            (identical(other.firstName, firstName) ||
                other.firstName == firstName) &&
            (identical(other.lastName, lastName) ||
                other.lastName == lastName) &&
            (identical(other.provider, provider) ||
                other.provider == provider));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    username,
    email,
    password,
    firstName,
    lastName,
    provider,
  );

  /// Create a copy of AccountCreateRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AccountCreateRequestImplCopyWith<_$AccountCreateRequestImpl>
  get copyWith =>
      __$$AccountCreateRequestImplCopyWithImpl<_$AccountCreateRequestImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$AccountCreateRequestImplToJson(this);
  }
}

abstract class _AccountCreateRequest implements AccountCreateRequest {
  const factory _AccountCreateRequest({
    required final String username,
    required final String email,
    required final String password,
    @JsonKey(name: 'first_name') final String firstName,
    @JsonKey(name: 'last_name') final String lastName,
    final String provider,
  }) = _$AccountCreateRequestImpl;

  factory _AccountCreateRequest.fromJson(Map<String, dynamic> json) =
      _$AccountCreateRequestImpl.fromJson;

  @override
  String get username;
  @override
  String get email;
  @override
  String get password;
  @override
  @JsonKey(name: 'first_name')
  String get firstName;
  @override
  @JsonKey(name: 'last_name')
  String get lastName;
  @override
  String get provider;

  /// Create a copy of AccountCreateRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AccountCreateRequestImplCopyWith<_$AccountCreateRequestImpl>
  get copyWith => throw _privateConstructorUsedError;
}
