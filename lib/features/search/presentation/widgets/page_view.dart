import 'package:flutter/material.dart';

/// a class which renders the page views 
/// Parameters: 
/// 1) [pages] : a List of widgets of the page views to be rendered
/// 2) [currentIndex] : which is the currently selected page view
/// 3) [pageController] : responsible for rendering the required page view

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
    return PageView(
      children: widget.pages,
      controller: widget.pageController,
    );
  }
}
