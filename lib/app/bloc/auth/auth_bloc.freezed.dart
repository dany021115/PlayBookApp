// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'auth_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$AuthEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() bootstrap,
    required TResult Function(String username, String password)
    loggedInWithPassword,
    required TResult Function() loggedInWithGoogle,
    required TResult Function(
      String username,
      String email,
      String password,
      String firstName,
      String lastName,
    )
    registered,
    required TResult Function() loggedOut,
    required TResult Function(User? user) userPushed,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? bootstrap,
    TResult? Function(String username, String password)? loggedInWithPassword,
    TResult? Function()? loggedInWithGoogle,
    TResult? Function(
      String username,
      String email,
      String password,
      String firstName,
      String lastName,
    )?
    registered,
    TResult? Function()? loggedOut,
    TResult? Function(User? user)? userPushed,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? bootstrap,
    TResult Function(String username, String password)? loggedInWithPassword,
    TResult Function()? loggedInWithGoogle,
    TResult Function(
      String username,
      String email,
      String password,
      String firstName,
      String lastName,
    )?
    registered,
    TResult Function()? loggedOut,
    TResult Function(User? user)? userPushed,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Bootstrap value) bootstrap,
    required TResult Function(_LoggedInWithPassword value) loggedInWithPassword,
    required TResult Function(_LoggedInWithGoogle value) loggedInWithGoogle,
    required TResult Function(_Registered value) registered,
    required TResult Function(_LoggedOut value) loggedOut,
    required TResult Function(_UserPushed value) userPushed,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Bootstrap value)? bootstrap,
    TResult? Function(_LoggedInWithPassword value)? loggedInWithPassword,
    TResult? Function(_LoggedInWithGoogle value)? loggedInWithGoogle,
    TResult? Function(_Registered value)? registered,
    TResult? Function(_LoggedOut value)? loggedOut,
    TResult? Function(_UserPushed value)? userPushed,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Bootstrap value)? bootstrap,
    TResult Function(_LoggedInWithPassword value)? loggedInWithPassword,
    TResult Function(_LoggedInWithGoogle value)? loggedInWithGoogle,
    TResult Function(_Registered value)? registered,
    TResult Function(_LoggedOut value)? loggedOut,
    TResult Function(_UserPushed value)? userPushed,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AuthEventCopyWith<$Res> {
  factory $AuthEventCopyWith(AuthEvent value, $Res Function(AuthEvent) then) =
      _$AuthEventCopyWithImpl<$Res, AuthEvent>;
}

/// @nodoc
class _$AuthEventCopyWithImpl<$Res, $Val extends AuthEvent>
    implements $AuthEventCopyWith<$Res> {
  _$AuthEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$BootstrapImplCopyWith<$Res> {
  factory _$$BootstrapImplCopyWith(
    _$BootstrapImpl value,
    $Res Function(_$BootstrapImpl) then,
  ) = __$$BootstrapImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$BootstrapImplCopyWithImpl<$Res>
    extends _$AuthEventCopyWithImpl<$Res, _$BootstrapImpl>
    implements _$$BootstrapImplCopyWith<$Res> {
  __$$BootstrapImplCopyWithImpl(
    _$BootstrapImpl _value,
    $Res Function(_$BootstrapImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$BootstrapImpl with DiagnosticableTreeMixin implements _Bootstrap {
  const _$BootstrapImpl();

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'AuthEvent.bootstrap()';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties..add(DiagnosticsProperty('type', 'AuthEvent.bootstrap'));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$BootstrapImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() bootstrap,
    required TResult Function(String username, String password)
    loggedInWithPassword,
    required TResult Function() loggedInWithGoogle,
    required TResult Function(
      String username,
      String email,
      String password,
      String firstName,
      String lastName,
    )
    registered,
    required TResult Function() loggedOut,
    required TResult Function(User? user) userPushed,
  }) {
    return bootstrap();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? bootstrap,
    TResult? Function(String username, String password)? loggedInWithPassword,
    TResult? Function()? loggedInWithGoogle,
    TResult? Function(
      String username,
      String email,
      String password,
      String firstName,
      String lastName,
    )?
    registered,
    TResult? Function()? loggedOut,
    TResult? Function(User? user)? userPushed,
  }) {
    return bootstrap?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? bootstrap,
    TResult Function(String username, String password)? loggedInWithPassword,
    TResult Function()? loggedInWithGoogle,
    TResult Function(
      String username,
      String email,
      String password,
      String firstName,
      String lastName,
    )?
    registered,
    TResult Function()? loggedOut,
    TResult Function(User? user)? userPushed,
    required TResult orElse(),
  }) {
    if (bootstrap != null) {
      return bootstrap();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Bootstrap value) bootstrap,
    required TResult Function(_LoggedInWithPassword value) loggedInWithPassword,
    required TResult Function(_LoggedInWithGoogle value) loggedInWithGoogle,
    required TResult Function(_Registered value) registered,
    required TResult Function(_LoggedOut value) loggedOut,
    required TResult Function(_UserPushed value) userPushed,
  }) {
    return bootstrap(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Bootstrap value)? bootstrap,
    TResult? Function(_LoggedInWithPassword value)? loggedInWithPassword,
    TResult? Function(_LoggedInWithGoogle value)? loggedInWithGoogle,
    TResult? Function(_Registered value)? registered,
    TResult? Function(_LoggedOut value)? loggedOut,
    TResult? Function(_UserPushed value)? userPushed,
  }) {
    return bootstrap?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Bootstrap value)? bootstrap,
    TResult Function(_LoggedInWithPassword value)? loggedInWithPassword,
    TResult Function(_LoggedInWithGoogle value)? loggedInWithGoogle,
    TResult Function(_Registered value)? registered,
    TResult Function(_LoggedOut value)? loggedOut,
    TResult Function(_UserPushed value)? userPushed,
    required TResult orElse(),
  }) {
    if (bootstrap != null) {
      return bootstrap(this);
    }
    return orElse();
  }
}

