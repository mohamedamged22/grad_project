import 'package:beyond_the_pramids/core/constants/app_color.dart';
import 'package:beyond_the_pramids/core/services/service_locator.dart';
import 'package:beyond_the_pramids/core/utils/size_config.dart';
import 'package:beyond_the_pramids/features/guide%20home/presentation/views/widgets/guide_home_search_field.dart';
import 'package:beyond_the_pramids/features/guide%20home/presentation/views/widgets/guide_home_top_bar.dart';
import 'package:beyond_the_pramids/features/guide%20home/presentation/views/widgets/guide_section_title.dart';
import 'package:beyond_the_pramids/features/tourist%20home/presentation/manager/tourist_landmarks_cubit/tourist_landmarks_cubit.dart';
import 'package:beyond_the_pramids/features/tourist%20home/presentation/manager/tourist_profile_cubit/tourist_profile_cubit.dart';
import 'package:beyond_the_pramids/features/tourist%20home/presentation/manager/tourist_profile_cubit/tourist_profile_state.dart';
import 'package:beyond_the_pramids/features/tourist%20home/presentation/manager/tourist_public_trips_cubit/tourist_public_trips_cubit.dart';
import 'package:beyond_the_pramids/features/tourist%20home/presentation/views/tourist_group_trips_view.dart';
import 'package:beyond_the_pramids/features/tourist%20home/presentation/views/widgets/tourist_group_trip_card.dart';
import 'package:beyond_the_pramids/features/tourist%20home/presentation/views/widgets/tourist_landmark_home_card.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TouristHomeView extends StatefulWidget {
  const TouristHomeView({super.key});

  @override
  State<TouristHomeView> createState() => _TouristHomeViewState();
}

class _TouristHomeViewState extends State<TouristHomeView> {
  late final TouristLandmarksCubit _landmarksCubit;
  late final TouristPublicTripsCubit _tripsCubit;
  late final TouristProfileCubit _profileCubit;

  @override
  void initState() {
    super.initState();
    _landmarksCubit = sl<TouristLandmarksCubit>()..fetchLandmarks();
    _tripsCubit = sl<TouristPublicTripsCubit>()..fetchTrips(size: 8);
    _profileCubit = sl<TouristProfileCubit>()..fetchProfile();
  }

  @override
  void dispose() {
    _landmarksCubit.close();
    _tripsCubit.close();
    _profileCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: _landmarksCubit),
        BlocProvider.value(value: _tripsCubit),
        BlocProvider.value(value: _profileCubit),
      ],
      child: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BlocBuilder<TouristProfileCubit, TouristProfileState>(
                builder: (context, state) {
                  String profilePhotoUrl = '';
                  String location = '';
                  if (state is TouristProfileLoaded) {
                    profilePhotoUrl =
                        state.profileData['profilePhoto']?.toString() ?? '';
                    location =
                        state.profileData['destinationCity']?.toString() ?? '';
                  } else {
                    final cached =
                        context.read<TouristProfileCubit>().currentProfile;
                    profilePhotoUrl =
                        cached?['profilePhoto']?.toString() ?? '';
                    location = cached?['destinationCity']?.toString() ?? '';
                  }

                  return GuideHomeTopBar(
                    location: location,
                    profilePhotoUrl: profilePhotoUrl,
                  );
                },
              ),
              SizedBox(height: 8.h),
              Text(
                'tourist_home_welcome'.tr(),
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700,
                  color: AppColor.secondaryColor,
                ),
              ),
              SizedBox(height: 10.h),
              GuideHomeSearchField(hintText: 'tourist_home_search'.tr()),
              SizedBox(height: 14.h),
              GuideSectionTitle(
                title: 'tourist_home_iconic_landmarks'.tr(),
                onTap: () {
                  Navigator.pushNamed(context, '/touristLandmarksView');
                },
              ),
              SizedBox(height: 8.h),
              SizedBox(
                height: 152.h,
                child: BlocBuilder<TouristLandmarksCubit, TouristLandmarksState>(
                  builder: (context, state) {
                    if (state.status == TouristLandmarksStatus.loading) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (state.status == TouristLandmarksStatus.failure) {
                      return Center(
                        child: Text(
                          state.errorMessage ??
                              'tourist_home_landmarks_failed'.tr(),
                          style: TextStyle(
                            color:
                                isDark
                                    ? const Color(0xFFB2C0CC)
                                    : AppColor.primaryColor,
                          ),
                        ),
                      );
                    }

                    final items = state.landmarks;
                    if (items.isEmpty) {
                      return Center(
                        child: Text(
                          'tourist_home_landmarks_empty'.tr(),
                          style: TextStyle(
                            color:
                                isDark
                                    ? const Color(0xFFB2C0CC)
                                    : AppColor.primaryColor,
                          ),
                        ),
                      );
                    }

                    return ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: items.length,
                      separatorBuilder: (_, __) => SizedBox(width: 8.w),
                      itemBuilder: (_, index) {
                        final item = items[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              '/touristLandmarkDetailsView',
                              arguments: item,
                            );
                          },
                          child: TouristLandmarkHomeCard(
                            landmark: item,
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
              SizedBox(height: 10.h),
              GuideSectionTitle(
                title: 'tourist_home_group_trips'.tr(),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const TouristGroupTripsView(),
                    ),
                  );
                },
              ),
              SizedBox(height: 10.h),
              BlocBuilder<TouristPublicTripsCubit, TouristPublicTripsState>(
                builder: (context, state) {
                  if (state.status == TouristPublicTripsStatus.loading) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (state.status == TouristPublicTripsStatus.failure) {
                    return Padding(
                      padding: EdgeInsets.symmetric(vertical: 20.h),
                      child: Center(
                        child: Text(
                          state.errorMessage ??
                              'tourist_home_trips_failed'.tr(),
                          style: TextStyle(
                            color:
                                isDark
                                    ? const Color(0xFFB2C0CC)
                                    : AppColor.primaryColor,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    );
                  }

                  if (state.trips.isEmpty) {
                    return Padding(
                      padding: EdgeInsets.symmetric(vertical: 20.h),
                      child: Center(
                        child: Text(
                          'tourist_home_trips_empty'.tr(),
                          style: TextStyle(
                            color:
                                isDark
                                    ? const Color(0xFFB2C0CC)
                                    : AppColor.primaryColor,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    );
                  }

                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: state.trips.length,
                    itemBuilder: (_, index) {
                      return TouristGroupTripCard(
                        trip: state.trips[index],
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            '/touristTripDetailsView',
                            arguments: state.trips[index],
                          );
                        },
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
