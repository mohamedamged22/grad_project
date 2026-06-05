import 'package:beyond_the_pramids/core/network/api_service.dart';
import 'package:beyond_the_pramids/core/network/dio_client.dart';
import 'package:beyond_the_pramids/features/auth/data/repo/auth_repo.dart';
import 'package:beyond_the_pramids/features/auth/presentation/manger/auth_cubit/auth_cubit.dart';
import 'package:beyond_the_pramids/features/complete%20guide%20account/data/repo/complete_guide_account_repo.dart';
import 'package:beyond_the_pramids/features/complete%20guide%20account/presentation/views/manger/Guide%20Languages/guide_languages_cubit.dart';
import 'package:beyond_the_pramids/features/complete%20guide%20account/presentation/views/manger/Pricing/pricing_cubit.dart';
import 'package:beyond_the_pramids/features/complete%20guide%20account/presentation/views/manger/ProfessionalInfoCubit/professional_info_cubit.dart';
import 'package:beyond_the_pramids/features/complete%20guide%20account/presentation/views/manger/Verification/verification_cubit.dart';
import 'package:beyond_the_pramids/features/complete%20guide%20account/presentation/views/manger/basic%20info_cubit/basic_info_cubit.dart';
import 'package:beyond_the_pramids/features/complete%20tourist%20account/data/repo/complete_tourist_account_repo.dart';
import 'package:beyond_the_pramids/features/complete%20tourist%20account/presentation/manager/Tourist%20Basic%20Info/tourist_basic_info_cubit.dart';
import 'package:beyond_the_pramids/features/complete%20tourist%20account/presentation/manager/Trip%20Details/trip_details_cubit.dart';
import 'package:beyond_the_pramids/features/complete%20tourist%20account/presentation/manager/Travel%20Interests/travel_interests_cubit.dart';
import 'package:beyond_the_pramids/features/complete%20tourist%20account/presentation/manager/Tourist%20Preferences/tourist_preferences_cubit.dart';
import 'package:beyond_the_pramids/features/complete%20tourist%20account/presentation/manager/Tourist%20Profile%20Photo/tourist_profile_photo_cubit.dart';
import 'package:beyond_the_pramids/features/guide%20home/presentation/manger/guide_my_trip_cubit/guide_my_trip_cubit.dart';
import 'package:beyond_the_pramids/features/guide%20home/data/repo/guide_my_trip_repo.dart';
import 'package:beyond_the_pramids/features/guide%20home/data/repo/guide_profile_repo.dart';
import 'package:beyond_the_pramids/features/guide%20home/presentation/manger/guide_profile_cubit/guide_profile_cubit.dart';
import 'package:beyond_the_pramids/features/guide%20home/presentation/manger/guide_requests_cubit/guide_requests_cubit.dart';
import 'package:beyond_the_pramids/features/guide%20home/presentation/manger/guide_root_cubit/guide_root_cubit.dart';
import 'package:beyond_the_pramids/features/guide%20home/presentation/manger/profile_personal_information_cubit/profile_personal_information_cubit.dart';
import 'package:beyond_the_pramids/features/guide_create_trip/data/repo/guide_create_trip_repo.dart';
import 'package:beyond_the_pramids/features/guide_create_trip/presentation/manager/guide_create_trip_basic_cubit/guide_create_trip_basic_cubit.dart';
import 'package:beyond_the_pramids/features/guide_create_trip/presentation/manager/guide_create_trip_cover_cubit/guide_create_trip_cover_cubit.dart';
import 'package:beyond_the_pramids/features/guide_create_trip/presentation/manager/guide_last_created_trip_cubit/guide_last_created_trip_cubit.dart';
import 'package:beyond_the_pramids/features/guide_create_trip/presentation/manager/guide_create_trip_price_cubit/guide_create_trip_price_cubit.dart';
import 'package:beyond_the_pramids/features/guide_create_trip/presentation/manager/guide_create_trip_time_cubit/guide_create_trip_time_cubit.dart';
import 'package:beyond_the_pramids/features/guide_trip_map/presentation/manager/guide_trip_map_cubit.dart';
import 'package:beyond_the_pramids/features/tourist%20home/data/repo/tourist_landmark_repo.dart';
import 'package:beyond_the_pramids/features/tourist%20home/data/repo/tourist_favorites_repo.dart';
import 'package:beyond_the_pramids/features/tourist%20home/data/repo/tourist_public_trips_repo.dart';
import 'package:beyond_the_pramids/features/tourist%20home/data/repo/tourist_trip_details_repo.dart';
import 'package:beyond_the_pramids/features/tourist%20home/data/repo/tour_guide_profiles_repo.dart';
import 'package:beyond_the_pramids/features/tourist%20home/presentation/manager/tourist_landmarks_cubit/tourist_landmarks_cubit.dart';
import 'package:beyond_the_pramids/features/tourist%20home/presentation/manager/tourist_landmark_details_cubit/tourist_landmark_details_cubit.dart';
import 'package:beyond_the_pramids/features/tourist%20home/presentation/manager/tourist_landmark_trips_cubit/tourist_landmark_trips_cubit.dart';
import 'package:beyond_the_pramids/features/tourist%20home/presentation/manager/tourist_public_trips_cubit/tourist_public_trips_cubit.dart';
import 'package:beyond_the_pramids/features/tourist%20home/presentation/manager/tourist_trip_details_cubit/tourist_trip_details_cubit.dart';
import 'package:beyond_the_pramids/features/tourist%20home/presentation/manager/tourist_guides_cubit/tourist_guides_cubit.dart';
import 'package:beyond_the_pramids/features/tourist%20home/presentation/manager/tour_guide_profile_cubit/tour_guide_profile_cubit.dart';
import 'package:beyond_the_pramids/features/tourist%20home/data/repo/tourist_profile_repo.dart';
import 'package:beyond_the_pramids/features/tourist%20home/presentation/manager/tourist_profile_cubit/tourist_profile_cubit.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

