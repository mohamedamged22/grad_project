import 'package:beyond_the_pramids/core/constants/app_color.dart';
import 'package:beyond_the_pramids/core/utils/size_config.dart';
import 'package:beyond_the_pramids/features/tourist%20home/data/model/tourist_landmark_list_item.dart';
import 'package:flutter/material.dart';

class TouristLandmarkCard extends StatelessWidget {
  final TouristLandmarkListItem landmark;
  final bool isFavorite;
  final VoidCallback onFavoriteTap;

  const TouristLandmarkCard({
    super.key,
    required this.landmark,
    required this.isFavorite,
    required this.onFavoriteTap,
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
                top: 8.h,
                right: 8.w,
                child: GestureDetector(
                  onTap: onFavoriteTap,
                  child: Container(
                    width: 24.w,
                    height: 24.w,
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.28),
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white.withOpacity(0.35)),
                    ),
                    child: Icon(
                      isFavorite ? Icons.favorite : Icons.favorite_border,
                      color: isFavorite ? const Color(0xFFFF4D5B) : Colors.white,
                      size: 14.sp,
                    ),
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
                        Icon(
                          Icons.star_rounded,
                          size: 12.sp,
                          color: const Color(0xFFF8B64C),
                        ),
                        SizedBox(width: 2.w),
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
      return Image.asset('assets/images/2th.jpg', fit: BoxFit.cover);
    }

    return Image.network(
      imageUrl!,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) {
        return Image.asset('assets/images/2th.jpg', fit: BoxFit.cover);
      },
    );
  }
}