abstract class _Bootstrap implements AuthEvent {
  const factory _Bootstrap() = _$BootstrapImpl;
}

/// @nodoc
abstract class _$$LoggedInWithPasswordImplCopyWith<$Res> {
  factory _$$LoggedInWithPasswordImplCopyWith(
    _$LoggedInWithPasswordImpl value,
    $Res Function(_$LoggedInWithPasswordImpl) then,
  ) = __$$LoggedInWithPasswordImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String username, String password});
}

/// @nodoc
class __$$LoggedInWithPasswordImplCopyWithImpl<$Res>
    extends _$AuthEventCopyWithImpl<$Res, _$LoggedInWithPasswordImpl>
    implements _$$LoggedInWithPasswordImplCopyWith<$Res> {
  __$$LoggedInWithPasswordImplCopyWithImpl(
    _$LoggedInWithPasswordImpl _value,
    $Res Function(_$LoggedInWithPasswordImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? username = null, Object? password = null}) {
    return _then(
      _$LoggedInWithPasswordImpl(
        username: null == username
            ? _value.username
            : username // ignore: cast_nullable_to_non_nullable
                  as String,
        password: null == password
            ? _value.password
            : password // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$LoggedInWithPasswordImpl
    with DiagnosticableTreeMixin
    implements _LoggedInWithPassword {
  const _$LoggedInWithPasswordImpl({
    required this.username,
    required this.password,
  });

  @override
  final String username;
  @override
  final String password;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'AuthEvent.loggedInWithPassword(username: $username, password: $password)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'AuthEvent.loggedInWithPassword'))
      ..add(DiagnosticsProperty('username', username))
      ..add(DiagnosticsProperty('password', password));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoggedInWithPasswordImpl &&
            (identical(other.username, username) ||
                other.username == username) &&
            (identical(other.password, password) ||
                other.password == password));
  }

  @override
  int get hashCode => Object.hash(runtimeType, username, password);

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LoggedInWithPasswordImplCopyWith<_$LoggedInWithPasswordImpl>
  get copyWith =>
      __$$LoggedInWithPasswordImplCopyWithImpl<_$LoggedInWithPasswordImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() bootstrap,
    required TResult Function(String username, String password)
    loggedInWithPassword,
    required TResult Function() loggedInWithGoogle,
    required TResult Function(
      String username,
      String email,
      String password,
      String firstName,
      String lastName,
    )
    registered,
    required TResult Function() loggedOut,
    required TResult Function(User? user) userPushed,
  }) {
    return loggedInWithPassword(username, password);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? bootstrap,
    TResult? Function(String username, String password)? loggedInWithPassword,
    TResult? Function()? loggedInWithGoogle,
    TResult? Function(
      String username,
      String email,
      String password,
      String firstName,
      String lastName,
    )?
    registered,
    TResult? Function()? loggedOut,
    TResult? Function(User? user)? userPushed,
  }) {
    return loggedInWithPassword?.call(username, password);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? bootstrap,
    TResult Function(String username, String password)? loggedInWithPassword,
    TResult Function()? loggedInWithGoogle,
    TResult Function(
      String username,
      String email,
      String password,
      String firstName,
      String lastName,
    )?
    registered,
    TResult Function()? loggedOut,
    TResult Function(User? user)? userPushed,
    required TResult orElse(),
  }) {
    if (loggedInWithPassword != null) {
      return loggedInWithPassword(username, password);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Bootstrap value) bootstrap,
    required TResult Function(_LoggedInWithPassword value) loggedInWithPassword,
    required TResult Function(_LoggedInWithGoogle value) loggedInWithGoogle,
    required TResult Function(_Registered value) registered,
    required TResult Function(_LoggedOut value) loggedOut,
    required TResult Function(_UserPushed value) userPushed,
  }) {
    return loggedInWithPassword(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Bootstrap value)? bootstrap,
    TResult? Function(_LoggedInWithPassword value)? loggedInWithPassword,
    TResult? Function(_LoggedInWithGoogle value)? loggedInWithGoogle,
    TResult? Function(_Registered value)? registered,
    TResult? Function(_LoggedOut value)? loggedOut,
    TResult? Function(_UserPushed value)? userPushed,
  }) {
    return loggedInWithPassword?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Bootstrap value)? bootstrap,
    TResult Function(_LoggedInWithPassword value)? loggedInWithPassword,
    TResult Function(_LoggedInWithGoogle value)? loggedInWithGoogle,
    TResult Function(_Registered value)? registered,
    TResult Function(_LoggedOut value)? loggedOut,
    TResult Function(_UserPushed value)? userPushed,
    required TResult orElse(),
  }) {
    if (loggedInWithPassword != null) {
      return loggedInWithPassword(this);
    }
    return orElse();
  }
}

abstract class _LoggedInWithPassword implements AuthEvent {
  const factory _LoggedInWithPassword({
    required final String username,
    required final String password,
  }) = _$LoggedInWithPasswordImpl;

