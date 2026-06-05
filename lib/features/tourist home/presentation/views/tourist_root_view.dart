import 'package:beyond_the_pramids/core/constants/app_color.dart';
import 'package:beyond_the_pramids/core/utils/size_config.dart';
import 'package:beyond_the_pramids/features/tourist%20home/presentation/views/tourist_guides_view.dart';
import 'package:beyond_the_pramids/features/tourist%20home/presentation/views/tourist_home_view.dart';
import 'package:beyond_the_pramids/features/tourist%20home/presentation/views/tourist_profile_view.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TouristRootView extends StatefulWidget {
  const TouristRootView({super.key});

  @override
  State<TouristRootView> createState() => _TouristRootViewState();
}

class _TouristRootViewState extends State<TouristRootView> {
  int _currentIndex = 0;

  final _pages = const [
    TouristHomeView(),
    TouristGuidesView(),
    _TouristPlaceholderPage(titleKey: 'tourist_nav_chat'),
    TouristProfileView(),
  ];

  @override
  Widget build(BuildContext context) {
    final tabs = [
      _TouristTabData(
        label: 'tourist_nav_home'.tr(),
        assetPath: 'assets/svg/home-04.svg',
      ),
      _TouristTabData(
        label: 'tourist_nav_guides'.tr(),
        iconData: Icons.badge_outlined,
      ),
      _TouristTabData(
        label: 'tourist_nav_chat'.tr(),
        iconData: Icons.chat_bubble_outline_rounded,
      ),
      _TouristTabData(
        label: 'tourist_nav_profile'.tr(),
        assetPath: 'assets/svg/profile.svg',
      ),
    ];

    return Scaffold(
      body: IndexedStack(index: _currentIndex, children: _pages),
      bottomNavigationBar: _TouristBottomNavBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        tabs: tabs,
      ),
    );
  }
}

class _TouristTabData {
  final String label;
  final String? assetPath;
  final IconData? iconData;

  const _TouristTabData({
    required this.label,
    this.assetPath,
    this.iconData,
  });
}

class _TouristBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;
  final List<_TouristTabData> tabs;

  const _TouristBottomNavBar({
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
        padding: EdgeInsets.fromLTRB(12.w, 8.h, 12.w, 10.h),
        decoration: BoxDecoration(
          color: navBg,
          boxShadow: [
            BoxShadow(
              color: isDark ? const Color(0x33000000) : const Color(0x1A000000),
              blurRadius: 18,
              offset: const Offset(0, -4),
            ),
          ],
        ),
        child: Row(
          children: List.generate(tabs.length, (index) {
            final tab = tabs[index];
            final isSelected = index == currentIndex;
            final color = isSelected ? AppColor.secondaryColor : unselectedColor;

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
                            child: tab.assetPath != null
                                ? SvgPicture.asset(
                                    tab.assetPath!,
                                    width: 25,
                                    height: 25,
                                    colorFilter: ColorFilter.mode(
                                      color,
                                      BlendMode.srcIn,
                                    ),
                                  )
                                : Icon(
                                    tab.iconData,
                                    size: 25,
                                    color: color,
                                  ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            tab.label,
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight:
                                  isSelected ? FontWeight.w600 : FontWeight.w500,
                              color: color,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
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

class _TouristPlaceholderPage extends StatelessWidget {
  final String titleKey;

  const _TouristPlaceholderPage({required this.titleKey});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Center(
      child: Text(
        '${titleKey.tr()} (${"coming_soon".tr()})',
        style: TextStyle(
          fontSize: 18.sp,
          fontWeight: FontWeight.w700,
          color: isDark ? Colors.white : AppColor.primaryColor,
        ),
      ),
    );
  }
}
