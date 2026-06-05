import 'package:beyond_the_pramids/core/constants/app_color.dart';
import 'package:beyond_the_pramids/core/services/service_locator.dart';
import 'package:beyond_the_pramids/core/utils/size_config.dart';
import 'package:beyond_the_pramids/features/guide%20home/presentation/views/widgets/guide_home_search_field.dart';
import 'package:beyond_the_pramids/features/onboarding/presentation/views/widgets/custom_button.dart';
import 'package:beyond_the_pramids/features/tourist%20home/data/model/tourist_landmark_list_item.dart';
import 'package:beyond_the_pramids/features/tourist%20home/presentation/manager/tourist_landmarks_cubit/tourist_landmarks_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GuideSelectLandmarksView extends StatefulWidget {
  final List<int> initialSelectedIds;
  final void Function(List<int>)? onConfirm;

  const GuideSelectLandmarksView({
    super.key,
    this.initialSelectedIds = const [],
    this.onConfirm,
  });
  @override
  State<GuideSelectLandmarksView> createState() =>
      _GuideSelectLandmarksViewState();
}

class _GuideSelectLandmarksViewState extends State<GuideSelectLandmarksView> {
  final Set<int> _selectedLandmarkIds = <int>{};
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _selectedLandmarkIds.addAll(widget.initialSelectedIds);
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return BlocProvider(
      create: (context) => sl<TouristLandmarksCubit>()..fetchLandmarks(),
      child: Scaffold(
        appBar: AppBar(
          titleSpacing: 0,
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(
              Icons.arrow_back_ios_new_rounded,
              size: 18.sp,
              color: isDark ? Colors.white : AppColor.primaryColor,
            ),
          ),
          title: Text(
            'guide_trip_select_landmarks'.tr(),
            style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.w700,
              color: isDark ? Colors.white : AppColor.primaryColor,
            ),
          ),
        ),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            child: Column(
              children: [
                SizedBox(height: 12.h),
                Expanded(
                  child: BlocBuilder<
                    TouristLandmarksCubit,
                    TouristLandmarksState
                  >(
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
                                  isDark ? Colors.white : AppColor.primaryColor,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        );
                      }

                      final items = state.landmarks;
                      if (items.isEmpty) {
                        return Center(
                          child: Text(
                            _searchQuery.trim().isEmpty
                                ? 'tourist_home_landmarks_empty'.tr()
                                : 'tourist_landmarks_no_matches'.tr(),
                            style: TextStyle(
                              color:
                                  isDark ? Colors.white : AppColor.primaryColor,
                            ),
                          ),
                        );
                      }

                      return GridView.builder(
                        padding: EdgeInsets.only(bottom: 12.h),
                        itemCount: items.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 10.w,
                          mainAxisSpacing: 10.h,
                          childAspectRatio: 0.72,
                        ),
                        itemBuilder: (context, index) {
                          final item = items[index];
                          final isSelected = _selectedLandmarkIds.contains(
                            item.id,
                          );
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                if (isSelected) {
                                  _selectedLandmarkIds.remove(item.id);
                                } else {
                                  _selectedLandmarkIds.add(item.id);
                                }
                              });
                            },
                            child: _SelectableLandmarkCard(
                              landmark: item,
                              isSelected: isSelected,
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: SafeArea(
          top: false,
          child: Padding(
            padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 14.h),
            child: CustomButton(
              text: 'guide_done'.tr(),
              onTap: () {
                final ids = _selectedLandmarkIds.toList();
                if (widget.onConfirm != null) {
                  widget.onConfirm!(ids);
                } else {
                  Navigator.pop(context, ids);
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}

class _SelectableLandmarkCard extends StatelessWidget {
  final TouristLandmarkListItem landmark;
  final bool isSelected;

  const _SelectableLandmarkCard({
    required this.landmark,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(14.r),
      child: SizedBox(
        width: 156.w,
        child: AspectRatio(
          aspectRatio: 0.72,
          child: Stack(
            fit: StackFit.expand,
            children: [
              _LandmarkImage(imageUrl: landmark.normalizedImageUrl),
              DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      AppColor.primaryColor.withOpacity(0.03),
                      AppColor.primaryColor.withOpacity(0.25),
                      AppColor.primaryColor.withOpacity(0.82),
                    ],
                    stops: const [0.2, 0.58, 1.0],
                  ),
                ),
              ),
              Positioned(
                left: 8.w,
                right: 8.w,
                bottom: 9.h,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      landmark.name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                        height: 1.08,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Row(
                      children: [
                        Icon(
                          Icons.location_on_outlined,
                          size: 12.sp,
                          color: const Color(0xFFF8B64C),
                        ),
                        SizedBox(width: 2.w),
                        Expanded(
                          child: Text(
                            landmark.city,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 9.sp,
                              fontWeight: FontWeight.w500,
                              color: Colors.white.withOpacity(0.92),
                            ),
                          ),
                        ),
                        SizedBox(width: 4.w),
                        Text(
                          landmark.type,
                          style: TextStyle(
                            fontSize: 9.sp,
                            fontWeight: FontWeight.w700,
                            color: Colors.white.withOpacity(0.95),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              if (isSelected)
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColor.secondaryColor.withOpacity(0.32),
                      borderRadius: BorderRadius.circular(14.r),
                      border: Border.all(
                        color: AppColor.secondaryColor,
                        width: 2,
                      ),
                    ),
                    child: Center(
                      child: Container(
                        width: 34.w,
                        height: 34.w,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.9),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.check_rounded,
                          color: AppColor.secondaryColor,
                          size: 20.sp,
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _LandmarkImage extends StatelessWidget {
  final String? imageUrl;

  const _LandmarkImage({required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    if (imageUrl == null || imageUrl!.trim().isEmpty) {
      return Image.asset('assets/images/3th.jpg', fit: BoxFit.cover);
    }

    return Image.network(
      imageUrl!,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) {
        return Image.asset('assets/images/3th.jpg', fit: BoxFit.cover);
      },
    );
  }
}