  String get username;
  String get password;

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LoggedInWithPasswordImplCopyWith<_$LoggedInWithPasswordImpl>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$LoggedInWithGoogleImplCopyWith<$Res> {
  factory _$$LoggedInWithGoogleImplCopyWith(
    _$LoggedInWithGoogleImpl value,
    $Res Function(_$LoggedInWithGoogleImpl) then,
  ) = __$$LoggedInWithGoogleImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$LoggedInWithGoogleImplCopyWithImpl<$Res>
    extends _$AuthEventCopyWithImpl<$Res, _$LoggedInWithGoogleImpl>
    implements _$$LoggedInWithGoogleImplCopyWith<$Res> {
  __$$LoggedInWithGoogleImplCopyWithImpl(
    _$LoggedInWithGoogleImpl _value,
    $Res Function(_$LoggedInWithGoogleImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$LoggedInWithGoogleImpl
    with DiagnosticableTreeMixin
    implements _LoggedInWithGoogle {
  const _$LoggedInWithGoogleImpl();

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'AuthEvent.loggedInWithGoogle()';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'AuthEvent.loggedInWithGoogle'));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$LoggedInWithGoogleImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() bootstrap,
    required TResult Function(String username, String password)
    loggedInWithPassword,
    required TResult Function() loggedInWithGoogle,
    required TResult Function(
      String username,
      String email,
      String password,
      String firstName,
      String lastName,
    )
    registered,
    required TResult Function() loggedOut,
    required TResult Function(User? user) userPushed,
  }) {
    return loggedInWithGoogle();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? bootstrap,
    TResult? Function(String username, String password)? loggedInWithPassword,
    TResult? Function()? loggedInWithGoogle,
    TResult? Function(
      String username,
      String email,
      String password,
      String firstName,
      String lastName,
    )?
    registered,
    TResult? Function()? loggedOut,
    TResult? Function(User? user)? userPushed,
  }) {
    return loggedInWithGoogle?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? bootstrap,
    TResult Function(String username, String password)? loggedInWithPassword,
    TResult Function()? loggedInWithGoogle,
    TResult Function(
      String username,
      String email,
      String password,
      String firstName,
      String lastName,
    )?
    registered,
    TResult Function()? loggedOut,
    TResult Function(User? user)? userPushed,
    required TResult orElse(),
  }) {
    if (loggedInWithGoogle != null) {
      return loggedInWithGoogle();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Bootstrap value) bootstrap,
    required TResult Function(_LoggedInWithPassword value) loggedInWithPassword,
    required TResult Function(_LoggedInWithGoogle value) loggedInWithGoogle,
    required TResult Function(_Registered value) registered,
    required TResult Function(_LoggedOut value) loggedOut,
    required TResult Function(_UserPushed value) userPushed,
  }) {
    return loggedInWithGoogle(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Bootstrap value)? bootstrap,
    TResult? Function(_LoggedInWithPassword value)? loggedInWithPassword,
    TResult? Function(_LoggedInWithGoogle value)? loggedInWithGoogle,
    TResult? Function(_Registered value)? registered,
    TResult? Function(_LoggedOut value)? loggedOut,
    TResult? Function(_UserPushed value)? userPushed,
  }) {
    return loggedInWithGoogle?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Bootstrap value)? bootstrap,
    TResult Function(_LoggedInWithPassword value)? loggedInWithPassword,
    TResult Function(_LoggedInWithGoogle value)? loggedInWithGoogle,
    TResult Function(_Registered value)? registered,
    TResult Function(_LoggedOut value)? loggedOut,
    TResult Function(_UserPushed value)? userPushed,
    required TResult orElse(),
  }) {
    if (loggedInWithGoogle != null) {
      return loggedInWithGoogle(this);
    }
    return orElse();
  }
}

abstract class _LoggedInWithGoogle implements AuthEvent {
  const factory _LoggedInWithGoogle() = _$LoggedInWithGoogleImpl;
}

/// @nodoc
abstract class _$$RegisteredImplCopyWith<$Res> {
  factory _$$RegisteredImplCopyWith(
    _$RegisteredImpl value,
    $Res Function(_$RegisteredImpl) then,
  ) = __$$RegisteredImplCopyWithImpl<$Res>;
  @useResult
  $Res call({
    String username,
    String email,
    String password,
    String firstName,
    String lastName,
  });
}

