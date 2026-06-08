import 'package:beyond_the_pramids/core/constants/app_color.dart';
import 'package:beyond_the_pramids/core/utils/pref_helper.dart';
import 'package:flutter/material.dart';

class NetworkImageWithFallback extends StatelessWidget {
  final String? imageUrl;
  final BoxFit fit;
  final double? placeholderIconSize;
  final bool withAuth;

  const NetworkImageWithFallback({
    super.key,
    required this.imageUrl,
    this.fit = BoxFit.cover,
    this.placeholderIconSize,
    this.withAuth = false,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final placeholderColor =
        isDark ? const Color(0xFF1C2732) : const Color(0xFFE6EEF2);

    if (imageUrl == null || imageUrl!.trim().isEmpty) {
      return _buildPlaceholder(placeholderColor);
    }

    if (!withAuth) {
      return Image.network(
        imageUrl!,
        fit: fit,
        errorBuilder: (context, error, stackTrace) =>
            _buildPlaceholder(placeholderColor),
      );
    }

    return FutureBuilder<Map<String, String>>(
      future: _buildImageHeaders(),
      builder: (context, snapshot) {
        return Image.network(
          imageUrl!,
          headers: snapshot.data,
          fit: fit,
          errorBuilder: (context, error, stackTrace) =>
              _buildPlaceholder(placeholderColor),
        );
      },
    );
  }

  Future<Map<String, String>> _buildImageHeaders() async {
    final headers = <String, String>{
      'ngrok-skip-browser-warning': 'true',
    };
    final token = await PrefHelper.getToken();
    if (token != null && token.isNotEmpty && token != 'guest') {
      headers['Authorization'] = 'Bearer $token';
    }
    return headers;
  }

  Widget _buildPlaceholder(Color bgColor) {
    return Container(
      color: bgColor,
      alignment: Alignment.center,
      child: Icon(
        Icons.image_outlined,
        size: placeholderIconSize ?? 26,
        color: AppColor.secondaryColor,
      ),
    );
  }
}