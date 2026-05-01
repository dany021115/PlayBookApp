// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_responses.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TokenResponseImpl _$$TokenResponseImplFromJson(Map<String, dynamic> json) =>
    _$TokenResponseImpl(
      access: json['access'] as String,
      refresh: json['refresh'] as String,
      user: json['user'] == null
          ? null
          : UserDto.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$TokenResponseImplToJson(_$TokenResponseImpl instance) =>
    <String, dynamic>{
      'access': instance.access,
      'refresh': instance.refresh,
      'user': instance.user,
    };

_$TokenRefreshResponseImpl _$$TokenRefreshResponseImplFromJson(
  Map<String, dynamic> json,
) => _$TokenRefreshResponseImpl(
  access: json['access'] as String,
  refresh: json['refresh'] as String?,
);

Map<String, dynamic> _$$TokenRefreshResponseImplToJson(
  _$TokenRefreshResponseImpl instance,
) => <String, dynamic>{'access': instance.access, 'refresh': instance.refresh};

_$TokenObtainRequestImpl _$$TokenObtainRequestImplFromJson(
  Map<String, dynamic> json,
) => _$TokenObtainRequestImpl(
  username: json['username'] as String? ?? '',
  password: json['password'] as String,
  provider: json['provider'] as String? ?? 'password',
  platform: json['platform'] as String? ?? 'unknown',
);

Map<String, dynamic> _$$TokenObtainRequestImplToJson(
  _$TokenObtainRequestImpl instance,
) => <String, dynamic>{
  'username': instance.username,
  'password': instance.password,
  'provider': instance.provider,
  'platform': instance.platform,
};

_$AccountCreateRequestImpl _$$AccountCreateRequestImplFromJson(
  Map<String, dynamic> json,
) => _$AccountCreateRequestImpl(
  username: json['username'] as String,
  email: json['email'] as String,
  password: json['password'] as String,
  firstName: json['first_name'] as String? ?? '',
  lastName: json['last_name'] as String? ?? '',
  provider: json['provider'] as String? ?? 'password',
);

Map<String, dynamic> _$$AccountCreateRequestImplToJson(
  _$AccountCreateRequestImpl instance,
) => <String, dynamic>{
  'username': instance.username,
  'email': instance.email,
  'password': instance.password,
  'first_name': instance.firstName,
  'last_name': instance.lastName,
  'provider': instance.provider,
};
