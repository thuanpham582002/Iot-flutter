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
          // Display the image
          Image.asset(
            'assets/image/avatar.jpg', // Replace with your image path
            width: 200, // Adjust the width as needed
            height: 200, // Adjust the height as needed
          ),
          SizedBox(height: 20), // Add some spacing
          // Display the user information
          Text(
            'Name: Pham Tien Thuan - B20DCCN678',
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