/// @nodoc
class __$$RegisteredImplCopyWithImpl<$Res>
    extends _$AuthEventCopyWithImpl<$Res, _$RegisteredImpl>
    implements _$$RegisteredImplCopyWith<$Res> {
  __$$RegisteredImplCopyWithImpl(
    _$RegisteredImpl _value,
    $Res Function(_$RegisteredImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? username = null,
    Object? email = null,
    Object? password = null,
    Object? firstName = null,
    Object? lastName = null,
  }) {
    return _then(
      _$RegisteredImpl(
        username: null == username
            ? _value.username
            : username // ignore: cast_nullable_to_non_nullable
                  as String,
        email: null == email
            ? _value.email
            : email // ignore: cast_nullable_to_non_nullable
                  as String,
        password: null == password
            ? _value.password
            : password // ignore: cast_nullable_to_non_nullable
                  as String,
        firstName: null == firstName
            ? _value.firstName
            : firstName // ignore: cast_nullable_to_non_nullable
                  as String,
        lastName: null == lastName
            ? _value.lastName
            : lastName // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$RegisteredImpl with DiagnosticableTreeMixin implements _Registered {
  const _$RegisteredImpl({
    required this.username,
    required this.email,
    required this.password,
    this.firstName = '',
    this.lastName = '',
  });

  @override
  final String username;
  @override
  final String email;
  @override
  final String password;
  @override
  @JsonKey()
  final String firstName;
  @override
  @JsonKey()
  final String lastName;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'AuthEvent.registered(username: $username, email: $email, password: $password, firstName: $firstName, lastName: $lastName)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'AuthEvent.registered'))
      ..add(DiagnosticsProperty('username', username))
      ..add(DiagnosticsProperty('email', email))
      ..add(DiagnosticsProperty('password', password))
      ..add(DiagnosticsProperty('firstName', firstName))
      ..add(DiagnosticsProperty('lastName', lastName));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RegisteredImpl &&
            (identical(other.username, username) ||
                other.username == username) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.password, password) ||
                other.password == password) &&
            (identical(other.firstName, firstName) ||
                other.firstName == firstName) &&
            (identical(other.lastName, lastName) ||
                other.lastName == lastName));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, username, email, password, firstName, lastName);

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RegisteredImplCopyWith<_$RegisteredImpl> get copyWith =>
      __$$RegisteredImplCopyWithImpl<_$RegisteredImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() bootstrap,
    required TResult Function(String username, String password)
    loggedInWithPassword,
    required TResult Function() loggedInWithGoogle,
    required TResult Function(
      String username,
      String email,
      String password,
      String firstName,
      String lastName,
    )
    registered,
    required TResult Function() loggedOut,
    required TResult Function(User? user) userPushed,
  }) {
    return registered(username, email, password, firstName, lastName);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? bootstrap,
    TResult? Function(String username, String password)? loggedInWithPassword,
    TResult? Function()? loggedInWithGoogle,
    TResult? Function(
      String username,
      String email,
      String password,
      String firstName,
      String lastName,
    )?
    registered,
    TResult? Function()? loggedOut,
    TResult? Function(User? user)? userPushed,
  }) {
    return registered?.call(username, email, password, firstName, lastName);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? bootstrap,
    TResult Function(String username, String password)? loggedInWithPassword,
    TResult Function()? loggedInWithGoogle,
    TResult Function(
      String username,
      String email,
      String password,
      String firstName,
      String lastName,
    )?
    registered,
    TResult Function()? loggedOut,
    TResult Function(User? user)? userPushed,
    required TResult orElse(),
  }) {
    if (registered != null) {
      return registered(username, email, password, firstName, lastName);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Bootstrap value) bootstrap,
    required TResult Function(_LoggedInWithPassword value) loggedInWithPassword,
    required TResult Function(_LoggedInWithGoogle value) loggedInWithGoogle,
    required TResult Function(_Registered value) registered,
    required TResult Function(_LoggedOut value) loggedOut,
    required TResult Function(_UserPushed value) userPushed,
  }) {
    return registered(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Bootstrap value)? bootstrap,
    TResult? Function(_LoggedInWithPassword value)? loggedInWithPassword,
    TResult? Function(_LoggedInWithGoogle value)? loggedInWithGoogle,
    TResult? Function(_Registered value)? registered,
    TResult? Function(_LoggedOut value)? loggedOut,
    TResult? Function(_UserPushed value)? userPushed,
  }) {
    return registered?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Bootstrap value)? bootstrap,
    TResult Function(_LoggedInWithPassword value)? loggedInWithPassword,
    TResult Function(_LoggedInWithGoogle value)? loggedInWithGoogle,
    TResult Function(_Registered value)? registered,
    TResult Function(_LoggedOut value)? loggedOut,
    TResult Function(_UserPushed value)? userPushed,
    required TResult orElse(),
  }) {
    if (registered != null) {
      return registered(this);
    }
    return orElse();
  }
}

abstract class _Registered implements AuthEvent {
  const factory _Registered({
    required final String username,
    required final String email,
    required final String password,
    final String firstName,
    final String lastName,
  }) = _$RegisteredImpl;

  String get username;
  String get email;
  String get password;
  String get firstName;
  String get lastName;

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RegisteredImplCopyWith<_$RegisteredImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$LoggedOutImplCopyWith<$Res> {
  factory _$$LoggedOutImplCopyWith(
    _$LoggedOutImpl value,
    $Res Function(_$LoggedOutImpl) then,
  ) = __$$LoggedOutImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$LoggedOutImplCopyWithImpl<$Res>
    extends _$AuthEventCopyWithImpl<$Res, _$LoggedOutImpl>
    implements _$$LoggedOutImplCopyWith<$Res> {
  __$$LoggedOutImplCopyWithImpl(
    _$LoggedOutImpl _value,
    $Res Function(_$LoggedOutImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$LoggedOutImpl with DiagnosticableTreeMixin implements _LoggedOut {
  const _$LoggedOutImpl();

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'AuthEvent.loggedOut()';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties..add(DiagnosticsProperty('type', 'AuthEvent.loggedOut'));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$LoggedOutImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() bootstrap,
    required TResult Function(String username, String password)
    loggedInWithPassword,
    required TResult Function() loggedInWithGoogle,
    required TResult Function(
      String username,
      String email,
      String password,
      String firstName,
      String lastName,
    )
    registered,
    required TResult Function() loggedOut,
    required TResult Function(User? user) userPushed,
  }) {
    return loggedOut();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? bootstrap,
    TResult? Function(String username, String password)? loggedInWithPassword,
    TResult? Function()? loggedInWithGoogle,
    TResult? Function(
      String username,
      String email,
      String password,
      String firstName,
      String lastName,
    )?
    registered,
    TResult? Function()? loggedOut,
    TResult? Function(User? user)? userPushed,
  }) {
    return loggedOut?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? bootstrap,
    TResult Function(String username, String password)? loggedInWithPassword,
    TResult Function()? loggedInWithGoogle,
    TResult Function(
      String username,
      String email,
      String password,
      String firstName,
      String lastName,
    )?
    registered,
    TResult Function()? loggedOut,
    TResult Function(User? user)? userPushed,
    required TResult orElse(),
  }) {
    if (loggedOut != null) {
      return loggedOut();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Bootstrap value) bootstrap,
    required TResult Function(_LoggedInWithPassword value) loggedInWithPassword,
    required TResult Function(_LoggedInWithGoogle value) loggedInWithGoogle,
    required TResult Function(_Registered value) registered,
    required TResult Function(_LoggedOut value) loggedOut,
    required TResult Function(_UserPushed value) userPushed,
  }) {
    return loggedOut(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Bootstrap value)? bootstrap,
    TResult? Function(_LoggedInWithPassword value)? loggedInWithPassword,
    TResult? Function(_LoggedInWithGoogle value)? loggedInWithGoogle,
    TResult? Function(_Registered value)? registered,
    TResult? Function(_LoggedOut value)? loggedOut,
    TResult? Function(_UserPushed value)? userPushed,
  }) {
    return loggedOut?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Bootstrap value)? bootstrap,
    TResult Function(_LoggedInWithPassword value)? loggedInWithPassword,
    TResult Function(_LoggedInWithGoogle value)? loggedInWithGoogle,
    TResult Function(_Registered value)? registered,
    TResult Function(_LoggedOut value)? loggedOut,
    TResult Function(_UserPushed value)? userPushed,
    required TResult orElse(),
  }) {
    if (loggedOut != null) {
      return loggedOut(this);
    }
    return orElse();
  }
}

