import 'package:beyond_the_pramids/core/constants/app_color.dart';
import 'package:beyond_the_pramids/features/guide%20home/presentation/manger/guide_root_cubit/guide_root_cubit.dart';
import 'package:beyond_the_pramids/features/guide%20home/presentation/views/profile_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'guide_home_view.dart';
import 'guide_my_trip_view.dart';

import 'guide_requests_view.dart';

class GuideRootView extends StatelessWidget {
  const GuideRootView({super.key});

  static const List<Widget> _pages = [
    GuideHomeView(),
    RequestsView(),
    MyTripView(),
    ProfileView(),
  ];

  static const List<_GuideTabData> _tabs = [
    _GuideTabData(label: 'Home', assetPath: 'assets/svg/home-04.svg'),
    _GuideTabData(label: 'Request', assetPath: 'assets/svg/request_nav.svg'),
    _GuideTabData(label: 'My Trip', assetPath: 'assets/svg/my_trip.svg'),
    _GuideTabData(label: 'Profile', assetPath: 'assets/svg/profile.svg'),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GuideRootCubit, GuideRootState>(
      builder: (context, state) {
        return Scaffold(
          body: IndexedStack(index: state.currentIndex, children: _pages),
          bottomNavigationBar: _GuideBottomNavBar(
            currentIndex: state.currentIndex,
            onTap: (index) => context.read<GuideRootCubit>().changeTab(index),
            tabs: _tabs,
          ),
        );
      },
    );
  }
}

class _GuideTabData {
  final String label;
  final String assetPath;

  const _GuideTabData({required this.label, required this.assetPath});
}

class _GuideBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;
  final List<_GuideTabData> tabs;

  const _GuideBottomNavBar({
    required this.currentIndex,
    required this.onTap,
    required this.tabs,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final navBg = Theme.of(context).cardColor;
    final unselectedColor =
        isDark ? const Color(0xFF93A3B2) : Colors.grey.shade600;

    return SafeArea(
      top: false,
      child: Container(
        padding: const EdgeInsets.fromLTRB(12, 8, 12, 10),
        decoration: BoxDecoration(
          color: navBg,
          boxShadow: [
            BoxShadow(
              color: isDark ? const Color(0x33000000) : const Color(0x1A000000),
              blurRadius: 18,
              offset: Offset(0, -4),
            ),
          ],
        ),
        child: Row(
          children: List.generate(tabs.length, (index) {
            final tab = tabs[index];
            final isSelected = index == currentIndex;
            return Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () => onTap(index),
                    splashFactory: NoSplash.splashFactory,
                    overlayColor: WidgetStateProperty.all(Colors.transparent),
                    highlightColor: Colors.transparent,
                    borderRadius: BorderRadius.circular(14),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 220),
                      curve: Curves.easeOutCubic,
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      decoration: BoxDecoration(
                        color: navBg,
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(color: navBg),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          AnimatedScale(
                            scale: isSelected ? 1.08 : 1,
                            duration: const Duration(milliseconds: 220),
                            curve: Curves.easeOut,
                            child: SvgPicture.asset(
                              tab.assetPath,
                              width: 25,
                              height: 25,
                              colorFilter: ColorFilter.mode(
                                isSelected
                                    ? AppColor.secondaryColor
                                    : unselectedColor,
                                BlendMode.srcIn,
                              ),
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            tab.label,
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight:
                                  isSelected
                                      ? FontWeight.w600
                                      : FontWeight.w500,
                              color:
                                  isSelected
                                      ? AppColor.secondaryColor
                                      : unselectedColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
