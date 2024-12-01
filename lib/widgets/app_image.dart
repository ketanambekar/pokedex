import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppImage extends StatelessWidget {
  final String assetPath;
  final double? height;
  final double? width;
  final Color? color;
  final BoxFit fit;

  const AppImage({
    required this.assetPath,
    this.height,
    this.width,
    this.color,
    this.fit = BoxFit.cover,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    if (assetPath.startsWith('http://') || assetPath.startsWith('https://')) {
      return Image.network(
        assetPath,
        height: height,
        width: width,
        fit: fit,
        color: color,
        colorBlendMode: color != null ? BlendMode.modulate : null,
      );
    } else if (assetPath.endsWith('.svg')) {
      return SvgPicture.asset(
        assetPath,
        height: height,
        width: width,
        fit: fit,
        color: color,
      );
    } else {
      return Image.asset(
        assetPath,
        height: height,
        width: width,
        fit: fit,
        color: color,
        colorBlendMode: color != null ? BlendMode.modulate : null,
      );
    }
  }
}