abstract class _LoggedOut implements AuthEvent {
  const factory _LoggedOut() = _$LoggedOutImpl;
}

/// @nodoc
abstract class _$$UserPushedImplCopyWith<$Res> {
  factory _$$UserPushedImplCopyWith(
    _$UserPushedImpl value,
    $Res Function(_$UserPushedImpl) then,
  ) = __$$UserPushedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({User? user});

  $UserCopyWith<$Res>? get user;
}

/// @nodoc
class __$$UserPushedImplCopyWithImpl<$Res>
    extends _$AuthEventCopyWithImpl<$Res, _$UserPushedImpl>
    implements _$$UserPushedImplCopyWith<$Res> {
  __$$UserPushedImplCopyWithImpl(
    _$UserPushedImpl _value,
    $Res Function(_$UserPushedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? user = freezed}) {
    return _then(
      _$UserPushedImpl(
        freezed == user
            ? _value.user
            : user // ignore: cast_nullable_to_non_nullable
                  as User?,
      ),
    );
  }

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $UserCopyWith<$Res>? get user {
    if (_value.user == null) {
      return null;
    }

    return $UserCopyWith<$Res>(_value.user!, (value) {
      return _then(_value.copyWith(user: value));
    });
  }
}

/// @nodoc

class _$UserPushedImpl with DiagnosticableTreeMixin implements _UserPushed {
  const _$UserPushedImpl(this.user);

  @override
  final User? user;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'AuthEvent.userPushed(user: $user)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'AuthEvent.userPushed'))
      ..add(DiagnosticsProperty('user', user));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserPushedImpl &&
            (identical(other.user, user) || other.user == user));
  }

  @override
  int get hashCode => Object.hash(runtimeType, user);

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UserPushedImplCopyWith<_$UserPushedImpl> get copyWith =>
      __$$UserPushedImplCopyWithImpl<_$UserPushedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() bootstrap,
    required TResult Function(String username, String password)
    loggedInWithPassword,
    required TResult Function() loggedInWithGoogle,
    required TResult Function(
      String username,
      String email,
      String password,
      String firstName,
      String lastName,
    )
    registered,
    required TResult Function() loggedOut,
    required TResult Function(User? user) userPushed,
  }) {
    return userPushed(user);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? bootstrap,
    TResult? Function(String username, String password)? loggedInWithPassword,
    TResult? Function()? loggedInWithGoogle,
    TResult? Function(
      String username,
      String email,
      String password,
      String firstName,
      String lastName,
    )?
    registered,
    TResult? Function()? loggedOut,
    TResult? Function(User? user)? userPushed,
  }) {
    return userPushed?.call(user);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? bootstrap,
    TResult Function(String username, String password)? loggedInWithPassword,
    TResult Function()? loggedInWithGoogle,
    TResult Function(
      String username,
      String email,
      String password,
      String firstName,
      String lastName,
    )?
    registered,
    TResult Function()? loggedOut,
    TResult Function(User? user)? userPushed,
    required TResult orElse(),
  }) {
    if (userPushed != null) {
      return userPushed(user);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Bootstrap value) bootstrap,
    required TResult Function(_LoggedInWithPassword value) loggedInWithPassword,
    required TResult Function(_LoggedInWithGoogle value) loggedInWithGoogle,
    required TResult Function(_Registered value) registered,
    required TResult Function(_LoggedOut value) loggedOut,
    required TResult Function(_UserPushed value) userPushed,
  }) {
    return userPushed(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Bootstrap value)? bootstrap,
    TResult? Function(_LoggedInWithPassword value)? loggedInWithPassword,
    TResult? Function(_LoggedInWithGoogle value)? loggedInWithGoogle,
    TResult? Function(_Registered value)? registered,
    TResult? Function(_LoggedOut value)? loggedOut,
    TResult? Function(_UserPushed value)? userPushed,
  }) {
    return userPushed?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Bootstrap value)? bootstrap,
    TResult Function(_LoggedInWithPassword value)? loggedInWithPassword,
    TResult Function(_LoggedInWithGoogle value)? loggedInWithGoogle,
    TResult Function(_Registered value)? registered,
    TResult Function(_LoggedOut value)? loggedOut,
    TResult Function(_UserPushed value)? userPushed,
    required TResult orElse(),
  }) {
    if (userPushed != null) {
      return userPushed(this);
    }
    return orElse();
  }
}

