import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SvgWidget extends StatelessWidget {
  final double height;
  final double width;
  final String assetPath;
  final Color color;

  SvgWidget({this.assetPath, this.height, this.width, this.color});

  @override
  Widget build(BuildContext context) {
    if (kIsWeb) {
      return Image.network(
        "$assetPath",
        width: width,
        height: height,
        color: color,
      );
    }
    return SvgPicture.asset(
      assetPath,
      width: width,
      height: height,
      color: color,
    );
  }
}
