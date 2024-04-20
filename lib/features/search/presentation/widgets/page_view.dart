import 'package:flutter/material.dart';

class CustomPageView extends StatefulWidget {
  final List<Widget> pages;
  final int currentIndex;
  final PageController pageController;

  CustomPageView({
    required this.pages,
    required this.currentIndex,
    required this.pageController,
  });

  @override
  State<CustomPageView> createState() => _CustomPageViewState();
}

class _CustomPageViewState extends State<CustomPageView> {
  @override
  Widget build(BuildContext context) {
    print('selected index in page view: ${widget.currentIndex}');
    return PageView(
      children: widget.pages,
      controller: widget.pageController,
    );
  }
}
