import 'package:flutter/material.dart';

class GradientBox extends StatefulWidget {
  final String title;
  final Color color;
  final num value;
  final num condition;
  final String suffix;

  const GradientBox({
    super.key,
    required this.title,
    required this.color,
    required this.value,
    required this.suffix,
    required this.condition,
  });

  @override
  _GradientBoxState createState() => _GradientBoxState();
}

class _GradientBoxState extends State<GradientBox>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Color?> _gradientColor;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );

    _gradientColor = ColorTween(
      begin: widget.color,
      end: Colors.red, // Color when value > 70
    ).animate(_controller);

    if (widget.value > widget.condition) {
      _controller.forward();
    }
  }

  @override
  void didUpdateWidget(covariant GradientBox oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.value > widget.condition) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 2 / 1,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: _gradientColor.value,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.red.withOpacity(0.5),
                  spreadRadius: 3,
                  blurRadius: 5,
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  widget.title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  "${widget.value}  ${widget.suffix}",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
