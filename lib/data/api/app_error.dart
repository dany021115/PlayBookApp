import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_error.freezed.dart';

/// Typed error envelope returned through `Either<AppError, T>`.
///
/// [original] is the underlying Dio response/exception kept for debugging.
@freezed
class AppError with _$AppError {
  const AppError._();

  const factory AppError.network({String? message}) = NetworkError;
  const factory AppError.unauthorized({String? message}) = UnauthorizedError;
  const factory AppError.forbidden({String? message}) = ForbiddenError;
  const factory AppError.notFound({String? message}) = NotFoundError;
  const factory AppError.validation(Map<String, dynamic> fields, {String? message}) =
      ValidationError;
  const factory AppError.server({int? status, String? message}) = ServerError;
  const factory AppError.unknown({String? message}) = UnknownError;

  static AppError fromDio(DioException exc) {
    final response = exc.response;
    final status = response?.statusCode;
    final body = response?.data;
    final detail = body is Map ? (body['detail']?.toString()) : null;

    if (exc.type == DioExceptionType.connectionTimeout ||
        exc.type == DioExceptionType.receiveTimeout ||
        exc.type == DioExceptionType.sendTimeout ||
        exc.type == DioExceptionType.connectionError) {
      return AppError.network(message: detail ?? exc.message);
    }
    switch (status) {
      case 400:
        if (body is Map<String, dynamic>) {
          return AppError.validation(body, message: detail);
        }
        return AppError.validation(const {}, message: detail);
      case 401:
        return AppError.unauthorized(message: detail);
      case 403:
        return AppError.forbidden(message: detail);
      case 404:
        return AppError.notFound(message: detail);
      default:
        if (status != null && status >= 500) {
          return AppError.server(status: status, message: detail);
        }
        return AppError.unknown(message: detail ?? exc.message);
    }
  }

  String get displayMessage => when(
        network: (m) => m ?? 'Sin conexión',
        unauthorized: (m) => m ?? 'Sesión expirada',
        forbidden: (m) => m ?? 'Sin permisos',
        notFound: (m) => m ?? 'No encontrado',
        validation: (_, m) => m ?? 'Datos inválidos',
        server: (s, m) => m ?? 'Error del servidor ($s)',
        unknown: (m) => m ?? 'Error desconocido',
      );
}
