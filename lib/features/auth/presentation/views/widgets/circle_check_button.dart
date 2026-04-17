import 'package:beyond_the_pramids/core/constants/app_color.dart';
import 'package:beyond_the_pramids/core/utils/size_config.dart';
import 'package:flutter/material.dart';

class CircleCheckButton extends StatefulWidget {
  final bool initiallySelected;
  final VoidCallback? onPressed;

  const CircleCheckButton({
    super.key,
    this.initiallySelected = false,
    this.onPressed,
  });

  @override
  // ignore: library_private_types_in_public_api
  _CircleCheckButtonState createState() => _CircleCheckButtonState();
}

class _CircleCheckButtonState extends State<CircleCheckButton> {
  late bool isSelected;

  @override
  void initState() {
    super.initState();
    isSelected = widget.initiallySelected;
  }

  void toggleSelection() {
    setState(() {
      isSelected = !isSelected;
    });
    if (widget.onPressed != null) {
      widget.onPressed!();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: toggleSelection,
      child: Container(
        width: 24.w,
        height: 24.w,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: AppColor.secondaryColor, width: 3),
        ),
        child:
        // isSelected   ?
        Center(
          child: Icon(
            Icons.check,
            color: AppColor.secondaryColor,
            size: 24.w * 0.6,
          ),
        ),
        // : null,
      ),
    );
  }
}
