import 'package:beyond_the_pramids/core/constants/app_color.dart';
import 'package:beyond_the_pramids/core/utils/size_config.dart';
import 'package:flutter/material.dart';

class CategoryCard extends StatelessWidget {
  const CategoryCard({
    super.key,
    required this.imageUrl,
    required this.categoryName,
    required this.isSelected,
    required this.onTap,
  });
  final String imageUrl, categoryName;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage(imageUrl), fit: BoxFit.fill),
          borderRadius: BorderRadius.circular(20.r),

          border:
              isSelected
                  ? Border.all(color: AppColor.secondaryColor, width: 2)
                  : null,
        ),
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.r),

                color:
                    isSelected
                        ? AppColor.secondaryColor.withOpacity(0.5)
                        : Colors.transparent,
              ),
            ),
            Center(
              child: Text(
                categoryName,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
