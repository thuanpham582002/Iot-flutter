import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
              width: 200,
              height: 200,
              decoration: const BoxDecoration(shape: BoxShape.circle),
              child: ClipOval(
                  child: Image(
                      fit: BoxFit.fill,
                      image: Image.asset('assets/image/avatar.jpg').image))),
          SizedBox(height: 20), // Add some spacing
          // Display the user information
          Text(
            'Họ tên: Phạm Tiến Thuận',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10), // Add some spacing
          Text(
            'MSV: B20DCCN678',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10), // Add some spacing
          Text(
            'Lớp: D20CNPM-3',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
