import 'package:beyond_the_pramids/core/constants/app_color.dart';
import 'package:beyond_the_pramids/core/utils/size_config.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class SpecialNeedsSection extends StatefulWidget {
  const SpecialNeedsSection({super.key, required this.onChanged});
  final Function(String) onChanged;

  @override
  State<SpecialNeedsSection> createState() => _SpecialNeedsSectionState();
}

class _SpecialNeedsSectionState extends State<SpecialNeedsSection> {
  String? _selected;

  final List<String> _needs = [
    'Mobility restrictions',
    'Visual / hearing support',
    'Intellectual/invisible/chronic',
  ];

  static const Map<String, String> _translationKeys = {
    'Mobility restrictions': 'pref_mobility_restrictions',
    'Visual / hearing support': 'pref_visual_hearing',
    'Intellectual/invisible/chronic': 'pref_intellectual_chronic',
  };

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (int i = 0; i < _needs.length; i++) ...[
          GestureDetector(
            onTap: () {
              setState(() => _selected = _needs[i]);
              widget.onChanged(_needs[i]);
            },
            child: Row(
              children: [
                Transform.scale(
                  scale: 1.2,
                  child: Radio<String>(
                    value: _needs[i],
                    groupValue: _selected,
                    activeColor: AppColor.secondaryColor,
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    visualDensity: const VisualDensity(
                      horizontal: VisualDensity.minimumDensity,
                      vertical: VisualDensity.minimumDensity,
                    ),
                    onChanged: (val) {
                      setState(() => _selected = val);
                      widget.onChanged(val!);
                    },
                  ),
                ),
                SizedBox(width: 8.w),
                Text(
                  (_translationKeys[_needs[i]] ?? _needs[i]).tr(),
                  style: TextStyle(fontSize: 16.sp),
                ),
              ],
            ),
          ),
          SizedBox(height: 8.h), // ✅ هيشتغل صح دلوقتي
        ],
      ],
    );
  }
}
