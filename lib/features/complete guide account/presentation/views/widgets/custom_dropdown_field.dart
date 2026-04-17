import 'package:beyond_the_pramids/core/constants/app_color.dart';
import 'package:beyond_the_pramids/core/utils/size_config.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class CustomDropdownField extends StatelessWidget {
  final String hint;
  final String? value;
  final List<String> items;
  final ValueChanged<String?> onChanged;
  final bool multiSelect;
  final List<String> selectedItems;
  final ValueChanged<List<String>>? onMultiChanged;
  final String Function(String)? displayMapper;

  const CustomDropdownField({
    super.key,
    required this.hint,
    required this.value,
    required this.items,
    required this.onChanged,
    this.multiSelect = false,
    this.selectedItems = const [],
    this.onMultiChanged,
    this.displayMapper,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final fieldBg = isDark ? const Color(0xFF19232D) : Colors.white;
    final textColor = isDark ? Colors.white : AppColor.primaryColor;

    if (multiSelect) {
      return GestureDetector(
        onTap: () async {
          await showModalBottomSheet(
            context: context,
            backgroundColor: Theme.of(context).cardColor,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
            ),
            builder: (_) {
              List<String> tempSelected = List.from(selectedItems);
              return StatefulBuilder(
                builder: (context, setModalState) {
                  return Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        Text(
                          'dropdown_select_areas'.tr(),
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: textColor,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Expanded(
                          child: ListView(
                            children:
                                items.map((item) {
                                  final isSelected = tempSelected.contains(
                                    item,
                                  );
                                  return CheckboxListTile(
                                    title: Text(
                                      displayMapper != null
                                          ? displayMapper!(item)
                                          : item,
                                      style: TextStyle(color: textColor),
                                    ),
                                    value: isSelected,
                                    activeColor: AppColor.primaryColor,
                                    onChanged: (checked) {
                                      setModalState(() {
                                        if (checked == true) {
                                          tempSelected.add(item);
                                        } else {
                                          tempSelected.remove(item);
                                        }
                                      });
                                    },
                                  );
                                }).toList(),
                          ),
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColor.primaryColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(24),
                            ),
                          ),
                          onPressed: () {
                            onMultiChanged?.call(tempSelected);
                            Navigator.pop(context);
                          },
                          child: Text(
                            'dropdown_done'.tr(),
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          );
        },
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
          decoration: BoxDecoration(
            color: fieldBg,
            borderRadius: BorderRadius.circular(24.r),
            border: Border.all(color: AppColor.primaryColor, width: 1.5),
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  selectedItems.isEmpty
                      ? hint
                      : selectedItems
                          .map(
                            (e) =>
                                displayMapper != null ? displayMapper!(e) : e,
                          )
                          .join(', '),
                  style: TextStyle(
                    fontSize: 14.sp,
                    color:
                        selectedItems.isEmpty
                            ? const Color(0xff929292)
                            : textColor,
                    fontWeight: FontWeight.w400,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Icon(
                Icons.keyboard_arrow_down_rounded,
                color: AppColor.secondaryColor,
              ),
            ],
          ),
        ),
      );
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      decoration: BoxDecoration(
        color: fieldBg,
        borderRadius: BorderRadius.circular(24.r),
        border: Border.all(color: AppColor.primaryColor, width: 1.5),
        boxShadow: [
          BoxShadow(
            color: AppColor.primaryColor.withOpacity(0.08),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: (value != null && items.contains(value)) ? value : null,
          hint: Text(
            hint,
            style: TextStyle(
              fontSize: 14.sp,
              color: const Color(0xff929292),
              fontWeight: FontWeight.w400,
            ),
          ),
          isExpanded: true,
          icon: Icon(
            Icons.keyboard_arrow_down_rounded,
            color: AppColor.secondaryColor,
            size: 24.w,
          ),
          dropdownColor: fieldBg,
          borderRadius: BorderRadius.circular(16.r),
          elevation: 4,
          menuMaxHeight: 250.h,
          items:
              items.map((String item) {
                return DropdownMenuItem<String>(
                  value: item,
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 4.h),
                    child: Text(
                      displayMapper != null ? displayMapper!(item) : item,
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: textColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                );
              }).toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }
}
