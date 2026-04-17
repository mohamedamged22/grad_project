import 'package:beyond_the_pramids/core/constants/app_color.dart';
import 'package:flutter/material.dart';

class GuideTripMapPin extends StatelessWidget {
  final bool selected;

  const GuideTripMapPin({super.key, required this.selected});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Color(0x33000000),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      padding: const EdgeInsets.all(2),
      child: Icon(
        Icons.location_on_rounded,
        size: selected ? 28 : 24,
        color: selected ? AppColor.secondaryColor : const Color(0xFF9B7AC8),
      ),
    );
  }
}
