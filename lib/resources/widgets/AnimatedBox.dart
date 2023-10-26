import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class AnimatedBox extends StatefulWidget {
  final String title;
  final String animationPath;
  final String detail;
  final Function(bool) onSwitchChanged;
  final RxBool isBlink;

  AnimatedBox({
    super.key,
    required this.title,
    required this.animationPath,
    required this.detail,
    required this.onSwitchChanged,
    required this.isBlink,
  }) {
    print("AnimatedBox: $title - $animationPath - $detail - $isBlink");
  }

  @override
  _AnimatedBoxState createState() => _AnimatedBoxState();
}

class _AnimatedBoxState extends State<AnimatedBox> {
  bool isSwitched = false;
  Color backgroundColor = const Color(0xFFB2B2B2);
  Timer? blinkTimer;
  bool isBlinking = false;

  @override
  void initState() {
    super.initState();
    print("isBlink: ${widget.isBlink}");

    blinkTimer = Timer.periodic(Duration(milliseconds: 500), (timer) {
      setState(() {
        isBlinking = !isBlinking; // Chuyển đổi trạng thái nhấp nháy
        backgroundColor = isBlinking ? Colors.red : const Color(0xFFB2B2B2);
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    blinkTimer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color:
              widget.isBlink.value ? backgroundColor : const Color(0xFFB2B2B2),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            Text(
              widget.title,
              style: const TextStyle(
                //
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
            Wrap(
              alignment: WrapAlignment.spaceBetween,
              spacing: 8.0,
              runSpacing: 4.0,
              children: [
                Text(
                  widget.detail,
                  style: const TextStyle(fontSize: 16),
                ),
                Switch(
                  value: isSwitched,
                  onChanged: (value) {
                    setState(() {
                      widget.onSwitchChanged(value);
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
