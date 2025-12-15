import 'package:flutter/material.dart';
import 'package:sehet_nono/core/utils/app_colors.dart';

class WidgetLinearColor extends StatelessWidget {
  const WidgetLinearColor({super.key, required this.widget});
  final Widget widget;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (Rect bounds) {
        return AppColors.primaryL.createShader(bounds);
      },
      blendMode: BlendMode.srcIn,
      child: widget,
    );
  }
}
