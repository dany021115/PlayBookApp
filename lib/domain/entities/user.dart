import 'package:freezed_annotation/freezed_annotation.dart';

import 'profile.dart';

part 'user.freezed.dart';

@freezed
class User with _$User {
  const factory User({
    required int id,
    required String username,
    required String email,
    @Default('') String firstName,
    @Default('') String lastName,
    @Default(false) bool isStaff,
    @Default(false) bool isSuperuser,
    Profile? profile,
  }) = _User;

  const User._();
}