void setupServiceLocator() {
  sl.registerLazySingleton<DioClient>(() => DioClient());
  sl.registerLazySingleton<ApiService>(() => ApiService(sl<DioClient>()));
  sl.registerLazySingleton<AuthRepo>(() => AuthRepo(sl<ApiService>()));
  sl.registerFactory<AuthCubit>(() => AuthCubit(sl<AuthRepo>()));
  sl.registerFactory<BasicInfoCubit>(
    () => BasicInfoCubit(sl<CompleteGuideAccountRepo>()),
  );
  sl.registerLazySingleton<CompleteGuideAccountRepo>(
    () => CompleteGuideAccountRepo(sl<ApiService>()),
  );

  sl.registerFactory<ProfessionalInfoCubit>(
    () => ProfessionalInfoCubit(sl<CompleteGuideAccountRepo>()),
  );
  sl.registerFactory<GuideLanguagesCubit>(
    () => GuideLanguagesCubit(sl<CompleteGuideAccountRepo>()),
  );
  sl.registerFactory<PricingCubit>(
    () => PricingCubit(sl<CompleteGuideAccountRepo>()),
  );
  sl.registerFactory<VerificationCubit>(
    () => VerificationCubit(sl<CompleteGuideAccountRepo>()),
  );
  sl.registerLazySingleton<CompleteTouristAccountRepo>(
    () => CompleteTouristAccountRepo(sl<ApiService>()),
  );
  sl.registerFactory<TouristBasicInfoCubit>(
    () => TouristBasicInfoCubit(sl<CompleteTouristAccountRepo>()),
  );
  sl.registerFactory<TripDetailsCubit>(
    () => TripDetailsCubit(sl<CompleteTouristAccountRepo>()),
  );
  sl.registerFactory<TravelInterestsCubit>(
    () => TravelInterestsCubit(sl<CompleteTouristAccountRepo>()),
  );
  sl.registerFactory<TouristPreferencesCubit>(
    () => TouristPreferencesCubit(sl<CompleteTouristAccountRepo>()),
  );
  sl.registerFactory<TouristProfilePhotoCubit>(
    () => TouristProfilePhotoCubit(sl<CompleteTouristAccountRepo>()),
  );
  sl.registerFactory<GuideRootCubit>(() => GuideRootCubit());
  sl.registerFactory<GuideRequestsCubit>(() => GuideRequestsCubit());
  sl.registerLazySingleton<GuideProfileRepo>(
    () => GuideProfileRepo(sl<ApiService>()),
  );
  sl.registerFactory<GuideProfileCubit>(
    () => GuideProfileCubit(sl<GuideProfileRepo>()),
  );
  sl.registerLazySingleton<GuideCreateTripRepo>(
    () => GuideCreateTripRepo(sl<ApiService>()),
  );
  sl.registerFactory<GuideCreateTripBasicCubit>(
    () => GuideCreateTripBasicCubit(sl<GuideCreateTripRepo>()),
  );
  sl.registerFactory<GuideCreateTripTimeCubit>(
    () => GuideCreateTripTimeCubit(sl<GuideCreateTripRepo>()),
  );
  sl.registerFactory<GuideCreateTripPriceCubit>(
    () => GuideCreateTripPriceCubit(sl<GuideCreateTripRepo>()),
  );
  sl.registerFactory<GuideCreateTripCoverCubit>(
    () => GuideCreateTripCoverCubit(sl<GuideCreateTripRepo>()),
  );
  sl.registerFactory<GuideLastCreatedTripCubit>(
    () => GuideLastCreatedTripCubit(sl<GuideCreateTripRepo>()),
  );
  sl.registerLazySingleton<GuideMyTripRepo>(
    () => GuideMyTripRepo(sl<ApiService>()),
  );
  sl.registerFactory<GuideMyTripCubit>(
    () => GuideMyTripCubit(sl<GuideMyTripRepo>()),
  );
  sl.registerFactory<ProfilePersonalInformationCubit>(
    () => ProfilePersonalInformationCubit(sl<GuideProfileRepo>()),
  );
  sl.registerFactory<GuideTripMapCubit>(() => GuideTripMapCubit());
  sl.registerLazySingleton<TouristLandmarkRepo>(
    () => TouristLandmarkRepo(sl<ApiService>()),
  );
  sl.registerLazySingleton<TouristFavoritesRepo>(
    () => TouristFavoritesRepo(sl<ApiService>()),
  );
  sl.registerFactory<TouristLandmarksCubit>(
    () => TouristLandmarksCubit(sl<TouristLandmarkRepo>()),
  );
  sl.registerFactory<TouristLandmarkDetailsCubit>(
    () => TouristLandmarkDetailsCubit(sl<TouristLandmarkRepo>()),
  );
  sl.registerFactory<TouristLandmarkTripsCubit>(
    () => TouristLandmarkTripsCubit(sl<TouristLandmarkRepo>()),
  );
  sl.registerLazySingleton<TouristPublicTripsRepo>(
    () => TouristPublicTripsRepo(sl<ApiService>()),
  );
  sl.registerFactory<TouristPublicTripsCubit>(
    () => TouristPublicTripsCubit(sl<TouristPublicTripsRepo>()),
  );

  sl.registerLazySingleton<TourGuideProfilesRepo>(
    () => TourGuideProfilesRepo(sl<ApiService>()),
  );
  sl.registerFactory<TouristGuidesCubit>(
    () => TouristGuidesCubit(sl<TourGuideProfilesRepo>()),
  );
  sl.registerFactory<TourGuideProfileCubit>(
    () => TourGuideProfileCubit(sl<TourGuideProfilesRepo>()),
  );
  
  sl.registerLazySingleton<TouristTripDetailsRepo>(
    () => TouristTripDetailsRepo(sl<ApiService>()),
  );
  sl.registerFactory<TouristTripDetailsCubit>(
    () => TouristTripDetailsCubit(sl<TouristTripDetailsRepo>()),
  );
  sl.registerLazySingleton<TouristProfileRepo>(
    () => TouristProfileRepo(sl<ApiService>()),
  );
  sl.registerFactory<TouristProfileCubit>(
    () => TouristProfileCubit(sl<TouristProfileRepo>()),
  );
}
