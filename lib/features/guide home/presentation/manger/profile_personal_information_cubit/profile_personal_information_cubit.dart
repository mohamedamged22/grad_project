import 'package:bloc/bloc.dart';
import 'package:beyond_the_pramids/features/guide%20home/data/repo/guide_profile_repo.dart';
import 'package:flutter/material.dart';

part 'profile_personal_information_state.dart';

class ProfilePersonalInformationCubit
    extends Cubit<ProfilePersonalInformationState> {
  ProfilePersonalInformationCubit(this._guideProfileRepo)
    : firstNameController = TextEditingController(text: ''),
      lastNameController = TextEditingController(text: ''),
      emailController = TextEditingController(text: ''),
      phoneController = TextEditingController(text: ''),
      super(const ProfilePersonalInformationState());

  final GuideProfileRepo _guideProfileRepo;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController firstNameController;
  final TextEditingController lastNameController;
  final TextEditingController emailController;
  final TextEditingController phoneController;

  Future<void> loadInitialData({String? initialGuideName}) async {
    initializeFromGuideName(initialGuideName);

    final cachedInfo = await _guideProfileRepo.getCachedProfileInfo();
    _fillFromCachedInfo(cachedInfo);

    if (firstNameController.text.trim().isEmpty &&
        lastNameController.text.trim().isEmpty) {
      final cachedDashboard =
          await _guideProfileRepo.getCachedProfileDashboard();
      initializeFromGuideName(cachedDashboard?.guideName);
      if (cachedDashboard != null) {
        _applyProfileMeta(
          profilePhotoUrl: cachedDashboard.profilePhoto ?? '',
          title: cachedDashboard.title,
        );
      }
    }

    try {
      final profile = await _guideProfileRepo.getProfileDashboard();

      if (profile.firstName.trim().isNotEmpty) {
        firstNameController.text = profile.firstName.trim();
      }
      if (profile.lastName.trim().isNotEmpty) {
        lastNameController.text = profile.lastName.trim();
      }
      if (profile.email.trim().isNotEmpty) {
        emailController.text = profile.email.trim();
      }
      if (profile.phone.trim().isNotEmpty) {
        phoneController.text = _normalizePhoneForInput(profile.phone.trim());
      }
      _applyProfileMeta(
        profilePhotoUrl: profile.profilePhoto ?? '',
        title: profile.title,
      );
    } catch (_) {
      // Keep cached values when network profile endpoint is unavailable.
    }
  }

  void initializeFromGuideName(String? guideName) {
    if (guideName == null || guideName.trim().isEmpty) {
      return;
    }

    final parts =
        guideName
            .trim()
            .split(RegExp(r'\s+'))
            .where((part) => part.isNotEmpty)
            .toList();

    if (parts.isEmpty) {
      return;
    }

    if (firstNameController.text.trim().isEmpty) {
      firstNameController.text = parts.first;
    }

    if (lastNameController.text.trim().isEmpty && parts.length > 1) {
      lastNameController.text = parts.skip(1).join(' ');
    }
  }

  Future<bool> submitProfileUpdate() async {
    final isValid = formKey.currentState?.validate() ?? false;
    if (!isValid) {
      return false;
    }

    emit(
      state.copyWith(
        status: ProfilePersonalInformationStatus.submitting,
        clearError: true,
        clearSuccess: true,
      ),
    );

    try {
      final message = await _guideProfileRepo.updateProfile(
        firstName: firstNameController.text.trim(),
        lastName: lastNameController.text.trim(),
        email: emailController.text.trim(),
        phone: phoneController.text.trim(),
      );

      emit(
        state.copyWith(
          status: ProfilePersonalInformationStatus.success,
          successMessage: _polishSuccessMessage(message),
          clearError: true,
        ),
      );
      return true;
    } catch (e) {
      emit(
        state.copyWith(
          status: ProfilePersonalInformationStatus.failure,
          errorMessage: e.toString().replaceFirst('Exception: ', ''),
          clearSuccess: true,
        ),
      );
      return false;
    }
  }

  void _fillFromCachedInfo(Map<String, String> cachedInfo) {
    final cachedFirstName = (cachedInfo['firstName'] ?? '').trim();
    final cachedLastName = (cachedInfo['lastName'] ?? '').trim();
    final cachedEmail = (cachedInfo['email'] ?? '').trim();
    final cachedPhone = (cachedInfo['phone'] ?? '').trim();

    if (firstNameController.text.trim().isEmpty && cachedFirstName.isNotEmpty) {
      firstNameController.text = cachedFirstName;
    }
    if (lastNameController.text.trim().isEmpty && cachedLastName.isNotEmpty) {
      lastNameController.text = cachedLastName;
    }
    if (emailController.text.trim().isEmpty && cachedEmail.isNotEmpty) {
      emailController.text = cachedEmail;
    }
    if (phoneController.text.trim().isEmpty && cachedPhone.isNotEmpty) {
      phoneController.text = _normalizePhoneForInput(cachedPhone);
    }
  }

  String _normalizePhoneForInput(String value) {
    final trimmed = value.trim().replaceAll(' ', '');
    if (trimmed.startsWith('+20')) {
      return trimmed.substring(3);
    }
    if (trimmed.startsWith('20') && trimmed.length > 10) {
      return trimmed.substring(2);
    }
    return trimmed;
  }

  String _polishSuccessMessage(String message) {
    final normalized = message.trim();
    if (normalized.isEmpty) {
      return 'Your profile was updated successfully.';
    }
    return normalized[0].toUpperCase() + normalized.substring(1);
  }

  void _applyProfileMeta({
    required String profilePhotoUrl,
    required String title,
  }) {
    emit(
      state.copyWith(
        profilePhotoUrl: profilePhotoUrl.trim(),
        title: title.trim().isEmpty ? 'Licensed Guide' : title.trim(),
      ),
    );
  }

  @override
  Future<void> close() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    return super.close();
  }
}
