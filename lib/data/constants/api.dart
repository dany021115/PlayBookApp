/// REST path constants. Base URL comes from [Env.apiBaseUrl].
class ApiConstants {
  ApiConstants._();

  // Auth
  static const String tokenObtain = '/api/v1/auth/token/';
  static const String tokenRefresh = '/api/v1/auth/token/refresh/';
  static const String tokenVerify = '/api/v1/auth/token/verify/';
  static const String accountCreate = '/api/v1/auth/account/create/';
  static const String accountMe = '/api/v1/auth/account/me/';
  static const String accountMeProfile = '/api/v1/auth/account/me/profile/';
  static const String passwordReset = '/api/v1/auth/password_reset/';
  static const String passwordResetConfirm =
      '/api/v1/auth/password_reset/confirm/';

  // Markets
  static const String sports = '/api/v1/markets/sports/';
  static const String matches = '/api/v1/markets/matches/';
  static const String matchesLive = '/api/v1/markets/matches/live/';
  static String matchDetail(int id) => '/api/v1/markets/matches/$id/';
  static String oddsBySport(String sport) => '/api/v1/markets/odds/$sport/';
  static String oddsByEvent(int eventId) => '/api/v1/markets/odds/event/$eventId/';

  // Predictions
  static const String predictions = '/api/v1/predictions/';
  static const String predictionsAccuracy = '/api/v1/predictions/accuracy/';
  static const String strategies = '/api/v1/strategies/';

  // Engagement
  static const String followsSports = '/api/v1/me/follows/sports/';
  static const String followsLeagues = '/api/v1/me/follows/leagues/';
  static const String savedPredictions = '/api/v1/me/saved-predictions/';
  static const String registerDevice = '/api/v1/devices/register/';
}
