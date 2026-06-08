import 'package:beyond_the_pramids/core/constants/app_color.dart';
import 'package:beyond_the_pramids/core/utils/size_config.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class GuidePrivacyPolicyView extends StatelessWidget {
  const GuidePrivacyPolicyView({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final primaryText = isDark ? Colors.white : AppColor.primaryColor;
    final metaColor = isDark ? const Color(0xFF9DB0BF) : const Color(0xFF6E7F8D);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            size: 18.sp,
            color: AppColor.secondaryColor,
          ),
        ),
        title: Text(
          'privacy_policy'.tr(),
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w700,
            color: primaryText,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 24.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _SectionTitle(
                text: 'privacy_intro_title'.tr(),
                color: primaryText,
              ),
              SizedBox(height: 6.h),
              _SectionBody(
                text: 'privacy_intro_body'.tr(),
                color: metaColor,
              ),
              SizedBox(height: 16.h),
              _SectionTitle(
                text: 'privacy_data_collection_title'.tr(),
                color: primaryText,
              ),
              SizedBox(height: 6.h),
              _SectionBody(
                text: 'privacy_data_collection_body'.tr(),
                color: metaColor,
              ),
              SizedBox(height: 16.h),
              _SectionTitle(
                text: 'privacy_how_we_use_title'.tr(),
                color: primaryText,
              ),
              SizedBox(height: 6.h),
              _SectionBody(
                text: 'privacy_how_we_use_body'.tr(),
                color: metaColor,
              ),
              SizedBox(height: 16.h),
              _SectionTitle(
                text: 'privacy_data_sharing_title'.tr(),
                color: primaryText,
              ),
              SizedBox(height: 6.h),
              _SectionBody(
                text: 'privacy_data_sharing_body'.tr(),
                color: metaColor,
              ),
              SizedBox(height: 16.h),
              _SectionTitle(
                text: 'privacy_security_title'.tr(),
                color: primaryText,
              ),
              SizedBox(height: 6.h),
              _SectionBody(
                text: 'privacy_security_body'.tr(),
                color: metaColor,
              ),
              SizedBox(height: 16.h),
              _SectionTitle(
                text: 'privacy_rights_title'.tr(),
                color: primaryText,
              ),
              SizedBox(height: 6.h),
              _SectionBody(
                text: 'privacy_rights_body'.tr(),
                color: metaColor,
              ),
              SizedBox(height: 16.h),
              _SectionTitle(
                text: 'privacy_contact_title'.tr(),
                color: primaryText,
              ),
              SizedBox(height: 6.h),
              _SectionBody(
                text: 'privacy_contact_body'.tr(),
                color: metaColor,
              ),
              SizedBox(height: 24.h),
              Center(
                child: Text(
                  'privacy_last_updated'.tr(),
                  style: TextStyle(
                    fontSize: 10.sp,
                    color: metaColor,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String text;
  final Color color;
  const _SectionTitle({required this.text, required this.color});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 14.sp,
        fontWeight: FontWeight.w700,
        color: color,
      ),
    );
  }
}

class _SectionBody extends StatelessWidget {
  final String text;
  final Color color;
  const _SectionBody({required this.text, required this.color});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 12.sp,
        fontWeight: FontWeight.w400,
        color: color,
        height: 1.6,
      ),
    );
  }
}