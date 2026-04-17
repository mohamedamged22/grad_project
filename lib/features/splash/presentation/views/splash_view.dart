import 'package:beyond_the_pramids/core/constants/app_color.dart';
import 'package:beyond_the_pramids/core/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView>
    with SingleTickerProviderStateMixin {
  late VideoPlayerController _controller;
  late AnimationController _logoAnimController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;
  bool _navigated = false;

  @override
  void initState() {
    super.initState();

    // Logo animation setup
    _logoAnimController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _logoAnimController, curve: Curves.easeIn),
    );
    _scaleAnimation = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(parent: _logoAnimController, curve: Curves.easeOutBack),
    );

    _controller = VideoPlayerController.asset('assets/video/splash_video.mp4')
      ..initialize().then((_) {
        if (mounted) {
          setState(() {});
          _controller.play();
          // Start logo animation after video starts
          _logoAnimController.forward();
        }
      });

    _controller
      ..setVolume(0)
      ..setLooping(false);

    _controller.addListener(_videoListener);
  }

  Future<void> _videoListener() async {
    if (!_controller.value.isInitialized || _navigated) return;

    if (_controller.value.position >= _controller.value.duration) {
      _navigated = true;

      await _controller.pause();

      await Future.delayed(const Duration(milliseconds: 200));

      if (!mounted) return;

      Navigator.pushReplacementNamed(context, '/onboarding');
    }
  }

  @override
  void dispose() {
    _controller.removeListener(_videoListener);
    _controller.dispose();
    _logoAnimController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          /// Background Video
          _controller.value.isInitialized
              ? SizedBox.expand(
                child: FittedBox(
                  fit: BoxFit.cover,
                  child: SizedBox(
                    width: _controller.value.size.width,
                    height: _controller.value.size.height,
                    child: VideoPlayer(_controller),
                  ),
                ),
              )
              : const ColoredBox(color: Colors.black),

          /// Overlay Color
          Container(color: AppColor.primaryColor.withOpacity(0.8)),

          /// Logo with fade + scale animation
          Center(
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: ScaleTransition(
                scale: _scaleAnimation,
                child: Image.asset('assets/icons/logo.png', width: 350.w),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
