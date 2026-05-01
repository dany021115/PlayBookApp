// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ProfileDtoImpl _$$ProfileDtoImplFromJson(Map<String, dynamic> json) =>
    _$ProfileDtoImpl(
      id: (json['id'] as num).toInt(),
      avatar: json['avatar'] as String?,
      phone: json['phone'] as String?,
      country: json['country'] as String? ?? '',
      provider: json['provider'] as String?,
      locale: json['locale'] as String? ?? 'es',
    );

Map<String, dynamic> _$$ProfileDtoImplToJson(_$ProfileDtoImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'avatar': instance.avatar,
      'phone': instance.phone,
      'country': instance.country,
      'provider': instance.provider,
      'locale': instance.locale,
    };
