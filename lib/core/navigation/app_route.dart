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
import 'package:beyond_the_pramids/features/complete%20tourist%20account/presentation/manager/Tourist%20Profile%20Photo/tourist_profile_photo_cubit.dart';
import 'package:beyond_the_pramids/features/complete%20tourist%20account/presentation/views/basic_information_tourist_view.dart';
import 'package:beyond_the_pramids/features/complete%20tourist%20account/presentation/views/tourist_preferences_view.dart';
import 'package:beyond_the_pramids/features/complete%20tourist%20account/presentation/views/travel_interests_view.dart';
import 'package:beyond_the_pramids/features/complete%20tourist%20account/presentation/views/trip_details_view.dart';
import 'package:beyond_the_pramids/features/complete%20tourist%20account/presentation/views/tourist_profile_photo_view.dart';
import 'package:beyond_the_pramids/features/tourist%20home/presentation/manager/tourist_profile_cubit/tourist_profile_cubit.dart';
import 'package:beyond_the_pramids/features/guide%20home/presentation/manger/guide_profile_cubit/guide_profile_cubit.dart';
import 'package:beyond_the_pramids/features/guide%20home/presentation/manger/guide_requests_cubit/guide_requests_cubit.dart';
import 'package:beyond_the_pramids/features/guide%20home/presentation/manger/guide_root_cubit/guide_root_cubit.dart';
import 'package:beyond_the_pramids/features/guide%20home/presentation/manger/profile_personal_information_cubit/profile_personal_information_cubit.dart';
import 'package:beyond_the_pramids/features/guide_create_trip/presentation/manager/guide_create_trip_basic_cubit/guide_create_trip_basic_cubit.dart';
import 'package:beyond_the_pramids/features/guide_create_trip/presentation/manager/guide_create_trip_cover_cubit/guide_create_trip_cover_cubit.dart';
import 'package:beyond_the_pramids/features/guide_create_trip/presentation/manager/guide_last_created_trip_cubit/guide_last_created_trip_cubit.dart';
import 'package:beyond_the_pramids/features/guide_create_trip/presentation/manager/guide_create_trip_price_cubit/guide_create_trip_price_cubit.dart';
import 'package:beyond_the_pramids/features/guide_create_trip/presentation/manager/guide_create_trip_time_cubit/guide_create_trip_time_cubit.dart';
import 'package:beyond_the_pramids/features/guide_create_trip/presentation/views/guide_create_trip_basic_view.dart';
import 'package:beyond_the_pramids/features/guide_create_trip/presentation/views/guide_create_trip_cover_view.dart';
import 'package:beyond_the_pramids/features/guide_create_trip/presentation/views/guide_create_trip_price_view.dart';
import 'package:beyond_the_pramids/features/guide_create_trip/presentation/views/guide_create_trip_success_view.dart';
import 'package:beyond_the_pramids/features/guide_create_trip/presentation/views/guide_create_trip_time_view.dart';
import 'package:beyond_the_pramids/features/guide_trip_map/presentation/manager/guide_trip_map_cubit.dart';
import 'package:beyond_the_pramids/features/guide_trip_map/presentation/views/guide_trip_map_view.dart';
import 'package:beyond_the_pramids/features/guide%20home/presentation/views/profile_personal_information_view.dart';
import 'package:beyond_the_pramids/features/guide%20home/presentation/views/guide_root_view.dart';
import 'package:beyond_the_pramids/features/guide%20home/presentation/views/guide_settings_view.dart';
import 'package:beyond_the_pramids/features/onboarding/presentation/views/onboarding_view_1.dart';
import 'package:beyond_the_pramids/features/onboarding/presentation/views/onboarding_view_2.dart';
import 'package:beyond_the_pramids/features/onboarding/presentation/views/onboarding_view_3.dart';
import 'package:beyond_the_pramids/features/splash/presentation/views/splash_view.dart';
import 'package:beyond_the_pramids/features/tourist%20home/data/mock/tourist_home_mock_data.dart';
import 'package:beyond_the_pramids/features/tourist%20home/data/model/tourist_landmark_list_item.dart';
import 'package:beyond_the_pramids/features/tourist%20home/data/model/tourist_public_trip.dart';
import 'package:beyond_the_pramids/features/tourist%20home/data/model/tour_guide_profile.dart';
import 'package:beyond_the_pramids/features/tourist%20home/presentation/manager/tourist_landmark_details_cubit/tourist_landmark_details_cubit.dart';
import 'package:beyond_the_pramids/features/tourist%20home/presentation/manager/tourist_landmark_trips_cubit/tourist_landmark_trips_cubit.dart';
import 'package:beyond_the_pramids/features/tourist%20home/presentation/views/tourist_landmark_details_view.dart';
import 'package:beyond_the_pramids/features/tourist%20home/presentation/views/tourist_landmarks_view.dart';
import 'package:beyond_the_pramids/features/tourist%20home/presentation/views/tour_guide_profile_view.dart';
import 'package:beyond_the_pramids/features/tourist%20home/presentation/views/tourist_root_view.dart';
import 'package:beyond_the_pramids/features/tourist%20home/presentation/views/tourist_trip_details_view.dart';
import 'package:beyond_the_pramids/features/tourist%20home/presentation/manager/tourist_trip_details_cubit/tourist_trip_details_cubit.dart';
import 'package:beyond_the_pramids/features/tourist%20home/presentation/manager/tour_guide_profile_cubit/tour_guide_profile_cubit.dart';
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
            BlocProvider(
              create:
                  (context) => sl<GuideProfileCubit>()..fetchProfileDashboard(),
            ),
          ],
          child: const GuideRootView(),
        );
        break;
      case '/touristHomeRootView':
        page = BlocProvider(
          create: (context) => sl<TouristProfileCubit>()..fetchProfile(),
          child: const TouristRootView(),
        );
        break;
      case '/touristLandmarksView':
        page = const TouristLandmarksView();
        break;
      case '/touristLandmarkDetailsView':
        final landmark = settings.arguments;
        if (landmark is TouristLandmarkListItem) {
          final args = TouristLandmarkDetailsArgs(
            id: landmark.id,
            title: landmark.name,
            city: landmark.city,
            imageUrl: landmark.normalizedImageUrl,
            rating: null,
          );
          page = MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) =>
                    sl<TouristLandmarkDetailsCubit>()
                      ..fetchLandmarkDetails(landmark.id),
              ),
              BlocProvider(
                create: (context) =>
                    sl<TouristLandmarkTripsCubit>()
                      ..fetchLandmarkTrips(landmarkId: landmark.id),
              ),
            ],
            child: TouristLandmarkDetailsView(args: args),
          );
          break;
        }
        if (landmark is TouristLandmark) {
          final args = TouristLandmarkDetailsArgs.fromMock(landmark);
          page = MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => sl<TouristLandmarkDetailsCubit>(),
              ),
              BlocProvider(
                create: (context) => sl<TouristLandmarkTripsCubit>(),
              ),
            ],
            child: TouristLandmarkDetailsView(args: args),
          );
          break;
        }
        page = Scaffold(body: Center(child: Text('no_route'.tr())));
        break;
      case '/touristTripDetailsView':
        final trip = settings.arguments;
        if (trip is TouristPublicTrip) {
          page = BlocProvider(
            create: (context) => sl<TouristTripDetailsCubit>()..fetchTripDetails(tripId: trip.id),
            child: TouristTripDetailsView(trip: trip),
          );
          break;
        }
        if (trip is TouristGroupTrip) {
          // fallback: show details built from mock trip and attempt to fetch real details
          final publicTrip = TouristPublicTrip(
            id: 0,
            title: trip.title,
            city: trip.city,
            category: trip.category,
            coverImageUrl: trip.imagePath,
            duration: trip.duration,
            status: 'PUBLIC',
            pricePerTourist: num.tryParse(
                  trip.price.replaceAll(RegExp(r'[^0-9.]'), ''),
                ) ??
                0,
          );
          page = BlocProvider(
            create: (context) => sl<TouristTripDetailsCubit>()..fetchTripDetails(tripId: publicTrip.id),
            child: TouristTripDetailsView(trip: publicTrip),
          );
          break;
        }
        page = Scaffold(body: Center(child: Text('no_route'.tr())));
        break;
      case '/tourGuideProfileView':
        final args = settings.arguments;
        final guide = args is TourGuideProfile ? args : null;
        final guideId = args is int ? args : guide?.id;
        final cubit = sl<TourGuideProfileCubit>();
        if (guideId != null) {
          cubit.fetchProfile(guideId);
          cubit.fetchGuideTrips(guideId: guideId);
        }
        page = BlocProvider(
          create: (context) => cubit,
          child: TourGuideProfileView(
            guideId: guideId,
            initialGuide: guide,
          ),
        );
        break;
      case '/guideCreateTripView':
        page = BlocProvider(
          create: (context) => sl<GuideCreateTripBasicCubit>(),
          child: const GuideCreateTripBasicView(),
        );
        break;
      case '/guideCreateTripStep2View':
        page = BlocProvider(
          create: (context) => sl<GuideCreateTripTimeCubit>(),
          child: const GuideCreateTripTimeView(),
        );
        break;
      case '/guideCreateTripStep3View':
        page = BlocProvider(
          create: (context) => sl<GuideCreateTripPriceCubit>(),
          child: const GuideCreateTripPriceView(),
        );
        break;
      case '/guideCreateTripStep4View':
        page = BlocProvider(
          create: (context) => sl<GuideCreateTripCoverCubit>(),
          child: const GuideCreateTripCoverView(),
        );
        break;
      case '/guideCreateTripSuccessView':
        page = BlocProvider(
          create:
              (context) =>
                  sl<GuideLastCreatedTripCubit>()..fetchLastCreatedTrip(),
          child: const GuideCreateTripSuccessView(),
        );
        break;
      case '/guideTripMapView':
        page = BlocProvider(
          create: (context) => sl<GuideTripMapCubit>(),
          child: GuideTripMapView(),
        );
        break;
      case '/profilePersonalInformationView':
        final guideName =
            settings.arguments is String ? settings.arguments as String : null;
        page = BlocProvider(
          create:
              (context) =>
                  sl<ProfilePersonalInformationCubit>()
                    ..loadInitialData(initialGuideName: guideName),
          child: const ProfilePersonalInformationView(),
        );
        break;
      case '/guideSettingsView':
        final args = settings.arguments;
        final cubit = args is GuideProfileCubit ? args : sl<GuideProfileCubit>();
        page = BlocProvider.value(
          value: cubit,
          child: const GuideSettingsView(),
        );
        break;
      case '/onboarding':
        page = const OnboardingView1();
        break;

      case '/successConfirmView':
        final args = settings.arguments;
        final fromProfileFlow =
            args is Map<String, dynamic> && args['fromProfileFlow'] == true;
        page = SuccessConfirmView(fromProfileFlow: fromProfileFlow);
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
          create: (context) => sl<ProfessionalInfoCubit>(),
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
      case '/touristProfilePhotoView':
      case '/touristProfilePhotoView/':
      case '/touristProfilePhoto':
        page = BlocProvider(
          create: (context) => sl<TouristProfilePhotoCubit>(),
          child: const TouristProfilePhotoView(),
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
        settings: settings,
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
        settings: settings,
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
      settings: settings,
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
