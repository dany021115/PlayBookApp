import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../constants/api.dart';
import '../entities/auth_responses.dart';
import '../entities/user_dto.dart';

part 'rest_client.g.dart';

@RestApi()
abstract class RestClient {
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;

  // ── Auth ──
  @POST(ApiConstants.tokenObtain)
  Future<TokenResponse> tokenObtain(@Body() TokenObtainRequest body);

  @POST(ApiConstants.tokenRefresh)
  Future<TokenRefreshResponse> tokenRefresh(@Body() Map<String, dynamic> body);

  @POST(ApiConstants.accountCreate)
  Future<UserDto> accountCreate(@Body() AccountCreateRequest body);

  @GET(ApiConstants.accountMe)
  Future<UserDto> accountMe();

  @POST(ApiConstants.passwordReset)
  Future<dynamic> passwordReset(@Body() Map<String, dynamic> body);

  // ── Devices (push) ──
  @POST(ApiConstants.registerDevice)
  Future<dynamic> registerDevice(@Body() Map<String, dynamic> body);
}
