import 'package:fade_shimmer/fade_shimmer.dart';
import 'package:flutter/material.dart';

class MyRoundImage extends StatelessWidget {
  const MyRoundImage({
    super.key,
    required this.height,
    required this.width,
    required this.imageUrl,
  });
  final double height;
  final double width;
  final String imageUrl;
  @override
  Widget build(BuildContext context) {
    return
      ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Image.network(
          imageUrl,
          fit: BoxFit.cover,
          height: height,
          width: width,
          errorBuilder: (_, __, ___) => Icon(
            Icons.broken_image,
            size: width,
          ),
          loadingBuilder: (_, __, ___) {
            // ignore: no_wildcard_variable_uses
            if (___ == null) return __;
            return FadeShimmer(
              width: width,
              height: height,
              highlightColor: Color(0xff22272f),
              baseColor: Color(0xff20252d),
            );
          },
        ),
      );
  }
}