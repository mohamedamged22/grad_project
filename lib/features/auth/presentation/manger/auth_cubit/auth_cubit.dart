import 'package:beyond_the_pramids/core/network/api_execptions.dart';
import 'package:beyond_the_pramids/features/auth/data/repo/auth_repo.dart';
import 'package:beyond_the_pramids/features/auth/presentation/manger/auth_cubit/auth_state.dart';
import 'package:beyond_the_pramids/features/account%20type/presentation/views/widgets/language_aware_content.dart'; // ⭐ أضف هذا
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepo _authRepo;

  AuthCubit(this._authRepo) : super(AuthInitial());

  // Form Keys
  GlobalKey<FormState> signInFormKey = GlobalKey();
  GlobalKey<FormState> signUpFormKey = GlobalKey();
  GlobalKey<FormState> forgetPasswordFormKey = GlobalKey();
  GlobalKey<FormState> resetPasswordFormKey = GlobalKey();

  // Sign In Controllers
  TextEditingController signInEmailController = TextEditingController();
  TextEditingController signInPasswordController = TextEditingController();

  // Sign Up Controllers
  TextEditingController signUpNameController = TextEditingController();
  TextEditingController signUpEmailController = TextEditingController();
  TextEditingController signUpPasswordController = TextEditingController();
  TextEditingController signUpConfirmPasswordController =
      TextEditingController();

  // Forget Password Controller
  TextEditingController forgetPasswordEmailController = TextEditingController();

  // Reset Password Controllers
  TextEditingController resetPasswordController = TextEditingController();
  TextEditingController resetConfirmPasswordController =
      TextEditingController();

  // OTP Controller
  TextEditingController otpController = TextEditingController();

  String? _resetEmail;

  /// LOGIN
  Future<void> login() async {
    emit(AuthLoading());
    try {
      final user = await _authRepo.login(
        email: signInEmailController.text.trim(),
        password: signInPasswordController.text.trim(),
      );
      emit(AuthSuccess(user));
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  /// SIGNUP - Updated with role from AccountTypeStore
  Future<void> signup() async {
    emit(AuthLoading());
    try {
      // 🔥 اقرأ الـ role من الـ store
      final store = AccountTypeStore();
      final role = store.selectedType == 'guide' ? 'TOURGUIDE' : 'TOURIST';

      debugPrint('📌 Signing up as: $role');

      final user = await _authRepo.signup(
        name: signUpNameController.text.trim(),
        email: signUpEmailController.text.trim(),
        password: signUpPasswordController.text.trim(),
        role: role, // 🎯 استخدم الـ role من الـ store
      );
      emit(AuthSuccess(user));
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  /// Forget Password
  Future<void> forgetPassword() async {
    emit(AuthLoading());
    try {
      final email = forgetPasswordEmailController.text.trim();
      _resetEmail = email;
      final message = await _authRepo.forgetPassword(email: email);
      emit(ForgetPasswordSuccess(message));
    } on ApiException catch (e) {
      emit(
        AuthError(e.message.isEmpty ? 'auth_failed_send_otp'.tr() : e.message),
      );
    } catch (e) {
      emit(AuthError('auth_unexpected_error'.tr()));
    }
  }

  /// Check OTP
  Future<void> checkOtp() async {
    emit(AuthLoading());
    try {
      final message = await _authRepo.checkOtp(otp: otpController.text.trim());
      emit(OtpSuccess(message));
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  /// Reset Password
  Future<void> resetPassword() async {
    emit(AuthLoading());
    try {
      final emailToUse = _resetEmail;

      if (emailToUse == null || emailToUse.isEmpty) {
        emit(AuthError('auth_email_required'.tr()));
        return;
      }

      final message = await _authRepo.resetPassword(
        email: emailToUse,
        newPassword: resetPasswordController.text.trim(),
      );

      clearForgetPasswordData();
      emit(ResetPasswordSuccess(message));
    } on ApiException catch (e) {
      emit(AuthError(e.message.isEmpty ? 'auth_reset_failed'.tr() : e.message));
    } catch (e) {
      emit(AuthError('auth_unexpected_error'.tr()));
    }
  }

  /// LOGOUT
  Future<void> logout() async {
    emit(AuthLoading());
    try {
      await _authRepo.logout();
      emit(AuthLoggedOut());
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  /// Clear Forget Password Data
  void clearForgetPasswordData() {
    _resetEmail = null;
    forgetPasswordEmailController.clear();
    otpController.clear();
    resetPasswordController.clear();
    resetConfirmPasswordController.clear();
  }

  /// Clear Sign In Data
  void clearSignInData() {
    signInEmailController.clear();
    signInPasswordController.clear();
  }

  /// Clear Sign Up Data
  void clearSignUpData() {
    signUpNameController.clear();
    signUpEmailController.clear();
    signUpPasswordController.clear();
    signUpConfirmPasswordController.clear();
  }

  String? get resetEmail => _resetEmail;

  @override
  Future<void> close() {
    // Dispose controllers
    signInEmailController.dispose();
    signInPasswordController.dispose();
    signUpNameController.dispose();
    signUpEmailController.dispose();
    signUpPasswordController.dispose();
    signUpConfirmPasswordController.dispose();
    forgetPasswordEmailController.dispose();
    resetPasswordController.dispose();
    resetConfirmPasswordController.dispose();
    otpController.dispose();
    return super.close();
  }
}
