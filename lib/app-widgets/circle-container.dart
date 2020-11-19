import 'package:flutter/material.dart';

class RoundContainer extends StatelessWidget {
  final double size;
  final EdgeInsets padding;
  final EdgeInsets margin;
  final Widget child;
  final Color color;
  final double radius;
  RoundContainer({
    @required this.size,
    this.radius,
    this.child,
    this.padding,
    this.margin,
    this.color,
  });
  Widget build(BuildContext context) {
    double borderRadius = radius ?? 2;
    return Container(
      // color: color,
      width: size,
      height: size,
      padding: padding,
      margin: margin,
      decoration: BoxDecoration(
        color: color,
        border: Border(),
        boxShadow: [
          BoxShadow(color: Colors.grey[350]),
        ],
        borderRadius: BorderRadius.circular(size / borderRadius),
      ),
      child: child,
    );
  }
}
