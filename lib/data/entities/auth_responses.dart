import 'package:freezed_annotation/freezed_annotation.dart';

import 'user_dto.dart';

part 'auth_responses.freezed.dart';
part 'auth_responses.g.dart';

@freezed
class TokenResponse with _$TokenResponse {
  const factory TokenResponse({
    required String access,
    required String refresh,
    UserDto? user,
  }) = _TokenResponse;

  factory TokenResponse.fromJson(Map<String, dynamic> json) =>
      _$TokenResponseFromJson(json);
}

@freezed
class TokenRefreshResponse with _$TokenRefreshResponse {
  const factory TokenRefreshResponse({
    required String access,
    String? refresh,
  }) = _TokenRefreshResponse;

  factory TokenRefreshResponse.fromJson(Map<String, dynamic> json) =>
      _$TokenRefreshResponseFromJson(json);
}

@freezed
class TokenObtainRequest with _$TokenObtainRequest {
  const factory TokenObtainRequest({
    @Default('') String username,
    required String password,
    @Default('password') String provider,
    @Default('unknown') String platform,
  }) = _TokenObtainRequest;

  factory TokenObtainRequest.fromJson(Map<String, dynamic> json) =>
      _$TokenObtainRequestFromJson(json);
}

@freezed
class AccountCreateRequest with _$AccountCreateRequest {
  const factory AccountCreateRequest({
    required String username,
    required String email,
    required String password,
    @JsonKey(name: 'first_name') @Default('') String firstName,
    @JsonKey(name: 'last_name') @Default('') String lastName,
    @Default('password') String provider,
  }) = _AccountCreateRequest;

  factory AccountCreateRequest.fromJson(Map<String, dynamic> json) =>
      _$AccountCreateRequestFromJson(json);
}
