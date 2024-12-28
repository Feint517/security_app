import 'package:flutter/material.dart';
import '../../../../utils/constants/colors.dart';
import 'circular_container.dart';

class CustomPrimaryHeaderContainer extends StatelessWidget {
  const CustomPrimaryHeaderContainer({
    super.key,
    required this.child,
    required this.height,
  });

  final Widget child;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height, //! this is not the right solution
      color: TColors.primary,
      padding: const EdgeInsets.all(0),
      child: Stack(
        children: [
          Positioned(
            top: -150,
            right: -250,
            child: CustomCircularContainer(
              backgroundColor: TColors.white.withOpacity(0.1),
            ),
          ),
          Positioned(
            top: 100,
            right: -300,
            child: CustomCircularContainer(
              backgroundColor: TColors.white.withOpacity(0.1),
            ),
          ),
          child,
        ],
      ),
    );
  }
}
