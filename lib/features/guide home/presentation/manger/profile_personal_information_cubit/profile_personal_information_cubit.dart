import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

part 'profile_personal_information_state.dart';

class ProfilePersonalInformationCubit
    extends Cubit<ProfilePersonalInformationState> {
  ProfilePersonalInformationCubit()
    : firstNameController = TextEditingController(text: ''),
      lastNameController = TextEditingController(text: ''),
      emailController = TextEditingController(text: ''),
      phoneController = TextEditingController(text: '113453767268'),
      super(const ProfilePersonalInformationState());

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController firstNameController;
  final TextEditingController lastNameController;
  final TextEditingController emailController;
  final TextEditingController phoneController;

  @override
  Future<void> close() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    return super.close();
  }
}
