import 'package:flutter/material.dart';

class TapWrapper extends StatefulWidget {
  const TapWrapper({Key? key, required this.onTap, required this.child})
      : super(key: key);

  @override
  State<TapWrapper> createState() => _TapWrapperState();

  final VoidCallback onTap;
  final Widget child;
}

class _TapWrapperState extends State<TapWrapper> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: widget.child,
    );
  }
}