abstract class _UserPushed implements AuthEvent {
  const factory _UserPushed(final User? user) = _$UserPushedImpl;

  User? get user;

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserPushedImplCopyWith<_$UserPushedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$AuthState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(User user) authenticated,
    required TResult Function() unauthenticated,
    required TResult Function(AppError error) error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(User user)? authenticated,
    TResult? Function()? unauthenticated,
    TResult? Function(AppError error)? error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(User user)? authenticated,
    TResult Function()? unauthenticated,
    TResult Function(AppError error)? error,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AuthStateInitial value) initial,
    required TResult Function(AuthStateLoading value) loading,
    required TResult Function(AuthStateAuthenticated value) authenticated,
    required TResult Function(AuthStateUnauthenticated value) unauthenticated,
    required TResult Function(AuthStateError value) error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AuthStateInitial value)? initial,
    TResult? Function(AuthStateLoading value)? loading,
    TResult? Function(AuthStateAuthenticated value)? authenticated,
    TResult? Function(AuthStateUnauthenticated value)? unauthenticated,
    TResult? Function(AuthStateError value)? error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AuthStateInitial value)? initial,
    TResult Function(AuthStateLoading value)? loading,
    TResult Function(AuthStateAuthenticated value)? authenticated,
    TResult Function(AuthStateUnauthenticated value)? unauthenticated,
    TResult Function(AuthStateError value)? error,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AuthStateCopyWith<$Res> {
  factory $AuthStateCopyWith(AuthState value, $Res Function(AuthState) then) =
      _$AuthStateCopyWithImpl<$Res, AuthState>;
}

