import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:beyond_the_pramids/core/navigation/navigation_service.dart';
import 'package:beyond_the_pramids/core/utils/pref_helper.dart';
import 'package:beyond_the_pramids/features/tourist%20home/data/repo/tourist_profile_repo.dart';
import 'tourist_profile_state.dart';

class TouristProfileCubit extends Cubit<TouristProfileState> {
  final TouristProfileRepo _profileRepo;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  Map<String, dynamic>? currentProfile;

  TouristProfileCubit(this._profileRepo) : super(TouristProfileInitial());

  Future<void> fetchProfile() async {
    emit(TouristProfileLoading());
    try {
      final profile = await _profileRepo.getProfile();
      currentProfile = profile;
      
      firstNameController.text = profile['firstName'] ?? '';
      lastNameController.text = profile['lastName'] ?? '';
      emailController.text = profile['email'] ?? '';
      phoneController.text = profile['phone'] ?? '';
      
      emit(TouristProfileLoaded(profile));
    } catch (e) {
      emit(TouristProfileError(e.toString()));
    }
  }

  Future<void> updateProfile() async {
    emit(TouristProfileLoading());
    try {
      final message = await _profileRepo.updateProfile(
        firstName: firstNameController.text.trim(),
        lastName: lastNameController.text.trim(),
        email: emailController.text.trim(),
        phone: phoneController.text.trim(),
      );

      final profile = await _profileRepo.getProfile();
      currentProfile = profile;

      firstNameController.text = profile['firstName'] ?? '';
      lastNameController.text = profile['lastName'] ?? '';
      emailController.text = profile['email'] ?? '';
      phoneController.text = profile['phone'] ?? '';

      emit(TouristProfileUpdateSuccess(message));
      emit(TouristProfileLoaded(profile));
    } catch (e) {
      emit(TouristProfileError(e.toString()));
    }
  }

  Future<String> signOut() async {
    await PrefHelper.clearSession();
    NavigationService.redirectToSignIn();
    return 'Signed out successfully.';
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
