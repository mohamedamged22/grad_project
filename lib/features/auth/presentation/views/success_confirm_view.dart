import 'package:beyond_the_pramids/core/utils/size_config.dart';
import 'package:beyond_the_pramids/features/account%20type/presentation/views/widgets/custom_text_regolar.dart';
import 'package:beyond_the_pramids/features/account%20type/presentation/views/widgets/custom_text_semi_bold.dart';
import 'package:beyond_the_pramids/features/onboarding/presentation/views/widgets/custom_button.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SuccessConfirmView extends StatefulWidget {
  final bool fromProfileFlow;

  const SuccessConfirmView({super.key, this.fromProfileFlow = false});

  @override
  State<SuccessConfirmView> createState() => _SuccessConfirmViewState();
}

class _SuccessConfirmViewState extends State<SuccessConfirmView>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );
    _scaleAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.elasticOut));
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.5, curve: Curves.easeIn),
      ),
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(automaticallyImplyLeading: false),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 112.h, width: double.infinity),

            FadeTransition(
              opacity: _fadeAnimation,
              child: ScaleTransition(
                scale: _scaleAnimation,
                child: SvgPicture.asset('assets/svg/Vector.svg', height: 176.h),
              ),
            ),

            SizedBox(height: 16.h),
            FadeTransition(
              opacity: _fadeAnimation,
              child: CustomTextSemiBold(
                text: 'password_changed_title'.tr(),
                fontSize: 24,
              ),
            ),
            SizedBox(height: 4.h),
            FadeTransition(
              opacity: _fadeAnimation,
              child: CustomTextRegolar(text: 'password_changed_subtitle'.tr()),
            ),

            const Spacer(),

            CustomButton(
              text:
                  widget.fromProfileFlow
                      ? 'back_to_profile'.tr()
                      : 'back_to_login'.tr(),
              width: 260,
              onTap: () {
                if (widget.fromProfileFlow) {
                  Navigator.pop(context, true);
                  return;
                }

                Navigator.pushReplacementNamed(context, '/signInView');
              },
            ),

            SizedBox(height: 75.h),
          ],
        ),
      ),
    );
  }
}