/// @nodoc
class _$AuthStateCopyWithImpl<$Res, $Val extends AuthState>
    implements $AuthStateCopyWith<$Res> {
  _$AuthStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$AuthStateInitialImplCopyWith<$Res> {
  factory _$$AuthStateInitialImplCopyWith(
    _$AuthStateInitialImpl value,
    $Res Function(_$AuthStateInitialImpl) then,
  ) = __$$AuthStateInitialImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$AuthStateInitialImplCopyWithImpl<$Res>
    extends _$AuthStateCopyWithImpl<$Res, _$AuthStateInitialImpl>
    implements _$$AuthStateInitialImplCopyWith<$Res> {
  __$$AuthStateInitialImplCopyWithImpl(
    _$AuthStateInitialImpl _value,
    $Res Function(_$AuthStateInitialImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$AuthStateInitialImpl extends AuthStateInitial
    with DiagnosticableTreeMixin {
  const _$AuthStateInitialImpl() : super._();

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'AuthState.initial()';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties..add(DiagnosticsProperty('type', 'AuthState.initial'));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$AuthStateInitialImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(User user) authenticated,
    required TResult Function() unauthenticated,
    required TResult Function(AppError error) error,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(User user)? authenticated,
    TResult? Function()? unauthenticated,
    TResult? Function(AppError error)? error,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(User user)? authenticated,
    TResult Function()? unauthenticated,
    TResult Function(AppError error)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AuthStateInitial value) initial,
    required TResult Function(AuthStateLoading value) loading,
    required TResult Function(AuthStateAuthenticated value) authenticated,
    required TResult Function(AuthStateUnauthenticated value) unauthenticated,
    required TResult Function(AuthStateError value) error,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AuthStateInitial value)? initial,
    TResult? Function(AuthStateLoading value)? loading,
    TResult? Function(AuthStateAuthenticated value)? authenticated,
    TResult? Function(AuthStateUnauthenticated value)? unauthenticated,
    TResult? Function(AuthStateError value)? error,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AuthStateInitial value)? initial,
    TResult Function(AuthStateLoading value)? loading,
    TResult Function(AuthStateAuthenticated value)? authenticated,
    TResult Function(AuthStateUnauthenticated value)? unauthenticated,
    TResult Function(AuthStateError value)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class AuthStateInitial extends AuthState {
  const factory AuthStateInitial() = _$AuthStateInitialImpl;
  const AuthStateInitial._() : super._();
}

/// @nodoc
abstract class _$$AuthStateLoadingImplCopyWith<$Res> {
  factory _$$AuthStateLoadingImplCopyWith(
    _$AuthStateLoadingImpl value,
    $Res Function(_$AuthStateLoadingImpl) then,
  ) = __$$AuthStateLoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$AuthStateLoadingImplCopyWithImpl<$Res>
    extends _$AuthStateCopyWithImpl<$Res, _$AuthStateLoadingImpl>
    implements _$$AuthStateLoadingImplCopyWith<$Res> {
  __$$AuthStateLoadingImplCopyWithImpl(
    _$AuthStateLoadingImpl _value,
    $Res Function(_$AuthStateLoadingImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$AuthStateLoadingImpl extends AuthStateLoading
    with DiagnosticableTreeMixin {
  const _$AuthStateLoadingImpl() : super._();

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'AuthState.loading()';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties..add(DiagnosticsProperty('type', 'AuthState.loading'));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$AuthStateLoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(User user) authenticated,
    required TResult Function() unauthenticated,
    required TResult Function(AppError error) error,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(User user)? authenticated,
    TResult? Function()? unauthenticated,
    TResult? Function(AppError error)? error,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(User user)? authenticated,
    TResult Function()? unauthenticated,
    TResult Function(AppError error)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AuthStateInitial value) initial,
    required TResult Function(AuthStateLoading value) loading,
    required TResult Function(AuthStateAuthenticated value) authenticated,
    required TResult Function(AuthStateUnauthenticated value) unauthenticated,
    required TResult Function(AuthStateError value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AuthStateInitial value)? initial,
    TResult? Function(AuthStateLoading value)? loading,
    TResult? Function(AuthStateAuthenticated value)? authenticated,
    TResult? Function(AuthStateUnauthenticated value)? unauthenticated,
    TResult? Function(AuthStateError value)? error,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AuthStateInitial value)? initial,
    TResult Function(AuthStateLoading value)? loading,
    TResult Function(AuthStateAuthenticated value)? authenticated,
    TResult Function(AuthStateUnauthenticated value)? unauthenticated,
    TResult Function(AuthStateError value)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class AuthStateLoading extends AuthState {
  const factory AuthStateLoading() = _$AuthStateLoadingImpl;
  const AuthStateLoading._() : super._();
}

/// @nodoc
abstract class _$$AuthStateAuthenticatedImplCopyWith<$Res> {
  factory _$$AuthStateAuthenticatedImplCopyWith(
    _$AuthStateAuthenticatedImpl value,
    $Res Function(_$AuthStateAuthenticatedImpl) then,
  ) = __$$AuthStateAuthenticatedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({User user});

  $UserCopyWith<$Res> get user;
}

/// @nodoc
class __$$AuthStateAuthenticatedImplCopyWithImpl<$Res>
    extends _$AuthStateCopyWithImpl<$Res, _$AuthStateAuthenticatedImpl>
    implements _$$AuthStateAuthenticatedImplCopyWith<$Res> {
  __$$AuthStateAuthenticatedImplCopyWithImpl(
    _$AuthStateAuthenticatedImpl _value,
    $Res Function(_$AuthStateAuthenticatedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? user = null}) {
    return _then(
      _$AuthStateAuthenticatedImpl(
        null == user
            ? _value.user
            : user // ignore: cast_nullable_to_non_nullable
                  as User,
      ),
    );
  }

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $UserCopyWith<$Res> get user {
    return $UserCopyWith<$Res>(_value.user, (value) {
      return _then(_value.copyWith(user: value));
    });
  }
}

/// @nodoc

class _$AuthStateAuthenticatedImpl extends AuthStateAuthenticated
    with DiagnosticableTreeMixin {
  const _$AuthStateAuthenticatedImpl(this.user) : super._();

  @override
  final User user;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'AuthState.authenticated(user: $user)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'AuthState.authenticated'))
      ..add(DiagnosticsProperty('user', user));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AuthStateAuthenticatedImpl &&
            (identical(other.user, user) || other.user == user));
  }

  @override
  int get hashCode => Object.hash(runtimeType, user);

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AuthStateAuthenticatedImplCopyWith<_$AuthStateAuthenticatedImpl>
  get copyWith =>
      __$$AuthStateAuthenticatedImplCopyWithImpl<_$AuthStateAuthenticatedImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(User user) authenticated,
    required TResult Function() unauthenticated,
    required TResult Function(AppError error) error,
  }) {
    return authenticated(user);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(User user)? authenticated,
    TResult? Function()? unauthenticated,
    TResult? Function(AppError error)? error,
  }) {
    return authenticated?.call(user);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(User user)? authenticated,
    TResult Function()? unauthenticated,
    TResult Function(AppError error)? error,
    required TResult orElse(),
  }) {
    if (authenticated != null) {
      return authenticated(user);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AuthStateInitial value) initial,
    required TResult Function(AuthStateLoading value) loading,
    required TResult Function(AuthStateAuthenticated value) authenticated,
    required TResult Function(AuthStateUnauthenticated value) unauthenticated,
    required TResult Function(AuthStateError value) error,
  }) {
    return authenticated(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AuthStateInitial value)? initial,
    TResult? Function(AuthStateLoading value)? loading,
    TResult? Function(AuthStateAuthenticated value)? authenticated,
    TResult? Function(AuthStateUnauthenticated value)? unauthenticated,
    TResult? Function(AuthStateError value)? error,
  }) {
    return authenticated?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AuthStateInitial value)? initial,
    TResult Function(AuthStateLoading value)? loading,
    TResult Function(AuthStateAuthenticated value)? authenticated,
    TResult Function(AuthStateUnauthenticated value)? unauthenticated,
    TResult Function(AuthStateError value)? error,
    required TResult orElse(),
  }) {
    if (authenticated != null) {
      return authenticated(this);
    }
    return orElse();
  }
}

abstract class AuthStateAuthenticated extends AuthState {
  const factory AuthStateAuthenticated(final User user) =
      _$AuthStateAuthenticatedImpl;
  const AuthStateAuthenticated._() : super._();

