import 'package:beyond_the_pramids/core/constants/app_color.dart';
import 'package:beyond_the_pramids/core/utils/size_config.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class TravelPreferenceSection extends StatefulWidget {
  const TravelPreferenceSection({super.key, required this.onChanged});
  final Function(List<String>) onChanged;

  @override
  State<TravelPreferenceSection> createState() =>
      _TravelPreferenceSectionState();
}

class _TravelPreferenceSectionState extends State<TravelPreferenceSection> {
  final Map<String, bool> _options = {
    'Prefer private tours': false,
    'Prefer group tours': false,
    'Flexible schedule': false,
    'Fixed schedule': false,
  };

  static const Map<String, String> _translationKeys = {
    'Prefer private tours': 'pref_private_tours',
    'Prefer group tours': 'pref_group_tours',
    'Flexible schedule': 'pref_flexible_schedule',
    'Fixed schedule': 'pref_fixed_schedule',
  };

  @override
  Widget build(BuildContext context) {
    final keys = _options.keys.toList();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (int i = 0; i < keys.length; i++) ...[
          GestureDetector(
            onTap: () {
              setState(() => _options[keys[i]] = !_options[keys[i]]!);
              widget.onChanged(
                _options.entries
                    .where((e) => e.value)
                    .map((e) => e.key)
                    .toList(),
              );
            },
            child: Row(
              children: [
                Transform.scale(
                  scale: 1.2,
                  child: Checkbox(
                    value: _options[keys[i]],
                    activeColor: AppColor.secondaryColor,
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    visualDensity: const VisualDensity(
                      horizontal: VisualDensity.minimumDensity,
                      vertical: VisualDensity.minimumDensity,
                    ),
                    onChanged: (val) {
                      setState(() => _options[keys[i]] = val!);
                      widget.onChanged(
                        _options.entries
                            .where((e) => e.value)
                            .map((e) => e.key)
                            .toList(),
                      );
                    },
                  ),
                ),
                SizedBox(width: 8.w),
                Text(
                  (_translationKeys[keys[i]] ?? keys[i]).tr(),
                  style: TextStyle(fontSize: 16.sp),
                ),
              ],
            ),
          ),
          SizedBox(height: 8.h),
        ],
      ],
    );
  }
}
