import 'package:crypto_tracker/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MainLayout extends StatefulWidget {
  const MainLayout({
    Key? key,
    this.appBar,
    this.content,
    this.padding,
    this.alignment,
    this.backgroundColor,
    this.paddingTop = true,
    this.bottomNavigationBar,
    this.safeAreaBottomActivated = false,
    this.floatingActionButton,
    this.disableSafeArea = false,
    this.resizeresizeToAvoidBottomInset,
  }) : super(key: key);

  final PreferredSizeWidget? appBar;
  final Widget? content;
  final EdgeInsetsGeometry? padding;
  final AlignmentGeometry? alignment;
  final bool paddingTop;
  final Color? backgroundColor;
  final bool safeAreaBottomActivated;
  final Widget? bottomNavigationBar;
  final bool disableSafeArea;
  final FloatingActionButton? floatingActionButton;
  final bool? resizeresizeToAvoidBottomInset;

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: widget.bottomNavigationBar,
      backgroundColor: widget.backgroundColor ?? AppColors.blackBackground,
      resizeToAvoidBottomInset: widget.resizeresizeToAvoidBottomInset,
      appBar: widget.appBar,
      floatingActionButton: widget.floatingActionButton,
      body: SafeArea(
        minimum:
        widget.paddingTop ? EdgeInsets.only(top: 30.w) : EdgeInsets.zero,
        bottom: widget.safeAreaBottomActivated,
        top: !widget.disableSafeArea,
        left: !widget.disableSafeArea,
        right: !widget.disableSafeArea,
        child: Container(
          alignment: widget.alignment,
          padding: widget.padding,
          child: widget.content ?? Container(),
        ),
      ),
    );
  }
}
