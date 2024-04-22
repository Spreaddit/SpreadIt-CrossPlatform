import 'package:flutter/material.dart';

class LoaderWidget extends StatefulWidget {
  final double dotSize;
  final double logoSize;

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

class LoaderDot extends StatelessWidget {
  final Animation<double> animation;
  final Color color;
  final double size;
  final Duration delay;

  LoaderDot(
      {required this.animation,
      required this.color,
      required this.size,
      required this.delay});

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
