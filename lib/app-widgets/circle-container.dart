import 'package:flutter/material.dart';

class RoundContainer extends StatelessWidget {
  final double size;
  final EdgeInsets padding;
  final EdgeInsets margin;
  final Widget child;
  RoundContainer({
    this.child,
    this.size,
    this.padding,
    this.margin,
  });
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      padding: padding,
      margin: margin,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(),
        boxShadow: [
          BoxShadow(color: Colors.grey[350]),
        ],
        borderRadius: BorderRadius.circular(size / 2),
      ),
      child: child,
    );
  }
}
