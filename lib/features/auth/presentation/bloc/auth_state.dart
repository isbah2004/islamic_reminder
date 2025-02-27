part of 'auth_bloc.dart';

@immutable
sealed class AuthState {
  const AuthState();
}

final class AuthInitial extends AuthState {}

final class AuthLoading extends AuthState {}

final class AuthCurrentView extends AuthState {}

final class AuthSuccess extends AuthState {
  final UserEntity user;
  const AuthSuccess(this.user);
}

final class AuthFailure extends AuthState {
  final String message;
  const AuthFailure(this.message);
}

final class AuthLoginView extends AuthState {}

final class AuthSignUpView extends AuthState {}
