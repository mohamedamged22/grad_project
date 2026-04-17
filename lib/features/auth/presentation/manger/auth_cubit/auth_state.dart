import 'package:beyond_the_pramids/features/auth/data/model/user_model.dart';

abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSuccess extends AuthState {
  final UserModel user;
  AuthSuccess(this.user);
}
class ForgetPasswordSuccess extends AuthState {
  final String message;
  ForgetPasswordSuccess(this.message);
}

class AuthError extends AuthState {
  final String message;
  AuthError(this.message);
}

class AuthLoggedOut extends AuthState {}


// أضف في آخر الملف
class ResetPasswordSuccess extends AuthState {
  final String message;
  ResetPasswordSuccess(this.message);
}


// أضف في آخر الملف
class OtpSuccess extends AuthState {
  final String message;
  OtpSuccess(this.message);
}
