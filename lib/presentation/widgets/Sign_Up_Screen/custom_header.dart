import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustomHeader extends StatelessWidget {
  const CustomHeader({
    super.key,
    required this.fadeAnimation,
    required this.slideAnimation,
    required this.size,
  });

  final Animation<double> fadeAnimation;
  final Animation<Offset> slideAnimation;
  final Size size;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 2,
      child: FadeTransition(
        opacity: fadeAnimation,
        child: SlideTransition(
          position: slideAnimation,
          child: Container(
            alignment: Alignment.center,
            child: SvgPicture.asset(
              'assets/images/Add User-amico.svg',
              height: size.height * 0.25,
            ),
          ),
        ),
      ),
    );
  }
}
