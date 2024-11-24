import 'package:flutter/material.dart';

import 'curved_edges_top.dart';

class CurvedEdgesWidgetTop extends StatelessWidget {
  const CurvedEdgesWidgetTop({
    super.key,
    this.child,
  });

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: CustomCurvedEdgesTop(),
      child: child,
    );
  }
}