  User get user;

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AuthStateAuthenticatedImplCopyWith<_$AuthStateAuthenticatedImpl>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$AuthStateUnauthenticatedImplCopyWith<$Res> {
  factory _$$AuthStateUnauthenticatedImplCopyWith(
    _$AuthStateUnauthenticatedImpl value,
    $Res Function(_$AuthStateUnauthenticatedImpl) then,
  ) = __$$AuthStateUnauthenticatedImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$AuthStateUnauthenticatedImplCopyWithImpl<$Res>
    extends _$AuthStateCopyWithImpl<$Res, _$AuthStateUnauthenticatedImpl>
    implements _$$AuthStateUnauthenticatedImplCopyWith<$Res> {
  __$$AuthStateUnauthenticatedImplCopyWithImpl(
    _$AuthStateUnauthenticatedImpl _value,
    $Res Function(_$AuthStateUnauthenticatedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$AuthStateUnauthenticatedImpl extends AuthStateUnauthenticated
    with DiagnosticableTreeMixin {
  const _$AuthStateUnauthenticatedImpl() : super._();

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'AuthState.unauthenticated()';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties..add(DiagnosticsProperty('type', 'AuthState.unauthenticated'));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AuthStateUnauthenticatedImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(User user) authenticated,
    required TResult Function() unauthenticated,
    required TResult Function(AppError error) error,
  }) {
    return unauthenticated();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(User user)? authenticated,
    TResult? Function()? unauthenticated,
    TResult? Function(AppError error)? error,
  }) {
    return unauthenticated?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(User user)? authenticated,
    TResult Function()? unauthenticated,
    TResult Function(AppError error)? error,
    required TResult orElse(),
  }) {
    if (unauthenticated != null) {
      return unauthenticated();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AuthStateInitial value) initial,
    required TResult Function(AuthStateLoading value) loading,
    required TResult Function(AuthStateAuthenticated value) authenticated,
    required TResult Function(AuthStateUnauthenticated value) unauthenticated,
    required TResult Function(AuthStateError value) error,
  }) {
    return unauthenticated(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AuthStateInitial value)? initial,
    TResult? Function(AuthStateLoading value)? loading,
    TResult? Function(AuthStateAuthenticated value)? authenticated,
    TResult? Function(AuthStateUnauthenticated value)? unauthenticated,
    TResult? Function(AuthStateError value)? error,
  }) {
    return unauthenticated?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AuthStateInitial value)? initial,
    TResult Function(AuthStateLoading value)? loading,
    TResult Function(AuthStateAuthenticated value)? authenticated,
    TResult Function(AuthStateUnauthenticated value)? unauthenticated,
    TResult Function(AuthStateError value)? error,
    required TResult orElse(),
  }) {
    if (unauthenticated != null) {
      return unauthenticated(this);
    }
    return orElse();
  }
}

abstract class AuthStateUnauthenticated extends AuthState {
  const factory AuthStateUnauthenticated() = _$AuthStateUnauthenticatedImpl;
  const AuthStateUnauthenticated._() : super._();
}

/// @nodoc
abstract class _$$AuthStateErrorImplCopyWith<$Res> {
  factory _$$AuthStateErrorImplCopyWith(
    _$AuthStateErrorImpl value,
    $Res Function(_$AuthStateErrorImpl) then,
  ) = __$$AuthStateErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({AppError error});

  $AppErrorCopyWith<$Res> get error;
}

/// @nodoc
class __$$AuthStateErrorImplCopyWithImpl<$Res>
    extends _$AuthStateCopyWithImpl<$Res, _$AuthStateErrorImpl>
    implements _$$AuthStateErrorImplCopyWith<$Res> {
  __$$AuthStateErrorImplCopyWithImpl(
    _$AuthStateErrorImpl _value,
    $Res Function(_$AuthStateErrorImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? error = null}) {
    return _then(
      _$AuthStateErrorImpl(
        null == error
            ? _value.error
            : error // ignore: cast_nullable_to_non_nullable
                  as AppError,
      ),
    );
  }

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AppErrorCopyWith<$Res> get error {
    return $AppErrorCopyWith<$Res>(_value.error, (value) {
      return _then(_value.copyWith(error: value));
    });
  }
}

/// @nodoc

class _$AuthStateErrorImpl extends AuthStateError with DiagnosticableTreeMixin {
  const _$AuthStateErrorImpl(this.error) : super._();

  @override
  final AppError error;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'AuthState.error(error: $error)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'AuthState.error'))
      ..add(DiagnosticsProperty('error', error));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AuthStateErrorImpl &&
            (identical(other.error, error) || other.error == error));
  }

  @override
  int get hashCode => Object.hash(runtimeType, error);

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AuthStateErrorImplCopyWith<_$AuthStateErrorImpl> get copyWith =>
      __$$AuthStateErrorImplCopyWithImpl<_$AuthStateErrorImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(User user) authenticated,
    required TResult Function() unauthenticated,
    required TResult Function(AppError error) error,
  }) {
    return error(this.error);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(User user)? authenticated,
    TResult? Function()? unauthenticated,
    TResult? Function(AppError error)? error,
  }) {
    return error?.call(this.error);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(User user)? authenticated,
    TResult Function()? unauthenticated,
    TResult Function(AppError error)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this.error);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AuthStateInitial value) initial,
    required TResult Function(AuthStateLoading value) loading,
    required TResult Function(AuthStateAuthenticated value) authenticated,
    required TResult Function(AuthStateUnauthenticated value) unauthenticated,
    required TResult Function(AuthStateError value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AuthStateInitial value)? initial,
    TResult? Function(AuthStateLoading value)? loading,
    TResult? Function(AuthStateAuthenticated value)? authenticated,
    TResult? Function(AuthStateUnauthenticated value)? unauthenticated,
    TResult? Function(AuthStateError value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AuthStateInitial value)? initial,
    TResult Function(AuthStateLoading value)? loading,
    TResult Function(AuthStateAuthenticated value)? authenticated,
    TResult Function(AuthStateUnauthenticated value)? unauthenticated,
    TResult Function(AuthStateError value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class AuthStateError extends AuthState {
  const factory AuthStateError(final AppError error) = _$AuthStateErrorImpl;
  const AuthStateError._() : super._();

  AppError get error;

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AuthStateErrorImplCopyWith<_$AuthStateErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
