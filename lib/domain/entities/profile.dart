import 'package:freezed_annotation/freezed_annotation.dart';

part 'profile.freezed.dart';

@freezed
class Profile with _$Profile {
  const factory Profile({
    required int id,
    String? avatar,
    String? phone,
    @Default('') String country,
    String? provider,
    @Default('es') String locale,
  }) = _Profile;
}
