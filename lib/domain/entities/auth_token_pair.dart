import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_token_pair.freezed.dart';

@freezed
class AuthTokenPair with _$AuthTokenPair {
  const factory AuthTokenPair({
    required String access,
    required String refresh,
  }) = _AuthTokenPair;
}
