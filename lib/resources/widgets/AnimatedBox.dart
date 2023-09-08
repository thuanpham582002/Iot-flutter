import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class AnimatedBox extends StatefulWidget {
  final String title;
  final String animationPath;
  final String detail;

  const AnimatedBox({
    super.key,
    required this.title,
    required this.animationPath,
    required this.detail,
  });

  @override
  _AnimatedBoxState createState() => _AnimatedBoxState();
}

class _AnimatedBoxState extends State<AnimatedBox> {
  bool isSwitched = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFFB2B2B2),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            Text(
              widget.title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 8),
            Lottie.asset(
              widget.animationPath,
              width: 100,
              height: 100,
              fit: BoxFit.cover,
              repeat: isSwitched ? true : false,
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.detail,
                  style: const TextStyle(fontSize: 16),
                ),
                Switch(
                  value: isSwitched,
                  onChanged: (value) {
                    setState(() {
                      isSwitched = value;
                    });
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
