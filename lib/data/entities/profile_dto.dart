import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/profile.dart';

part 'profile_dto.freezed.dart';
part 'profile_dto.g.dart';

@freezed
class ProfileDto with _$ProfileDto {
  const ProfileDto._();

  const factory ProfileDto({
    required int id,
    String? avatar,
    String? phone,
    @Default('') String country,
    String? provider,
    @Default('es') String locale,
  }) = _ProfileDto;

  factory ProfileDto.fromJson(Map<String, dynamic> json) =>
      _$ProfileDtoFromJson(json);

  Profile toEntity() => Profile(
        id: id,
        avatar: avatar,
        phone: phone,
        country: country,
        provider: provider,
        locale: locale,
      );
}
