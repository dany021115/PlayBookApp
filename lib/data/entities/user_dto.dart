import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/user.dart';
import 'profile_dto.dart';

part 'user_dto.freezed.dart';
part 'user_dto.g.dart';

@freezed
class UserDto with _$UserDto {
  const UserDto._();

  const factory UserDto({
    required int id,
    required String username,
    required String email,
    @JsonKey(name: 'first_name') @Default('') String firstName,
    @JsonKey(name: 'last_name') @Default('') String lastName,
    @JsonKey(name: 'is_staff') @Default(false) bool isStaff,
    @JsonKey(name: 'is_superuser') @Default(false) bool isSuperuser,
    ProfileDto? profile,
  }) = _UserDto;

  factory UserDto.fromJson(Map<String, dynamic> json) =>
      _$UserDtoFromJson(json);

  User toEntity() => User(
        id: id,
        username: username,
        email: email,
        firstName: firstName,
        lastName: lastName,
        isStaff: isStaff,
        isSuperuser: isSuperuser,
        profile: profile?.toEntity(),
      );
}
