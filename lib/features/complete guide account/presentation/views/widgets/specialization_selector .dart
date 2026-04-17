// ignore: file_names
import 'package:beyond_the_pramids/core/constants/app_color.dart';
import 'package:beyond_the_pramids/core/utils/size_config.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class SpecializationSelector extends StatelessWidget {
  final List<String> selectedSpecializations;
  final ValueChanged<List<String>> onSpecializationsChanged;

  final List<String> specializations = const [
    'History',
    'Cultural',
    'Archaeology',
    'Desert Trips',
    'Religious Tourism',
  ];

  static const Map<String, String> _translationKeys = {
    'History': 'guide_spec_history',
    'Cultural': 'guide_spec_cultural',
    'Archaeology': 'guide_spec_archaeology',
    'Desert Trips': 'guide_spec_desert',
    'Religious Tourism': 'guide_spec_religious',
  };

  const SpecializationSelector({
    super.key,
    required this.selectedSpecializations,
    required this.onSpecializationsChanged,
  });

  void _toggleSpecialization(String specialization) {
    List<String> updated = List.from(selectedSpecializations);
    if (updated.contains(specialization)) {
      updated.remove(specialization);
    } else {
      updated.add(specialization);
    }
    onSpecializationsChanged(updated);
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 12.w,
      runSpacing: 12.h,
      children:
          specializations.map((spec) {
            return SpecializationChip(
              title: (_translationKeys[spec] ?? spec).tr(),
              isSelected: selectedSpecializations.contains(spec),
              onTap: () => _toggleSpecialization(spec),
            );
          }).toList(),
    );
  }
}

class SpecializationChip extends StatelessWidget {
  final String title;
  final bool isSelected;
  final VoidCallback onTap;

  const SpecializationChip({
    super.key,
    required this.title,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 20.w),
        decoration: BoxDecoration(
          color: isSelected ? AppColor.secondaryColor : Colors.transparent,
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(
            color: isSelected ? AppColor.secondaryColor : AppColor.primaryColor,
            width: 1,
          ),
        ),
        child: Text(
          title,
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
            color: isSelected ? Colors.white : AppColor.primaryColor,
          ),
        ),
      ),
    );
  }
}
