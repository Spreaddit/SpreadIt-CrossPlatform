import 'package:flutter/material.dart';

/// A widget representing a loader with animated dots.
///
/// This widget displays a logo followed by animated dots, each with a specified color and size.
/// The dots animate repeatedly in a loop, creating a loading effect.
///
/// Example usage:
/// ```dart
/// LoaderWidget(
///   dotSize: 10,
///   logoSize: 100,
/// )
/// ```
class LoaderWidget extends StatefulWidget {
  /// The size of each dot.
  final double dotSize;

  /// The size of the logo image.
  final double logoSize;

  /// Creates a loader widget with animated dots.
  ///
  /// The [dotSize] and [logoSize] parameters are required.
   LoaderWidget({
    required this.dotSize,
    required this.logoSize,
  });

  @override
  _LoaderWidgetState createState() => _LoaderWidgetState();
}

class _LoaderWidgetState extends State<LoaderWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 2000), // Total animation duration
    );
    _controller.repeat();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset('assets/images/LogoSpreadIt.png', width: widget.logoSize, height: widget.logoSize),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            LoaderDot(
              animation: _controller,
              color: Colors.yellowAccent,
              size: widget.dotSize,
              delay: Duration(milliseconds: 0), 
            ),
            SizedBox(width: 10),
            LoaderDot(
              animation: _controller,
              color: Colors.orangeAccent,
              size: widget.dotSize,
              delay: Duration(milliseconds: 500), 
            ),
            SizedBox(width: 10),
            LoaderDot(
              animation: _controller,
              color: Colors.redAccent,
              size: widget.dotSize,
              delay: Duration(milliseconds: 1000), 
            ),
          ],
        ),
      ],
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

/// A widget representing a single animated dot in the loader.
///
/// This widget displays a single animated dot with a specified color, size, and delay.
/// The dot animates up and down repeatedly, synchronized with the loader animation.
///
/// Example usage:
/// ```dart
/// LoaderDot(
///   animation: animationController,
///   color: Colors.blue,
///   size: 10,
///   delay: Duration(milliseconds: 500),
/// )
/// ```
class LoaderDot extends StatelessWidget {
  /// The animation controller for the loader.
  final Animation<double> animation;

  /// The color of the dot.
  final Color color;

  /// The size of the dot.
  final double size;

  /// The delay before the dot starts animating.
  final Duration delay;

  /// Creates a loader dot widget.
  ///
  /// The [animation], [color], [size], and [delay] parameters are required.
  LoaderDot({
    required this.animation,
    required this.color,
    required this.size,
    required this.delay,
  });

  @override
  Widget build(BuildContext context) {
    // Calculate the delayed animation
    final delayedAnimation = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: animation,
        curve: Interval(delay.inMilliseconds / 2000, 1.0),
      ),
    );

    return AnimatedBuilder(
      animation: delayedAnimation,
      builder: (context, child) {
        return Opacity(
          opacity: delayedAnimation.value,
          child: Transform.translate(
            offset: Offset(0, -10 * delayedAnimation.value),
            child: Container(
              width: size,
              height: size,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: color,
              ),
            ),
          ),
        );
      },
    );
  }
}
