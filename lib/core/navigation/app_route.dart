import 'package:beyond_the_pramids/core/services/service_locator.dart';
import 'package:beyond_the_pramids/features/account%20type/presentation/views/account_type_view.dart';
import 'package:beyond_the_pramids/features/auth/presentation/manger/auth_cubit/auth_cubit.dart';
import 'package:beyond_the_pramids/features/auth/presentation/views/forget_password_view.dart';
import 'package:beyond_the_pramids/features/auth/presentation/views/otp_view.dart';
import 'package:beyond_the_pramids/features/auth/presentation/views/reset_new_password_view.dart';
import 'package:beyond_the_pramids/features/auth/presentation/views/sign_in_view.dart';
import 'package:beyond_the_pramids/features/auth/presentation/views/sign_up_view.dart';
import 'package:beyond_the_pramids/features/auth/presentation/views/success_confirm_view.dart';
import 'package:beyond_the_pramids/features/complete%20guide%20account/presentation/views/basic_information_view.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:beyond_the_pramids/features/complete%20guide%20account/presentation/views/guide_languages_view.dart';
import 'package:beyond_the_pramids/features/complete%20guide%20account/presentation/views/manger/Guide%20Languages/guide_languages_cubit.dart';
import 'package:beyond_the_pramids/features/complete%20guide%20account/presentation/views/manger/Pricing/pricing_cubit.dart';
import 'package:beyond_the_pramids/features/complete%20guide%20account/presentation/views/manger/ProfessionalInfoCubit/professional_info_cubit.dart';
import 'package:beyond_the_pramids/features/complete%20guide%20account/presentation/views/manger/Verification/verification_cubit.dart';
import 'package:beyond_the_pramids/features/complete%20guide%20account/presentation/views/manger/basic%20info_cubit/basic_info_cubit.dart';
import 'package:beyond_the_pramids/features/complete%20guide%20account/presentation/views/pricing_view.dart';
import 'package:beyond_the_pramids/features/complete%20guide%20account/presentation/views/professional_information_view.dart';
import 'package:beyond_the_pramids/features/complete%20guide%20account/presentation/views/success_complete_data_view.dart';
import 'package:beyond_the_pramids/features/complete%20guide%20account/presentation/views/verification_view.dart';
import 'package:beyond_the_pramids/features/complete%20tourist%20account/presentation/manager/Tourist%20Basic%20Info/tourist_basic_info_cubit.dart';
import 'package:beyond_the_pramids/features/complete%20tourist%20account/presentation/manager/Trip%20Details/trip_details_cubit.dart';
import 'package:beyond_the_pramids/features/complete%20tourist%20account/presentation/manager/Travel%20Interests/travel_interests_cubit.dart';
import 'package:beyond_the_pramids/features/complete%20tourist%20account/presentation/manager/Tourist%20Preferences/tourist_preferences_cubit.dart';
import 'package:beyond_the_pramids/features/complete%20tourist%20account/presentation/views/basic_information_tourist_view.dart';
import 'package:beyond_the_pramids/features/complete%20tourist%20account/presentation/views/tourist_preferences_view.dart';
import 'package:beyond_the_pramids/features/complete%20tourist%20account/presentation/views/travel_interests_view.dart';
import 'package:beyond_the_pramids/features/complete%20tourist%20account/presentation/views/trip_details_view.dart';
import 'package:beyond_the_pramids/features/guide%20home/presentation/views/guide_create_new_trip_view.dart';
import 'package:beyond_the_pramids/features/guide%20home/presentation/views/guide_create_new_trip_step2_view.dart';
import 'package:beyond_the_pramids/features/guide%20home/presentation/views/guide_create_new_trip_step3_view.dart';
import 'package:beyond_the_pramids/features/guide%20home/presentation/views/guide_create_new_trip_step4_view.dart';
import 'package:beyond_the_pramids/features/guide%20home/presentation/views/guide_create_new_trip_success_view.dart';
import 'package:beyond_the_pramids/features/guide%20home/presentation/manger/guide_create_new_trip_cubit/guide_create_new_trip_cubit.dart';
import 'package:beyond_the_pramids/features/guide%20home/presentation/manger/guide_create_new_trip_step2_cubit/guide_create_new_trip_step2_cubit.dart';
import 'package:beyond_the_pramids/features/guide%20home/presentation/manger/guide_create_new_trip_step3_cubit/guide_create_new_trip_step3_cubit.dart';
import 'package:beyond_the_pramids/features/guide%20home/presentation/manger/guide_profile_cubit/guide_profile_cubit.dart';
import 'package:beyond_the_pramids/features/guide%20home/presentation/manger/guide_requests_cubit/guide_requests_cubit.dart';
import 'package:beyond_the_pramids/features/guide%20home/presentation/manger/guide_root_cubit/guide_root_cubit.dart';
import 'package:beyond_the_pramids/features/guide%20home/presentation/manger/profile_personal_information_cubit/profile_personal_information_cubit.dart';
import 'package:beyond_the_pramids/features/guide_trip_map/presentation/manager/guide_trip_map_cubit.dart';
import 'package:beyond_the_pramids/features/guide_trip_map/presentation/views/guide_trip_map_view.dart';
import 'package:beyond_the_pramids/features/guide%20home/presentation/views/profile_personal_information_view.dart';
import 'package:beyond_the_pramids/features/guide%20home/presentation/views/guide_root_view.dart';
import 'package:beyond_the_pramids/features/onboarding/presentation/views/onboarding_view_1.dart';
import 'package:beyond_the_pramids/features/onboarding/presentation/views/onboarding_view_2.dart';
import 'package:beyond_the_pramids/features/onboarding/presentation/views/onboarding_view_3.dart';
import 'package:beyond_the_pramids/features/splash/presentation/views/splash_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppRoute {
  // ⭐ Singleton instance للـ AuthCubit
  static AuthCubit? _authCubit;

  static AuthCubit _getAuthCubit(BuildContext context) {
    // جرب تجيب الـ existing cubit من الـ context
    try {
      return context.read<AuthCubit>();
    } catch (e) {
      // لو مش موجود، اعمل instance جديد
      _authCubit ??= sl<AuthCubit>();
      return _authCubit!;
    }
  }

  static Route<dynamic> generate(RouteSettings settings) {
    Widget page;

    switch (settings.name) {
      case '/signInView':
        page = BlocProvider(
          create: (context) => sl<AuthCubit>(),
          child: const SignInView(),
        );
        break;

      case '/signUpView':
        page = BlocProvider(
          create: (context) => sl<AuthCubit>(),
          child: const SignUpView(),
        );
        break;

      case '/forgetPasswordView':
        page = Builder(
          builder: (context) {
            final cubit = _getAuthCubit(context);
            return BlocProvider.value(
              value: cubit,
              child: const ForgetPasswordView(),
            );
          },
        );
        break;

      case '/otpView':
        page = Builder(
          builder: (context) {
            final cubit = _getAuthCubit(context);
            return BlocProvider.value(value: cubit, child: const OtpView());
          },
        );
        break;

      case '/resetNewPasswordView':
        page = Builder(
          builder: (context) {
            final cubit = _getAuthCubit(context);
            return BlocProvider.value(
              value: cubit,
              child: const ResetNewPasswordView(),
            );
          },
        );
        break;

      case '/guideHomeRootView':
        page = MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) => sl<GuideRootCubit>()),
            BlocProvider(create: (context) => sl<GuideRequestsCubit>()),
            BlocProvider(create: (context) => sl<GuideProfileCubit>()),
          ],
          child: const GuideRootView(),
        );
        break;
      case '/guideCreateNewTripView':
        page = BlocProvider(
          create: (context) => sl<GuideCreateNewTripCubit>(),
          child: const GuideCreateNewTripView(),
        );
        break;
      case '/guideCreateNewTripStep2View':
        page = BlocProvider(
          create: (context) => sl<GuideCreateNewTripStep2Cubit>(),
          child: const GuideCreateNewTripStep2View(),
        );
        break;
      case '/guideCreateNewTripStep3View':
        page = BlocProvider(
          create: (context) => sl<GuideCreateNewTripStep3Cubit>(),
          child: const GuideCreateNewTripStep3View(),
        );
        break;
      case '/guideCreateNewTripStep4View':
        page = const GuideCreateNewTripStep4View();
        break;
      case '/guideCreateNewTripSuccessView':
        page = const GuideCreateNewTripSuccessView();
        break;
      case '/guideTripMapView':
        page = BlocProvider(
          create: (context) => sl<GuideTripMapCubit>(),
          child: GuideTripMapView(),
        );
        break;
      case '/profilePersonalInformationView':
        page = BlocProvider(
          create: (context) => sl<ProfilePersonalInformationCubit>(),
          child: const ProfilePersonalInformationView(),
        );
        break;
      case '/onboarding':
        page = const OnboardingView1();
        break;

      case '/successConfirmView':
        page = const SuccessConfirmView();
        break;

      case '/splash':
        page = const SplashView();
        break;

      case '/onboarding2':
        page = const OnboardingView2();
        break;

      case '/onboarding3':
        page = const OnboardingView3();
        break;

      case '/accountTypeView':
        page = const AccountTypeView();
        break;

      case '/basicInformationView':
        page = BlocProvider(
          create: (context) => sl<BasicInfoCubit>(),
          child: const BasicInformationView(),
        );
        break;
      case '/professionalInformationView':
        page = BlocProvider(
          create: (context) => sl<ProfessionalInfoCubit>(), // ✅
          child: const ProfessionalInformationView(),
        );
        break;
      case '/successCompleteDataView':
        page = const SuccessCompleteDataView();
        break;
      case '/touristPreferencesView':
        page = BlocProvider(
          create: (context) => sl<TouristPreferencesCubit>(),
          child: const TouristPreferencesView(),
        );
        break;
      case '/travelInterestsView':
        page = BlocProvider(
          create: (context) => sl<TravelInterestsCubit>(),
          child: const TravelInterestsView(),
        );
        break;
      case '/tripDetailsView':
        page = BlocProvider(
          create: (context) => sl<TripDetailsCubit>(),
          child: const TripDetailsView(),
        );
        break;
      case '/guideLanguagesView':
        page = BlocProvider(
          create: (context) => sl<GuideLanguagesCubit>(),
          child: const GuideLanguagesView(),
        );
        break;
      case '/verificationView':
        page = BlocProvider(
          create: (context) => sl<VerificationCubit>(),
          child: const VerificationView(),
        );
        break;
      case '/basicInformationTouristView':
        page = BlocProvider(
          create: (context) => sl<TouristBasicInfoCubit>()..loadBasicInfo(),
          child: const BasicInformationTouristView(),
        );
        break;
      case '/pricingView':
        page = BlocProvider(
          create: (context) => sl<PricingCubit>(),
          child: const PricingView(),
        );
        break;

      default:
        page = Scaffold(body: Center(child: Text('no_route'.tr())));
    }

    // Determine transition type based on route
    final routeName = settings.name ?? '';

    // Success screens: scale + fade (celebratory feel)
    if (routeName.contains('success') || routeName.contains('Success')) {
      return PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 500),
        pageBuilder: (_, __, ___) => page,
        transitionsBuilder: (_, animation, __, child) {
          final scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
            CurvedAnimation(parent: animation, curve: Curves.easeOutBack),
          );
          final fadeAnimation = Tween<double>(
            begin: 0.0,
            end: 1.0,
          ).animate(CurvedAnimation(parent: animation, curve: Curves.easeIn));
          return FadeTransition(
            opacity: fadeAnimation,
            child: ScaleTransition(scale: scaleAnimation, child: child),
          );
        },
      );
    }

    // Onboarding screens: horizontal slide (page flip feel)
    if (routeName.contains('onboarding')) {
      return PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 400),
        pageBuilder: (_, __, ___) => page,
        transitionsBuilder: (_, animation, __, child) {
          final slideAnimation = Tween<Offset>(
            begin: const Offset(1.0, 0.0),
            end: Offset.zero,
          ).animate(
            CurvedAnimation(parent: animation, curve: Curves.easeInOut),
          );
          return SlideTransition(position: slideAnimation, child: child);
        },
      );
    }

    // Default: subtle slide up + fade
    return PageRouteBuilder(
      transitionDuration: const Duration(milliseconds: 400),
      pageBuilder: (_, __, ___) => page,
      transitionsBuilder: (_, animation, __, child) {
        final slideAnimation = Tween<Offset>(
          begin: const Offset(0, 0.02),
          end: Offset.zero,
        ).animate(CurvedAnimation(parent: animation, curve: Curves.easeOut));

        final fadeAnimation = Tween<double>(
          begin: 0.0,
          end: 1.0,
        ).animate(CurvedAnimation(parent: animation, curve: Curves.easeIn));

        return FadeTransition(
          opacity: fadeAnimation,
          child: SlideTransition(position: slideAnimation, child: child),
        );
      },
    );
  }
}
