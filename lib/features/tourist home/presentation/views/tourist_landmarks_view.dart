import 'package:beyond_the_pramids/core/constants/app_color.dart';
import 'package:beyond_the_pramids/core/utils/size_config.dart';
import 'package:beyond_the_pramids/core/services/service_locator.dart';
import 'package:beyond_the_pramids/features/guide%20home/presentation/views/widgets/guide_home_search_field.dart';
import 'package:beyond_the_pramids/features/tourist%20home/data/repo/tourist_favorites_repo.dart';
import 'package:beyond_the_pramids/features/tourist%20home/presentation/manager/tourist_landmarks_cubit/tourist_landmarks_cubit.dart';
import 'package:beyond_the_pramids/features/tourist%20home/presentation/views/widgets/tourist_landmark_card.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TouristLandmarksView extends StatefulWidget {
  const TouristLandmarksView({super.key});

  @override
  State<TouristLandmarksView> createState() => _TouristLandmarksViewState();
}

class _TouristLandmarksViewState extends State<TouristLandmarksView> {
  final Set<int> _favoriteLandmarks = <int>{};
  final Set<int> _savingFavorites = <int>{};
  String _searchQuery = '';
  late final TouristFavoritesRepo _favoritesRepo;

  @override
  void initState() {
    super.initState();
    _favoritesRepo = sl<TouristFavoritesRepo>();
    _loadFavoriteLandmarks();
  }

  Future<void> _loadFavoriteLandmarks() async {
    try {
      final favorites = await _favoritesRepo.getFavoriteLandmarks();
      if (!mounted) return;
      setState(() {
        _favoriteLandmarks
          ..clear()
          ..addAll(favorites.map((item) => item.id));
      });
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return BlocProvider(
      create:
          (context) => sl<TouristLandmarksCubit>()..fetchLandmarks(),
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
            'tourist_home_iconic_landmarks'.tr(),
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
                SizedBox(height: 6.h),
                GuideHomeSearchField(
                  hintText: 'tourist_home_search'.tr(),
                  onChanged: (value) {
                    setState(() => _searchQuery = value);
                    context.read<TouristLandmarksCubit>().fetchLandmarks(
                      name: value,
                    );
                  },
                ),
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
                          return GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                '/touristLandmarkDetailsView',
                                arguments: item,
                              );
                            },
                            child: TouristLandmarkCard(
                              landmark: item,
                              isFavorite: _favoriteLandmarks.contains(item.id),
                              onFavoriteTap: () {
                                if (_savingFavorites.contains(item.id)) {
                                  return;
                                }

                                final nextValue =
                                    !_favoriteLandmarks.contains(item.id);
                                setState(() {
                                  if (nextValue) {
                                    _favoriteLandmarks.add(item.id);
                                  } else {
                                    _favoriteLandmarks.remove(item.id);
                                  }
                                  _savingFavorites.add(item.id);
                                });

                                () async {
                                  try {
                                    if (nextValue) {
                                      await _favoritesRepo.addLandmarkFavorite(
                                        landmarkId: item.id,
                                      );
                                    } else {
                                      await _favoritesRepo.removeLandmarkFavorite(
                                        landmarkId: item.id,
                                      );
                                    }
                                  } catch (e) {
                                    if (!mounted) return;
                                    setState(() {
                                      if (nextValue) {
                                        _favoriteLandmarks.remove(item.id);
                                      } else {
                                        _favoriteLandmarks.add(item.id);
                                      }
                                    });
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text(e.toString())),
                                    );
                                  } finally {
                                    if (!mounted) return;
                                    setState(
                                      () => _savingFavorites.remove(item.id),
                                    );
                                  }
                                }();
                              },
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
      ),
    );
  }
}
